
net.Receive( "pac_restrictor_sendRanks", function( len )
    pacRestrictor.RestrictedRanks = net.ReadTable()
end )

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
    spawnmenu.AddToolMenuOption( "Utilities", "Admin", "pac_restrictor", "PAC Restrictor", "", "", function( panel )
        print("test")
        panel:ClearControls()
        panel:Help( "Restricts pacs to certain groups and players." )

        local subPanel = vgui.Create( "DPanel", panel )
        subPanel:DockMargin( 5, 10, 5, 10 )
        subPanel:Dock( TOP )
        subPanel:SetTall( 200 )

        local wide = subPanel:GetWide()

        local rankListUneffected = vgui.Create( "DListView", subPanel )
        rankListUneffected:SetWide( wide * 2 )
        rankListUneffected:Dock( LEFT )
        rankListUneffected:SetSortable( false )
        rankListUneffected:AddColumn( "Ranks" )
        rankListUneffected:SetMultiSelect( false )

        if ULib then
            local ulxGroups = ULib.ucl.groups

            for group, _ in pairs( ulxGroups ) do
                rankListUneffected:AddLine( group )
            end
        end

        local rankListEffected = vgui.Create( "DListView", subPanel )
        rankListEffected:SetWide( wide * 2 )
        rankListEffected:Dock( RIGHT )
        rankListEffected:SetSortable( false )
        rankListEffected:AddColumn( "Restricted Ranks" )
        rankListEffected:SetMultiSelect( false )

        local moveOverBut = vgui.Create( "DButton", subPanel )
        moveOverBut:DockMargin( 5, 10, 5, 10 )
        moveOverBut:Dock( TOP )
        moveOverBut:SetText( ">>" )

        moveOverBut.DoClick = function()
            local uneffLineID, text = rankListUneffected:GetSelectedLine()
            text = text:GetColumnText( 1 )

            rankListUneffected:RemoveLine( uneffLineID )
            rankListEffected:AddLine( text )
        end

        local moveBackBut = vgui.Create( "DButton", subPanel )
        moveBackBut:DockMargin( 5, 10, 5, 10 )
        moveBackBut:Dock( BOTTOM )
        moveBackBut:SetText( "<<" )

        moveBackBut.DoClick = function()
            local effLineID, text = rankListEffected:GetSelectedLine()
            text = text:GetColumnText( 1 )

            rankListEffected:RemoveLine( effLineID )
            rankListUneffected:AddLine( text )
        end
    end )
end )