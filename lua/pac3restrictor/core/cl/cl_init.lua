
net.Receive("pac_restrictor_sendRanks", function(len)
    pacRestrictor.RestrictedRanks = net.ReadTable()
    print(table.Count(pacRestrictor.RestrictedRanks))
end)

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
    spawnmenu.AddToolMenuOption( "Utilities", "Admin", "pac_restrictor", "PAC Restrictor", "", "", function( panel )
        panel:ClearControls()
        panel:Help("Restricts pacs to certain groups and players.")

        local subPanel = vgui.Create("DPanel", panel)
        subPanel:DockMargin(5, 10, 5, 10)
        subPanel:Dock(TOP)
        subPanel:SetTall(200)

        local wide = subPanel:GetWide()

        local rankListUneffected = vgui.Create("DListView", subPanel)
        rankListUneffected:SetWide(wide*2)
        rankListUneffected:Dock(LEFT)
        rankListUneffected:SetSortable(false)
        rankListUneffected:AddColumn("Ranks")

        for _, group in pairs(team.GetAllTeams()) do
            rankListUneffected:AddLine(group.Name)
        end

        local rankListEffected = vgui.Create("DListView", subPanel)
        rankListEffected:SetWide(wide*2)
        rankListEffected:Dock(RIGHT)
        rankListEffected:SetSortable(false)
        rankListEffected:AddColumn("Restricted Ranks")

        local moveOverBut = vgui.Create("DButton", subPanel)
        moveOverBut:DockMargin(5, 10, 5, 10)
        moveOverBut:Dock(TOP)
        moveOverBut:SetText(">>")

        local moveBackBut = vgui.Create("DButton", subPanel)
        moveBackBut:DockMargin(5, 10, 5, 10)
        moveBackBut:Dock(BOTTOM)
        moveBackBut:SetText("<<")
    end )
end )