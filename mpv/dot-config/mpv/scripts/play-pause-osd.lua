-- Show OSD on play/pause
local function on_pause_change(name, value)
	if value == true then
		mp.osd_message("⏸ Paused", 2)
	else
		mp.osd_message("▶ Playing", 2)
	end
end

mp.observe_property("pause", "bool", on_pause_change)
