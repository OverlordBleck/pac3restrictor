util.AddNetworkString("pac_restrictor_sendRanks")

function pacRestrictor:initDataFolder()
    file.Write("pac3restrictioninfo.txt", "DATA")

    return ""
end

function pacRestrictor:fetchRanks()
    local doesExist = file.Exists("pac3restrictioninfo.txt", "DATA")

    if doesExist then
        data = file.Read("pac3restrictioninfo.txt", "DATA")
    else
        data = self:initDataFolder()
    end

    local tbl = util.JSONToTable(data)
    self.RestrictedRanks = tbl

    net.Start("pac_restrictor_sendRanks")
        net.WriteTable(tbl)
    net.Broadcast()
end

function pacRestrictor:InitializeRestrictor()
    self:fetchRanks()
    MsgN("Initializing pac3restrictor")
end

hook.Add("Initialize", "initialize_pac_restrictor", pacRestrictor:InitializeRestrictor())