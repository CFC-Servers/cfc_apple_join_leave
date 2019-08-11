util.AddNetworkString( "cfc_playerconnect" )

local function onPlayerConnect( plyName, ip )
    MsgN( "Player ".. plyName .. " has connected to the server." )

    net.Start( "cfc_playerconnect" )
        net.WriteString( plyName )
    net.Broadcast()
end

hook.Add( "PlayerConnect", "CFC_OnPlayerConnect", onPlayerConnect )