-- Persistent toggle theme between light and dark
local M = {}

local filename = vim.fn.stdpath("state") .. "/themeswapper/state.json"

-- Reads a string from the state file.
local function read_file(file)
    local fd = assert(io.open(file, "r"))
    local data = fd:read("*a")
    fd:close()
    return data
end

-- Writes a string to the state file.
local function write_file(file, contents)
  local fd = assert(io.open(file, "w+"))
  fd:write(contents)
  fd:close()
end

-- Fetches the current background theme string from the state file.
function M.get_background()
    local data = ""
    pcall(function()
        data = vim.json.decode(read_file(filename))
    end)
    if data == "" or data == {} then
        return "light"
    end
    return data
end

-- Swaps what background color is currently configured and stores it in state as json.
function M.toggle_background()
    vim.fn.mkdir(vim.fn.fnamemodify(filename, ":p:h"), "p")
	if vim.o.background == "light" then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
    write_file(filename, vim.json.encode(vim.o.background))
end

-- Reload our settings on state file change.
local watch = vim.uv.new_fs_event()
watch:start(filename, {}, vim.schedule_wrap(function(...)
    vim.o.background = M.get_background()
end))

-- Register key binding and command.
vim.keymap.set('n', '<F12>', M.toggle_background)
vim.api.nvim_create_user_command(
    "ToggleBackground",
    M.toggle_background,
    {
	    desc = "Toggles the background between light and dark",
	    nargs = 0,
    }
)

return M
