// client side apple
if SERVER then return end

local shouldPlaySound = false

local function playSound( isOkayForSound, sound )
    if not tonumber(isOkayForSound) == 1 then return end
    if not shouldPlaySound then return end

    surface.PlaySound( sound )
end

local connectSound = "garrysmod/save_load4.wav"
local spawnSound = "garrysmod/save_load1.wav"
local disconnectSound = "garrysmod/save_load2.wav"
local errorSound = "garrysmod/save_load3.wav"

-- Connected
local function PlayerConnectAnnouncement( data )
    local name = data:ReadString()
    local isOkayForSound = data:ReadString()
    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name, " has connected to the server." )

    playSound( isOkayForSound, connectSound )
end
usermessage.Hook("PlayerConnectAnnouncement", PlayerConnectAnnouncement)

-- Spawn with ID
local function PlayerInitialSpawnAnnouncement( data )
    local name = data:ReadString()
    local teamcolour = team.GetColor(data:ReadShort())
    local steamid = data:ReadString()
    local isOkayForSound = data:ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has spawned in the server. Their ID is: "..steamid )

    playSound( isOkayForSound, spawnSound )
end
usermessage.Hook("PlayerInitialSpawnAnnouncement", PlayerInitialSpawnAnnouncement)

-- Spawn without ID
local function PlayerInitialSpawnAnnouncement2( data )
    local name = data:ReadString()
    local teamcolour = team.GetColor(data:ReadShort())
    local isOkayForSound = data:ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has spawned in the server." )

    playSound( isOkayForSound, spawnSound )
end
usermessage.Hook("PlayerInitialSpawnAnnouncement2", PlayerInitialSpawnAnnouncement2)

-- Disconnect
local function PlayerDisconnectAnnouncement( data )
    local name = data:ReadString()
    local teamcolour = team.GetColor(data:ReadShort())
    local steamid = data:ReadString()
    local isOkayForSound = data:ReadString()
    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has left the server. Their ID was: "..steamid )

    playSound( isOkayForSound, disconnectSound )
end
usermessage.Hook("PlayerDisconnectAnnouncement", PlayerDisconnectAnnouncement)

-- Disconnect
local function PlayerDisconnectAnnouncement2( data )
    local name = data:ReadString()
    local teamcolour = team.GetColor(data:ReadShort())
    local isOkayForSound = data:ReadString()
    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamcolour, name, Color( 255, 255, 255 ), " has left the server." )

    playSound( isOkayForSound, disconnectSound )
end
usermessage.Hook("PlayerDisconnectAnnouncement2", PlayerDisconnectAnnouncement2)

-- Error
local function PlayerJDAnnouncement( data )
    local errrodata = data:ReadString()
    chat.AddText( errrodata )
    MsgC(Color(255,0,0,0), errrodata)

    playSound( true, errorSound )
end
usermessage.Hook("PlayerJDAnnouncement", PlayerJDAnnouncement)
