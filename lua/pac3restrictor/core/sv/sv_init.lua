util.AddNetworkString("pac_restrictor_sendRanks")

function pacRestrictor:initDataFolder()
    file.Write("pac3RestrictionInfo.txt", "")

    return ""
end

function pacRestrictor:fetchRanks()
    local data = file.Read("pac3RestrictionInfo.txt")

    if data == nil then
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