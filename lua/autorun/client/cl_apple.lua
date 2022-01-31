gameevent.Listen( "player_disconnect" )

local function formatTime( seconds )
    seconds = 312
    if seconds < 61 then
        return string.format( "took %d seconds", seconds )
    end

    local minutes = math.floor( seconds / 60 )
    seconds = seconds % 60

    return string.format( "took %dm %02ds", minutes, seconds )
end

net.Receive( "cfc_playerconnect", function()
    local name = net.ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name .. " has connected to the server." )
end)

net.Receive( "cfc_playerinitialspawn", function()
    local name = net.ReadString()
    local sID = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamColor = team.GetColor( plyTeam )
    local joinTime = net.ReadInt( 13 )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamColor, name, Color( 255, 255, 255 ), " (" .. sID .. ") has spawned in the server (" .. formatTime( joinTime ) .. ")." )
end)

local function onPlayerDisconnect( data )
    local name = data.name
    local steamID = data.networkid
    local userID = data.userid
    local reason = data.reason
    local ply = Player( userID )
    local plyTeam = IsValid( ply ) and ply:Team() or TEAM_UNASSIGNED
    local teamCol = team.GetColor( plyTeam )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamCol, name, Color( 255, 255, 255 ), " (" .. steamID .. ") has left the server. (" .. reason .. ")" )
end

hook.Add( "player_disconnect", "CFC_OnPlayerDisconnect", onPlayerDisconnect )
