local prefixColor = Color( 41, 41, 41 )
local whiteColor = Color( 255, 255, 255 )
local textColor = Color( 180, 180, 180 )
local prefix = "• "

local function formatTime( seconds )
    if seconds < 61 then
        return string.format( "took %d seconds", seconds )
    end

    local minutes = math.floor( seconds / 60 )
    seconds = seconds % 60

    return string.format( "took %dm %02ds", minutes, seconds )
end

net.Receive( "cfc_playerconnect_ajl", function()
    local name = net.ReadString()

    chat.AddText( prefixColor, prefix, whiteColor, name, textColor, " has connected to the server." )
end )

net.Receive( "cfc_playerinitialspawn_ajl", function()
    local name = net.ReadString()
    local sID = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamColor = team.GetColor( plyTeam )
    local joinTime = net.ReadInt( 13 )

    if joinTime == 0 then
        chat.AddText( prefixColor, prefix, teamColor, name, textColor, " (", whiteColor, sID, textColor, ") has spawned in the server." )
        return
    end

    chat.AddText( prefixColor, prefix, teamColor, name, textColor, " (", whiteColor, sID, textColor, ") has spawned in the server (", whiteColor, formatTime( joinTime ), whiteColor, ")." )
end )

net.Receive( "cfc_playerdisconnect_ajl", function()
    local name = net.ReadString()
    local sID = net.ReadString()
    local reason = net.ReadString()
    local plyTeam = net.ReadInt( 11 )
    local teamCol = team.GetColor( plyTeam )

    chat.AddText( prefixColor, prefix, teamCol, name, textColor, " (", whiteColor, sID, textColor, ") has left the server. (", whiteColor, reason, textColor, ")" )
end )

hook.Add( "ChatText", "CFC_ChatText_AppleJoinLeave", function( _, _, _, msgType )
    if msgType == "joinleave" then return true end
end )
