net.Receive( "cfc_playerconnect", function( len )
    local name = net.ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name .. " has connected to the server." )
end)

net.Receive( "cfc_playerinitialspawn", function( len )
    local ply = net.ReadEntity()

    local name = ply:Name()
    local sID = ply:SteamID()
    local team = ply:Team()
    local teamName = team.GetName( team )
    local teamColor = team.GetColor( team )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamColor, name, Color( 255, 255, 255 ), "(" .. sID .. ") has spawned in the server." )
end)