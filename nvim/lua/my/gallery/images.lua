local M = {}

local run = vim.async.run
local async = vim.async
local fs = vim.fs

local folder = "/home/ricardo/dev/test-images/"
local images = {}
local images_in_row = 25
local w = 5
local h = 3
local limit = 200

local current_tasks = {}


function M.load_content()
    local c = 0
    for name in fs.dir(folder) do
        local path = folder .. name

        images[path] = {
            bytes = vim.fn.readblob(path),
            name = name,
            id = nil,
            path = path
        }
        c = c + 1
    end
end

function M.display(index, path)
    local row = math.floor((index - 1) / images_in_row)
    local col = index - (row * images_in_row)

    local image = images[path]

    -- if image.id ~= nil then
    --     M.set_image(image.id, row, col)
    --     return
    -- end

    local id = M.set_image(image.bytes, row, col)
    image.id = id
end

function M.set_image(id_or_content, row, col)
    return vim.ui.img.set(id_or_content, {
        width = w - 1,
        height = h - 1,
        row = (row * h) + 5,
        col = (col * w) + 1,
    })
end

function M.display_images(search)
    vim.ui.img.del(math.huge)
    local paths = M.get_paths(search)
    for i, path in ipairs(paths) do
        M.display(i, path)
    end
end

function M.init_sync()
    vim.api.nvim_create_autocmd("TextChangedI", {
        callback = function()
            local line = vim.api.nvim_get_current_line()
            M.display_images(line)
        end
    })
end


---- ASYNC VERSION
function M.create_images_tasks(search)
    local paths = M.get_paths(search)
    local tasks = {}
    for i, path in ipairs(paths) do
        local task = run(function()
            async.sleep(math.random(200, 300))
            M.display(i, path)
        end)
        table.insert(tasks, task)
    end

    return tasks
end

function M.cancel_current_tasks()
    for _, t in ipairs(current_tasks) do
        t:close()
    end
end

function M.run_display_tasks(search)
    run(function()

        M.cancel_current_tasks()
        vim.ui.img.del(math.huge)

        local tasks = M.create_images_tasks(search)
        current_tasks = tasks

        for _, t in ipairs(tasks) do
            async.await(t)
        end
    end)
end

function M.get_paths(search)
    local res = vim.tbl_filter(function(i)
        return i.name:find(search)
    end, images)

    res = vim.list_slice(res, 1, limit)

    local paths = vim.tbl_map(function(i)
        return i.path
    end, res)

    return paths
end



function M.init_async()
    vim.api.nvim_create_autocmd("TextChangedI", {
        callback = function()
            local line = vim.api.nvim_get_current_line()
            M.run_display_tasks(line)
        end
    })
end

return M
