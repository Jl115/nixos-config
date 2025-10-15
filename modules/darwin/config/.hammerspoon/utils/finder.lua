local m = {}

function m.launchOrFallback(primary, fallback)
	local ok = hs.application.launchOrFocus(primary)
	if not ok then
		hs.application.launchOrFocus(fallback)
	end
end

return m
