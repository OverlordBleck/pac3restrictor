-- Returns a table of elements that arent shared between tables
local function tableDiff( table1, table2 )
    local out = {}

    for _, v in pairs( table1 ) do
        if not table.HasValue( table2, v ) then 
            table.insert( out, v )
        end
    end

    return out
end

net.Receive( "pac_restrictor_sendRanks", function( len )
    pacRestrictor.RestrictedRanks = net.ReadTable()
end )

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
    spawnmenu.AddToolMenuOption( "Utilities", "Admin", "pac_restrictor", "PAC Restrictor", "", "", function( panel )
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
            if not LocalPlayer():IsSuperAdmin() then return end

            local lineID, line = rankListUneffected:GetSelectedLine()
            if not IsValid( line ) then return end

            text = line:GetColumnText( 1 )

            rankListUneffected:RemoveLine( lineID )
            rankListEffected:AddLine( text )
        end

        local moveBackBut = vgui.Create( "DButton", subPanel )
        moveBackBut:DockMargin( 5, 10, 5, 10 )
        moveBackBut:Dock( BOTTOM )
        moveBackBut:SetText( "<<" )

        moveBackBut.DoClick = function()
            if not LocalPlayer():IsSuperAdmin() then return end

            local lineID, line = rankListEffected:GetSelectedLine()
            if not IsValid( line ) then return end

            text = line:GetColumnText( 1 )

            rankListEffected:RemoveLine( lineID )
            rankListUneffected:AddLine( text )
        end

        timer.Simple( 0.1, function()
            if ULib then
                local ulxGroups = table.GetKeys( ULib.ucl.groups )
                local unrestrictedGroups = tableDiff( ulxGroups, pacRestrictor.RestrictedRanks )
                local restrictedGroups = pacRestrictor.RestrictedRanks

                for _, group in pairs( unrestrictedGroups ) do
                    rankListUneffected:AddLine( group )
                end

                for _, group in pairs( restrictedGroups ) do
                    rankListEffected:AddLine( group )
                end
            end
        end )
    end )
end )
