net.Receive( "cfc_playerconnect", function( len )
    local name = net.ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name .. " has connected to the server." )
end)

net.Receive( "cfc_playerinitialspawn", function( len )
    local ply = net.ReadEntity()
    if not IsValid( ply ) then return end

    local name = ply:Nick()
    local sID = ply:SteamID()
    local plyTeam = ply:Team()
    local teamColor = team.GetColor( plyTeam )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamColor, name, Color( 255, 255, 255 ), " (" .. sID .. ") has spawned in the server." )
end)

net.Receive( "cfc_playerdisconnect", function( len )
    local name = net.ReadString()
    local sID = net.ReadString()
    local reason = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamCol = team.GetColor( plyTeam )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamCol, name, Color( 255, 255, 255 ), " (" .. sID .. ") has left the server. (" .. reason .. ")" )
end)