// client side apple
if SERVER then return end

// Connected
function PlayerConnectAnnouncement( data )
local name = data:ReadString()
local isokayforsound = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name, " has connected to the server." )
	if tonumber(isokayforsound) == 1 then
		surface.PlaySound( "garrysmod/save_load4.wav" )
	end
end
usermessage.Hook("PlayerConnectAnnouncement", PlayerConnectAnnouncement)



// Spawn
function PlayerInitialSpawnAnnouncement( data )
local name = data:ReadString()
local teamcolour = team.GetColor(data:ReadShort())
local steamid = data:ReadString()
local isokayforsound = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has spawned in the server. Their ID is: "..steamid )
	if tonumber(isokayforsound) == 1 then
		surface.PlaySound( "garrysmod/save_load1.wav" )
	end
end
usermessage.Hook("PlayerInitialSpawnAnnouncement", PlayerInitialSpawnAnnouncement)

// Spawn
function PlayerInitialSpawnAnnouncement2( data )
local name = data:ReadString()
local teamcolour = team.GetColor(data:ReadShort())
local isokayforsound = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has spawned in the server." )
	if tonumber(isokayforsound) == 1 then
		surface.PlaySound( "garrysmod/save_load1.wav" )
	end
end
usermessage.Hook("PlayerInitialSpawnAnnouncement2", PlayerInitialSpawnAnnouncement2)



// Disconnect
function PlayerDisconnectAnnouncement( data )
local name = data:ReadString()
local teamcolour = team.GetColor(data:ReadShort())
local steamid = data:ReadString()
local isokayforsound = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has left the server. Their ID was: "..steamid )
	if tonumber(isokayforsound) == 1 then
		surface.PlaySound( "garrysmod/save_load2.wav" )
	end
end
usermessage.Hook("PlayerDisconnectAnnouncement", PlayerDisconnectAnnouncement)

// Disconnect
function PlayerDisconnectAnnouncement2( data )
local name = data:ReadString()
local teamcolour = team.GetColor(data:ReadShort())
local isokayforsound = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has left the server." )
	if tonumber(isokayforsound) == 1 then
		surface.PlaySound( "garrysmod/save_load2.wav" )
	end
end
usermessage.Hook("PlayerDisconnectAnnouncement2", PlayerDisconnectAnnouncement2)


// Error
function PlayerJDAnnouncement( data )
local errrodata = data:ReadString()
	chat.AddText( errrodata )
	MsgC(Color(255,0,0,0), errrodata)
	surface.PlaySound( "garrysmod/save_load3.wav" )
end
usermessage.Hook("PlayerJDAnnouncement", PlayerJDAnnouncement)