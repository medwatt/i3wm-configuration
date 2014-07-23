-- Spawn a composoting manager
awful.util.spawn("compton --vsync opengl-swc --backend glx --glx-no-rebind-pixmap", false)

-- Start idempotent commands
local execute = {
   -- Start PulseAudio
   "pulseaudio --check || pulseaudio -D",
   "udisks-glue -p /run/user/$(id -u)/udisks-glue.pid",
   "xset -b",	-- Disable bell
   -- Enable numlock
   "numlockx on",
   -- Read resources
   "xrdb -merge " .. awful.util.getdir("config") .. "/Xresources",
   -- Default browser
   "xdg-mime default " .. config.browser .. ".desktop " ..
      "x-scheme-handler/http " ..
      "x-scheme-handler/https " ..
      "text/html",
   -- Default MIME types
   "xdg-mime default evince.desktop application/pdf",
   "xdg-mime default gpicview.desktop image/png image/x-apple-ios-png image/jpeg image/jpg image/gif"
}

os.execute(table.concat(execute, ";"))

-- Spawn various X programs
xrun("polkit-gnome-authentication-agent-1",
     "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
xrun("pidgin", "pidgin -n")
xrun("keepassx", "keepassx -min -lock")
xrun("NetworkManager Applet", "nm-applet")

if config.hostname == "neo" then
   xrun("transmission", "transmission-gtk -m")
end
