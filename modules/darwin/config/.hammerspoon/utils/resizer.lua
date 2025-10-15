local M = {}

function M.setWindowFrame(unit, height_percentage)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screen = win:screen()
	local screen_frame = screen:frame()
	local screen_name = screen:name()

	if screen_name == "Built-in Retina Display" then
		height_percentage = 0.997
	else
		height_percentage = height_percentage
	end

	local final_h = screen_frame.h * height_percentage
	local final_y = screen_frame.y + screen_frame.h - final_h

	local new_frame = {
		x = screen_frame.x + (screen_frame.w * unit.x),
		y = final_y,
		w = screen_frame.w * unit.w,
		h = final_h,
	}

	win:setFrame(new_frame)
end

return M
