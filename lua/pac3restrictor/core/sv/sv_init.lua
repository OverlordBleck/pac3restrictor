local filename = "pac3restrictioninfo.json"

util.AddNetworkString( "pac_restrictor_sendRanks" )

function pacRestrictor:fetchRanks()
    local data = ""

    if file.Exists( filename, "DATA" ) then
        data = file.Read( filename, "DATA" )
    else
        file.Write( filename, "" )
    end

    local tbl = util.JSONToTable( data )
    self.RestrictedRanks = tbl

    net.Start( "pac_restrictor_sendRanks" )
        net.WriteTable( tbl )
    net.Broadcast()
end

function pacRestrictor:InitializeRestrictor()
    MsgN( "Initializing pac3restrictor" )

    self:fetchRanks()
end

hook.Add( "Initialize", "initialize_pac_restrictor", pacRestrictor:InitializeRestrictor() )