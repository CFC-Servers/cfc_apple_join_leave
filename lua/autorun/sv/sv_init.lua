gameevent.Listen( "player_disconnect" )
util.AddNetworkString( "cfc_playerconnect" )
util.AddNetworkString( "cfc_playerinitialspawn" )
util.AddNetworkString( "cfc_playerdisconnect" )
local playerList = playerList or {}

local function fetchDisconnectedPlayer( steamID )
    for _, ply in pairs( playerList ) do
        if ply:SteamID() == steamID then
            table.RemoveByValue( playerList, ply )

            return ply
        end
    end
end

local function onPlayerConnect( plyName, ip )
    MsgN( "Player ".. plyName .. " has connected to the server." )

    net.Start( "cfc_playerconnect" )
        net.WriteString( plyName )
    net.Broadcast()
end

hook.Add( "PlayerConnect", "CFC_OnPlayerConnect", onPlayerConnect )

local function onPlayerInitialSpawn( ply )
    if not IsValid( ply ) then return end
    MsgN( ply:Name() .. " has spawned in the server." )
    table.insert( playerList, ply )

    net.Start( "cfc_playerinitialspawn" )
        net.WriteEntity( ply )
    net.Broadcast()
end

hook.Add( "PlayerInitialSpawn", "CFC_PlayerInitialSpawn", onPlayerInitialSpawn )

local function onPlayerDisconnect( data )
    local name = data.name
    local steamID = data.networkid
    local ply = fetchDisconnectedPlayer( steamID )
    local isBot = data.bot
    local reason = data.reason
    if isBot then return end

    MsgN( "Player " .. name .. " has left the server. (" .. reason .. ")" )

    if ply == nil then return end
    net.Start( "cfc_playerdisconnect" )
        net.WriteEntity( ply )
        net.WriteString( reason )
    net.Broadcast()
end

hook.Add( "player_disconnect", "CFC_OnPlayerDisconnect", onPlayerDisconnect )