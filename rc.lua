require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")

-- Simple function to load additional LUA files from rc/.
function loadrc(name)
   local success
   local result
   local path = awful.util.getdir("config") .. "/rc/" .. name .. ".lua"
   success, result = pcall(function() return dofile(path) end)
   if not success then
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end
   return result
end

-- Error handling
loadrc("errors")

-- Global configuration
modkey = "Mod4"
config = {}
config.terminal = table.concat({"urxvtcd",
				"++iso14755 +sb -si -sw -j -fn fixed -sl 2000",
				"-fade 40 -sh 30 -bc -tint white -fg white -depth 32",
				"--color4 RoyalBlue --color12 RoyalBlue",
				"-bg rgba:0000/0000/0000/bbbb -fadecolor rgba:0000/0000/0000/6666"},
			       " ")
config.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.magnifier,
   awful.layout.suit.floating,
}
config.hostname = awful.util.pread('uname -n'):gsub('\n', '')

-- Remaining modules
loadrc("theme")
loadrc("start")
loadrc("bindings")
loadrc("wallpaper")
loadrc("tags")
loadrc("widgets")
loadrc("xlock")
loadrc("signals")
loadrc("rules")

root.keys(config.keys.global)
startapps()
