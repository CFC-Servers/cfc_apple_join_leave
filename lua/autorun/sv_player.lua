// server side apple
if CLIENT then return end
AddCSLuaFile( "cl_player.lua"  )

if file.Exists( "apple_join_disconnect_warning/indicate.txt", "DATA" ) == false then
	file.CreateDir("apple_join_disconnect_warning")
	file.Write( "apple_join_disconnect_warning/indicate.txt", "1" )
end


//Connected
function PlayerConnectAnnouncement( ply, ip )
	for k,v in pairs(player.GetAll()) do
		umsg.Start( "PlayerConnectAnnouncement", v)
			umsg.String(ply)
			umsg.String(file.Read( "apple_join_disconnect_warning/indicate.txt" ))
		umsg.End()
	end
Msg("Player " .. ply .. " has connected to the server.\n")
end
hook.Add( "PlayerConnect", "PlayerConnectAnnouncement", PlayerConnectAnnouncement )

//Spawn
function PlayerInitialSpawnAnnouncement( ply )
	timer.Simple( 3, function()
	if !ply:IsValid() then return end
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
		--	if ply:IsBot() then return end
			umsg.Start( "PlayerInitialSpawnAnnouncement", v)
				umsg.String(ply:Nick())
				umsg.Short(ply:Team())
				umsg.String(ply:SteamID())
				umsg.String(file.Read( "apple_join_disconnect_warning/indicate.txt" ))
			umsg.End()
			else
			umsg.Start( "PlayerInitialSpawnAnnouncement2", v)
				umsg.String(ply:Nick())
				umsg.Short(ply:Team())
				umsg.String(file.Read( "apple_join_disconnect_warning/indicate.txt" ))
			umsg.End()
		end
	end
Msg("Player " .. ply:Nick() .. " has spawned in the server.\n")
end)
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawnAnnouncement", PlayerInitialSpawnAnnouncement )

 
//Disconnect
function PlayerDisconnectAnnouncement( ply )
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			if ply:IsBot() then return end
			umsg.Start( "PlayerDisconnectAnnouncement", v)
			umsg.String(ply:Nick())
			umsg.Short(ply:Team())
			umsg.String(ply:SteamID())
			umsg.String(file.Read( "apple_join_disconnect_warning/indicate.txt" ))
			umsg.End()
		else
			umsg.Start( "PlayerDisconnectAnnouncement2", v)
			umsg.String(ply:Nick())
			umsg.Short(ply:Team())
			umsg.String(file.Read( "apple_join_disconnect_warning/indicate.txt" ))
			umsg.End()
		end
	end
Msg("Player " .. ply:Nick() .. " has left the server.\n")
end
hook.Add( "PlayerDisconnected", "PlayerDisconnectAnnouncement", PlayerDisconnectAnnouncement )