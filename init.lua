
-- register privs for spawn points
minetest.register_privilege("spawn1", {description = "Starting spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn2", {description = "Second spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn3", {description = "Third spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn4", {description = "Fourth spawn.", give_to_singleplayer=false})


-- spawn command
minetest.register_chatcommand("spawn", {
	description = "Teleport to current spawn point.",
	privs = {},
	func = function(name)

		-- check minetest.conf file for correct coordinates depending on privs
		local player = minetest.get_player_by_name(name)
		if minetest.check_player_privs(name, {spawn4=true}) then
			spawnpos = minetest.setting_get_pos("spawn_coordinate_4")
		elseif minetest.check_player_privs(name, {spawn3=true}) then
			spawnpos = minetest.setting_get_pos("spawn_coordinate_3")
		elseif minetest.check_player_privs(name, {spawn2=true}) then
			spawnpos = minetest.setting_get_pos("spawn_coordinate_2")
		elseif minetest.check_player_privs(name, {spawn1=true}) then
			spawnpos = minetest.setting_get_pos("spawn_coordinate_1")
		end

		-- return if no valid spawn position...
		if not spawnpos then
			return false, "No spawn point set..."
		end

		-- if spawn position found, teleport player
		player:setpos(spawnpos)
		return true, "Teleported to Current Spawn!"
		
	end
})