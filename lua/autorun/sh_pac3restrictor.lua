pacRestrictor = {}
pacRestrictor.RestrictedRanks = {}

-- Returns a table of elements that arent shared between tables
function table.getDiff( table1, table2 )
    local out = {}

    for _, v1 in pairs( table1 ) do
        for _, v2 in pairs( table2 ) do
            if table.HasValue( table1, v2 )
        end
    end
end

if SERVER then
    AddCSLuaFile()

    include( "pac3restrictor/core/sv/sv_init.lua" )
end

if CLIENT then
    include( "pac3restrictor/core/cl/cl_init.lua" )
end