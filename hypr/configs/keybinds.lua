local vars = require("./configs/variables.lua")

local Super = "SUPER" -- Sets "Windows" key as main modifier
local bind = hl.bind

bind(Super .. " + CTRL + Q", hl.dsp.window.close({ window = "active" }))
bind(Super .. " + Return", hl.dsp.exec_cmd(vars.terminal))
bind(Super .. " + B", hl.dsp.exec_cmd(vars.browser))
bind(Super .. " + E", hl.dsp.exec_cmd(vars.fileManager))
bind(Super .. " + T", hl.dsp.window.float({ action = "toggle" }))
bind(Super .. " + A", hl.dsp.exec_cmd(vars.menu))
bind(Super .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
bind(Super .. " + L", hl.dsp.exec_cmd("hyprlock"))
bind(Super .. " + W", hl.dsp.exec_cmd("pkill waybar || waybar"))
bind(Super .. " + SHIFT + W", hl.dsp.exec_cmd("waydroid show-full-ui"))
bind(Super .. " + ALT + W", hl.dsp.exec_cmd("waydroid session stop"))
bind(Super .. " + SHIFT + F", function() 
	hl.dispatch(hl.dsp.window.float({ active = "set" }))
	hl.dispatch(hl.dsp.window.resize({x=1900, y=1030, relative=false}))
	hl.dispatch(hl.dsp.window.center({}))
end)

--========= Workspace Things ====================-- 

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind(Super .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    bind(Super .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

bind(Super .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({}))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

bind(Super .. " + S",         hl.dsp.workspace.toggle_special("magic"))
bind(Super .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

--===============================================--

bind(Super .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
bind(Super .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--============ Laptop Keys =====================--

bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--==============================================--
