local PATH = minetest.get_modpath(minetest.get_current_modname())
local function include(file)
	return dofile(("%s/%s.lua"):format(PATH, file:gsub("%.lua$", "")))
end

include("swords")
include("tools")

if minetest.get_modpath("shooter") then
	include("guns")
end

if minetest.get_modpath("3d_armor") then
	include("accessories")
end
