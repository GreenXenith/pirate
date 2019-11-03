-- Explody things

shooter.register_weapon("pirate:pistol", {
	description = "Pistol",
	inventory_image = "pirate_pistol.png",
	spec = {
		rounds = 200,
		range = 160,
		step = 20,
		tool_caps = {full_punch_interval = 0.5, damage_groups = {fleshy = 2}},
		groups = {snappy = 3, fleshy = 3, oddly_breakable_by_hand = 3},
		sounds = {
			shot = "shooter_shotgun",
		},
		bullet_image = "shooter_bullet.png",
		particles = {
			amount = 8,
			minsize = 0.25,
			maxsize = 0.75,
		},
	},
})

minetest.override_item("pirate:pistol", {
	wield_image = "pirate_pistol_wield.png",
})

shooter.register_weapon("pirate:musket", {
	description = "Musket",
	inventory_image = "pirate_musket.png",
	spec = {
		rounds = 30,
		range = 60,
		step = 30,
		tool_caps = {full_punch_interval = 2, damage_groups = {fleshy = 3}},
		groups = {fleshy = 2, fleshy = 3, oddly_breakable_by_hand = 3},
		sounds = {
			shot = "shooter_shotgun",
		},
		bullet_image = "shooter_bullet.png",
		particles = {
			amount = 12,
			minsize = 0.75,
			maxsize = 1.5,
		},
	},
})

minetest.override_item("pirate:musket", {
	wield_image = "pirate_musket_wield.png",
})

minetest.register_entity("pirate:bomb_entity", {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=1/8, y=1/8},
	textures = {
		"pirate_bomb_front.png",
		"pirate_bomb.png",
		"pirate_bomb.png",
		"pirate_bomb.png",
		"pirate_bomb.png",
		"pirate_bomb.png",
	},
	user = nil,
	collisionbox = {0,0,0, 0,0,0},
	on_activate = function(self, staticdata)
		if staticdata == "expired" then
			self.object:remove()
		end
	end,
	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		if self.timer > 0.2 then
			local pos = self.object:get_pos()
			local above = {x=pos.x, y=pos.y + 1, z=pos.z}
			if minetest.get_node(pos).name ~= "air" then
				if self.user then
					local player = minetest.get_player_by_name(self.user)
					if player then
						shooter.blast(above, 2, 25, 5, player)
					end
				end
				self.object:remove()
			end
			self.timer = 0
		end
	end,
	get_staticdata = function()
		return "expired"
	end,
})

minetest.register_tool("pirate:grenade", {
	description = "Coconut Bomb",
	inventory_image = "pirate_bomb_inv.png",
	on_use = function(itemstack, user, pointed_thing)
		if not minetest.setting_getbool("creative_mode") then
			itemstack:clear()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:get_pos(), pointed) < 8 then
				shooter.blast(pointed, 1, 25, 5)
				return
			end
		end
		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_horizontal()
		if pos and dir then
			pos.y = pos.y + user:get_properties().eye_height
			local obj = minetest.add_entity(pos, "pirate:bomb_entity")
			if obj then
				minetest.sound_play("shooter_throw", {object=obj})
				obj:set_velocity(vector.multiply(dir, 15))
				obj:set_acceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:set_yaw(yaw + math.pi / 2)
				local ent = obj:get_luaentity()
				if ent then
					ent.user = user:get_player_name()
				end
			end
		end
		return itemstack
	end,
})
