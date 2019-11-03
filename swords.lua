-- Sharp objects

minetest.register_tool("pirate:cutlass", {
	description = "Cutlass",
	inventory_image = "pirate_cutlass.png",
	wieldview_image = "pirate_cutlass_wield.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("pirate:dagger", {
	description = "Dagger",
	inventory_image = "pirate_dagger_inv.png",
	wield_image = "pirate_dagger.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("pirate:rapier", {
	description = "Rapier",
	inventory_image = "pirate_rapier.png",
	wieldview_image = "pirate_rapier_wield.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=65, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("pirate:spadroon", {
	description = "Spadroon",
	inventory_image = "pirate_spadroon.png",
	wieldview_image = "pirate_spadroon_wield.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})
