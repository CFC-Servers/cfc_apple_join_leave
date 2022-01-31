local function formatTime( seconds )
    seconds = 312
    if seconds < 61 then
        return string.format( "took %d seconds", seconds )
    end

    local minutes = math.floor( seconds / 60 )
    seconds = seconds % 60

    return string.format( "took %dm %02ds", minutes, seconds )
end

net.Receive( "cfc_playerconnect_ajl", function()
    local name = net.ReadString()

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 255, 255 ), name .. " has connected to the server." )
end)

net.Receive( "cfc_playerinitialspawn_ajl", function()
    local name = net.ReadString()
    local sID = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamColor = team.GetColor( plyTeam )
    local joinTime = net.ReadInt( 13 )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamColor, name, Color( 255, 255, 255 ), " (" .. sID .. ") has spawned in the server (" .. formatTime( joinTime ) .. ")." )
end)

net.Receive( "cfc_playerdisconnect_ajl", function( len )
    local name = net.ReadString()
    local sID = net.ReadString()
    local reason = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamCol = team.GetColor( plyTeam )

    chat.AddText( Color( 255, 0, 255 ), "[Server] ", teamCol, name, Color( 255, 255, 255 ), " (" .. sID .. ") has left the server. (" .. reason .. ")" )
end)
