---@diagnostic disable: undefined-global

local terminal = os.getenv("TERM") or "alacritty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor
local modkey = "Mod4"


return {
	awesome    = awesome   ,
	client     = client    ,
	screen     = screen    ,
	root       = root      ,
	terminal   = terminal  ,
	editor     = editor    ,
	editor_cmd = editor_cmd,
	modkey     = modkey    ,
}
