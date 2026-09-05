require("./configs/rules.lua")
require("./configs/keybinds.lua")
local vars = require("./configs/variables.lua")
require("./configs/general.lua")
require("./configs/animations.lua")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
   hl.exec_cmd(vars.terminal)
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("waybar & hyprpaper")
   hl.exec_cmd(vars.browser)
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

