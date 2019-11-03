-- Clothes n stuff
local acc = {
	tricorn = {},
	hook = {},
}

table.insert(armor.elements, "mask")
armor:register_armor("pirate:patch", {
	description = "Eye patch",
	inventory_image = "pirate_patch_inv.png",
	groups = {armor_mask = 1, armor_use = 1000},
})

minetest.register_entity("pirate:tricorn", {
	initial_properties = {
		visual = "mesh",
		visual_size = {x = 7.55, y = 7.55, z = 7.55},
		mesh = "pirate_tricorn.obj",
		textures = {"pirate_tricorn_mesh.png"},
		backface_culling = false,
	},
	on_activate = function(self, name)
		if name == "" then
			self.object:remove()
			return
		end
		local player = minetest.get_player_by_name(name)
		if not player then
			self.object:remove()
			return
		end
		self.player = name
		self.object:set_attach(player, "Head", {x = 0, y = 7, z = 0}, {x = 0, y = 0, z = 0})
	end,
	on_step = function(self)
		if not acc.tricorn[self.player] then
			self.object:remove()
		end
	end,
})

armor:register_armor("pirate:tricorn", {
	description = "Tricorn Hat",
	inventory_image = "pirate_tricorn_inv.png",
	groups = {armor_head = 1, armor_use = 1000},
	on_equip = function(player)
		local name = player:get_player_name()
		acc.tricorn[name] = true
		minetest.add_entity(player:get_pos(), "pirate:tricorn", name)
	end,
	on_unequip = function(player)
		acc.tricorn[player:get_player_name()] = nil
	end,
})

table.insert(armor.elements, "glove")
minetest.register_entity("pirate:hook", {
	initial_properties = {
		visual = "mesh",
		visual_size = {x = 7.55, y = 7.55, z = 7.55},
		mesh = "pirate_hook.obj",
		textures = {"pirate_hook_mesh.png"},
		backface_culling = false,
	},
	on_activate = function(self, name)
		if name == "" then
			self.object:remove()
			return
		end
		local player = minetest.get_player_by_name(name)
		if not player then
			self.object:remove()
			return
		end
		self.player = name
		self.object:set_attach(player, "Arm_Left", {x = 0, y = 4.75, z = 0}, {x = 0, y = 0, z = 0})
	end,
	on_step = function(self)
		if not acc.tricorn[self.player] then
			self.object:remove()
		end
	end,
})

armor:register_armor("pirate:hook", {
	description = "Hook",
	inventory_image = "pirate_hook_inv.png",
	groups = {armor_glove = 1, armor_use = 1000},
	on_equip = function(player)
		local name = player:get_player_name()
		acc.hook[name] = true
		minetest.add_entity(player:get_pos(), "pirate:hook", name)
	end,
	on_unequip = function(player)
		acc.hook[player:get_player_name()] = nil
	end,
})
