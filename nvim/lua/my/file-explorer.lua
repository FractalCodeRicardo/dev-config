-- # Uses cases
--
-- 1. Create File   -> !touch
-- 2. Create Folder -> !mkdir
-- 3. Rename   -> !mv
-- 4. Delete   -> !rm
-- 5. Cut/paste -> !mv
-- 6. Copy/paste   -> !cp

local api = vim.api
local map = vim.keymap
local fn = vim.fn
local cmd = vim.cmd
local dir = require("nvim.dir")
local cut_file = nil
local copy_file = nil

local function prompt(text)
    local res = fn.input(text)

    if not res or res == "" then
        return nil
    end

    return res
end

local function current_file()
    local line = api.nvim_get_current_line()

    if fn.filereadable(line) == 0 then
        return nil
    end

    return line
end

local function current_dir()
    return api.nvim_buf_get_name(0)
end

local function create_file(file)
    cmd("!touch " .. file)
    dir._reload()
end


local function create_folder(folder)
    cmd("!mkdir " .. folder)
    dir._reload()
end

local function create()
    local file_folder = prompt("New file/folder: ")

    if not file_folder then return end

    local is_folder = file_folder:sub(-1) == "/"

    if is_folder then
        create_folder(file_folder)
    else
        create_file(file_folder)
    end
end


local function delete()
    local file = current_file()
    if not file then return end

    cmd("!rm " ..  file)
    dir._reload()
end

local function rename()
    local file = current_file()
    if not file then return end

    local new_file = prompt("New name: ")
    if not new_file then return end

    cmd("!mv " .. file .. " " ..  new_file)
    dir._reload()
end


local function cut()
    local file = current_file()
    if not file then return end
    
    local directory = current_dir()

    print("CUT: " .. file)
    cut_file = directory .. "/" .. file
    copy_file = nil
end


local function copy()
    local file = current_file()
    if not file then return end
    
    local directory = current_dir()

    print("COPY: " .. file)
    copy_file = directory .. "/" .. file
    cut_file = nil
end

local function dest_file(file)
    local split = vim.split(file, "/")
    local name = split[#split]

    local dest = current_dir() .. "/" .. name
    return dest
end

local function cut_paste(file)
    local dest = dest_file(file)
        
    cmd("!mv " .. file .. " " .. dest)
    dir._reload()
    cut_file = nil
    copy_file = nil
end

local function copy_paste(file)
    local dest = dest_file(file)

    cmd("!cp " .. file .. " " .. dest)
    dir._reload()
    cut_file = nil
    copy_file = nil
end

local function paste()

    if cut_file then
        cut_paste(cut_file)
        return
    end

    if copy_file then
        copy_paste(copy_file)
        return
    end
end

api.nvim_create_autocmd("User", {
    pattern = "DirReadPost",
    callback = function(args)

        local opts = { buf = args.buf }

        map.set("n", "o", create, opts)
        map.set("n", "r", rename, opts)
        map.set("n", "dd", delete, opts)
        map.set("n", "cu", cut, opts)
        map.set("n", "co", copy, opts)
        map.set("n", "p", paste, opts)

    end
})
