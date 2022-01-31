gameevent.Listen( "player_connect" )
gameevent.Listen( "player_disconnect" )
util.AddNetworkString( "cfc_playerconnect_ajl" )
util.AddNetworkString( "cfc_playerinitialspawn_ajl" )
util.AddNetworkString( "cfc_playerdisconnect_ajl" )

local function onPlayerConnect( data )
    timer.Simple( 0, function() -- Gotta wait a single tick otherwise the player doesn't exist yet, doesn't work in first load p2p
        local plyName = data.name
        local ply = Player( data.userid )
        ply.AppleConnect = CurTime()

        MsgN( "Player " .. plyName .. " has connected to the server." )

        net.Start( "cfc_playerconnect_ajl" )
            net.WriteString( plyName )
        net.Broadcast()
    end)
end

hook.Add( "player_connect", "CFC_OnPlayerConnect_AppleJoinLeave", onPlayerConnect )

local function onPlayerInitialSpawn( ply )
    if not IsValid( ply ) then return end
    local name = ply:Name()
    local steamID = ply:SteamID()

    MsgN( name .. " has spawned in the server." )

    timer.Simple( 3, function()
        local plyTeam = ply:Team()
        local joinTime = CurTime() - ( ply.AppleConnect or CurTime() )

        net.Start( "cfc_playerinitialspawn_ajl" )
            net.WriteString( name )
            net.WriteString( steamID )
            net.WriteInt( plyTeam, 11 )
            net.WriteInt( joinTime, 13 )
        net.Broadcast()
    end)
end

hook.Add( "PlayerInitialSpawn", "CFC_PlayerInitialSpawn_AppleJoinLeave", onPlayerInitialSpawn )

local function onPlayerDisconnect( data )
    local name = data.name
    local steamID = data.networkid
    local userID = data.userid
    local reason = data.reason
    local ply = Player( userID )
    local plyTeam = IsValid( ply ) and ply:Team() or TEAM_UNASSIGNED

    MsgN( "Player " .. name .. " has left the server. (" .. reason .. ")" )

    net.Start( "cfc_playerdisconnect_ajl" )
        net.WriteString( name )
        net.WriteString( steamID )
        net.WriteString( reason )
        net.WriteInt( plyTeam, 11 )
    net.Broadcast()
end

hook.Add( "player_disconnect", "CFC_OnPlayerDisconnect_AppleJoinLeave", onPlayerDisconnect )
