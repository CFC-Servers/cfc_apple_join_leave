util.AddNetworkString( "cfc_playerconnect" )
util.AddNetworkString( "cfc_playerinitialspawn" )

local function onPlayerConnect( plyName, ip )
    MsgN( "Player ".. plyName .. " has connected to the server." )

    net.Start( "cfc_playerconnect" )
        net.WriteString( plyName )
    net.Broadcast()
end

hook.Add( "PlayerConnect", "CFC_OnPlayerConnect", onPlayerConnect )

local function onPlayerInitialSpawn( ply )
    if not IsValid( ply ) then return end

    net.Start( "cfc_playerinitialspawn" )
        net.WriteEntity( ply )
    net.Broadcast()
end

hook.Add( "PlayerInitialSpawn", "CFC_PlayerInitialSpawn", onPlayerInitialSpawn )