-- Telescope (taken from minetest_game binocular mod)
local function update_player_property(player)
	local name = player:get_player_name()
	local new_zoom_fov = 0
	if player:get_wielded_item():get_name() == "pirate:telescope" then
		new_zoom_fov = 10
	end
	if player:get_properties().zoom_fov ~= new_zoom_fov then
		player:set_properties({zoom_fov = new_zoom_fov})
	end
end

minetest.register_on_joinplayer(function(player)
	update_player_property(player)
end)

local function cyclic_update()
	for _, player in ipairs(minetest.get_connected_players()) do
		update_player_property(player)
	end
	minetest.after(1, cyclic_update)
end

minetest.after(1, cyclic_update)

minetest.register_craftitem("pirate:telescope", {
	description = "Handheld Telescope",
	inventory_image = "pirate_telescope.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		update_player_property(user)
	end,
})

minetest.register_craft({
	output = "pirate:telescope",
	recipe = {
		{"default:obsidian_glass"},
		{"default:bronze_ingot"},
		{"default:obsidian_glass"},
	}
})
