
local app = {
    name = "ReplaceMe",
    version = "1.0",
    author = "ReplaceMe",
}

function app:start()
    print("Starting ReplaceMe...")
end

function app:stop()
    print("Stopping ReplaceMe...")
end

local config = {
    path = "/home/ReplaceMe/project",
    command = "ReplaceMe --start",
}
