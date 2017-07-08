
-- register privs for spawn points
minetest.register_privilege("spawn1", {description = "Starting spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn2", {description = "Second spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn3", {description = "Third spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn4", {description = "Fourth spawn.", give_to_singleplayer=false})


-- function to select and move player to correct spawn
local function respawn(name)
	local spawnpos
	-- check minetest.conf file for correct coordinates depending on privs	
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
		minetest.chat_send_player(name, "No spawn point set...")
	else
		-- if spawn position found, teleport player
		local player = minetest.get_player_by_name(name)
		player:setpos(spawnpos)
		minetest.chat_send_player(name, "Teleported to Current Spawn!")
	end

	return true
end


-- spawn command
minetest.register_chatcommand("spawn", {
	description = "Teleport to current spawn point.",
	privs = {},
	func = function(name)
		respawn(name)
	end
})


-- teleports player on respawn
minetest.register_on_respawnplayer(function(player)
	if respawn(player:get_player_name()) then
		return true
	end
end)