gameevent.Listen( "player_disconnect" )
util.AddNetworkString( "cfc_playerconnect" )
util.AddNetworkString( "cfc_playerinitialspawn" )
util.AddNetworkString( "cfc_playerdisconnect" )

local function onPlayerConnect( plyName, ip )
    MsgN( "Player ".. plyName .. " has connected to the server." )

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

local function onPlayerDisconnect( data )
    local name = data.name
    local steamID = data.networkid
    local userID = data.userid
    local isBot = data.bot
    local reason = data.reason
    local ply = Player( userID )
    local plyTeam = IsValid( ply ) and ply:Team() or TEAM_UNASSIGNED
    
    MsgN( "Player " .. name .. " has left the server. (" .. reason .. ")" )

    net.Start( "cfc_playerdisconnect" )
        net.WriteString( name )
        net.WriteString( steamID )
        net.WriteString( reason )
        net.WriteInt( plyTeam, 11 )
    net.Broadcast()
end

hook.Add( "player_disconnect", "CFC_OnPlayerDisconnect", onPlayerDisconnect )