util.AddNetworkString( "cfc_playerconnect" )
util.AddNetworkString( "cfc_playerinitialspawn" )
util.AddNetworkString( "cfc_playerdisconnect" )

local function onPlayerConnect( plyName )
    MsgN( "Player " .. plyName .. " has connected to the server." )

    net.Start( "cfc_playerconnect" )
        net.WriteString( plyName )
    net.Broadcast()
end

hook.Add( "PlayerConnect", "CFC_OnPlayerConnect", onPlayerConnect )

local function onPlayerInitialSpawn( ply )
    if not IsValid( ply ) then return end
    local name = ply:Name()
    local steamID = ply:SteamID()

    MsgN( name .. " has spawned in the server." )

    timer.Simple( 3, function()
        local plyTeam = ply:Team()

        net.Start( "cfc_playerinitialspawn" )
            net.WriteString( name )
            net.WriteString( steamID )
            net.WriteInt( plyTeam, 11 )
        net.Broadcast()
    end)
end

hook.Add( "PlayerInitialSpawn", "CFC_PlayerInitialSpawn", onPlayerInitialSpawn )
