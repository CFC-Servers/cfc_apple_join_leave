gameevent.Listen( "player_disconnect" )

net.Receive( "cfc_playerconnect", function( len )
    local name = net.ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name .. " has connected to the server." )
end)

net.Receive( "cfc_playerinitialspawn", function()
    local name = net.ReadString()
    local sID = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamColor = team.GetColor( plyTeam )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamColor, name, Color( 255, 255, 255 ), " (" .. sID .. ") has spawned in the server." )
end)

local function onPlayerDisconnect()
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
