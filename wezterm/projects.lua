-- projects.lua
local base_dir = "C:\\Users\\Ricardo\\Desktop\\Proyectos"


local projects = {
    { id = "pos",        name = "Pos",         path = base_dir .. "\\Pos\\Pos" },
    { id = "etl",        name = "ETL",         path = base_dir .. "\\ETL" },
    { id = "pos-etl",    name = "Pos Etl",     path = base_dir .. "\\Pos\\Etl" },
    { id = "bama-etl",   name = "Bama Etl",    path = base_dir .. "\\Bamaware_etl" },
    { id = "etl",   name = "Etl",    path = base_dir .. "\\ETL" },
    { id = "chrono",   name = "Chrono",    path = base_dir .. "\\Chronoguard" },
    { id = "dev",        name = "Dev",         path = "C:\\Users\\Ricardo\\Desktop\\Ricardo\\dev-config" },
    { id = "nvim",       name = "Nvim",        path = "C:\\Users\\Ricardo\\AppData\\Local\\nvim" },
    { id = "nvim-linux", name = "Nvim linux", path = "/home/ricardo/.config/nvim/" }
}

return projects
