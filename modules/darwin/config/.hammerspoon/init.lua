hs = hs

--* OPTIONS
local options = require("config.options")

--* MODULES
local finder = require("utils.finder")
local resizer = require("utils.resizer")

-- =============================================================================
-- CONFIGURATION
-- =============================================================================
local super = options.super
local mod = options.mod
local custom_height = options.custom_height

-- =============================================================================
-- CYCLING WINDOW SIZER SETUP
-- =============================================================================

-- 1. Define the sequences of sizes for each cycle
local cycleSizes = {
	-- Cycle for 'K' key (Centered)
	center = {
		{ x = 1 / 3, y = 0, w = 1 / 3, h = 1 }, -- Center Third
		{ x = 0.25, y = 0, w = 0.5, h = 1 }, -- Center Half
		{ x = 1 / 6, y = 0, w = 2 / 3, h = 1 }, -- Center Two Thirds
		{ x = 0.125, y = 0, w = 0.75, h = 1 }, -- Center Three Fourths
	},
	-- Cycle for 'I' key (Left-Aligned)
	left = {
		{ x = 0, y = 0, w = 1 / 3, h = 1 }, -- First Third
		{ x = 0, y = 0, w = 0.5, h = 1 }, -- First Half (Left Half)
		{ x = 0, y = 0, w = 2 / 3, h = 1 }, -- First Two Thirds
		{ x = 0, y = 0, w = 0.75, h = 1 }, -- First Three Fourths
	},
	-- Cycle for ',' key (Right-Aligned)
	right = {
		{ x = 2 / 3, y = 0, w = 1 / 3, h = 1 }, -- Last Third
		{ x = 0.5, y = 0, w = 0.5, h = 1 }, -- Last Half (Right Half)
		{ x = 1 / 3, y = 0, w = 2 / 3, h = 1 }, -- Last Two Thirds
		{ x = 0.25, y = 0, w = 0.75, h = 1 }, -- Last Three Fourths
	},
	-- Cycle for 'Full Screen' enter
	full = {
		{ x = 0, y = 0, w = 1, h = 1 }, -- Full Screen
	},
}

-- 2. Keep track of the current index for each cycle
local cycleState = {
	center = 1,
	left = 1,
	right = 1,
}

-- 3. Create a generic function to handle the cycling and resizing
local function cycleResize(cycleType)
	local state = cycleState[cycleType]
	local sizes = cycleSizes[cycleType]

	-- Apply the current size
	resizer.setWindowFrame(sizes[state], custom_height)

	-- Increment the index for the next press, looping back to 1 if needed
	if state >= #sizes then
		cycleState[cycleType] = 1
	else
		cycleState[cycleType] = state + 1
	end
end

-- =============================================================================
-- APPLICATION LAUNCHERS
-- =============================================================================
hs.hotkey.bind(super, "t", function()
	hs.application.launchOrFocus("kitty")
end)
hs.hotkey.bind(super, "o", function()
	hs.application.launchOrFocus("Arc")
end)
hs.hotkey.bind(super, "w", function()
	hs.application.launchOrFocus("Warp")
end)
hs.hotkey.bind(super, "l", function()
	hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind(super, "p", function()
	finder.launchOrFallback("pgAdmin 4", "dbeaver")
end)
hs.hotkey.bind(super, "s", function()
	hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind(super, "n", function()
	hs.application.launchOrFocus("Goodnotes")
end)
hs.hotkey.bind({ "alt", "shift" }, "R", function()
	hs.reload()
end)

-- =============================================================================
-- WINDOW MANAGEMENT HOTKEYS
-- =============================================================================

-- NEW CYCLING HOTKEYS
hs.hotkey.bind(mod, "K", function()
	cycleResize("center")
end) -- Press repeatedly to cycle centered sizes
hs.hotkey.bind(mod, "I", function()
	cycleResize("left")
end) -- Press repeatedly to cycle left-aligned sizes
hs.hotkey.bind(mod, ",", function()
	cycleResize("right")
end) -- Press repeatedly to cycle right-aligned sizes

-- STATIC (NON-CYCLING) HOTKEYS
hs.hotkey.bind(mod, "J", function()
	resizer.setWindowFrame({ x = 1 / 3, y = 0, w = 1 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "H", function()
	resizer.setWindowFrame({ x = 0.125, y = 0, w = 0.75, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "L", function()
	resizer.setWindowFrame({ x = 1 / 6, y = 0, w = 2 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "Z", function()
	resizer.setWindowFrame({ x = 0, y = 0, w = 0.25, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "U", function()
	resizer.setWindowFrame({ x = 0, y = 0, w = 1 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "O", function()
	resizer.setWindowFrame({ x = 0, y = 0, w = 2 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "N", function()
	resizer.setWindowFrame({ x = 0.75, y = 0, w = 0.25, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "M", function()
	resizer.setWindowFrame({ x = 2 / 3, y = 0, w = 1 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, ".", function()
	resizer.setWindowFrame({ x = 1 / 3, y = 0, w = 2 / 3, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "'", function()
	resizer.setWindowFrame({ x = 0, y = 0, w = 0.5, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, ";", function()
	resizer.setWindowFrame({ x = 0.5, y = 0, w = 0.5, h = 1 }, custom_height)
end)
hs.hotkey.bind(mod, "return", function()
	resizer.setWindowFrame({ x = 0, y = 0, w = 1, h = 1 }, custom_height)
end) -- Press repeatedly to toggle full screen

--* INIT
hs.alert.show("Config loaded")
