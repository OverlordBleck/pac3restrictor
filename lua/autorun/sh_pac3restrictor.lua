pacRestrictor = {}
pacRestrictor.RestrictedRanks = {}

-- Returns a table of elements that arent shared between tables
function table.diff( table1, table2 )
    local out = {}

    for _, v in pairs( table1 ) do
        if table.HasValue( table2, v ) then 
            table.insert( out, v )
        end
    end
end

if SERVER then
    AddCSLuaFile( "pac3restrictor/core/cl/cl_init.lua" )

    include( "pac3restrictor/core/sv/sv_init.lua" )
end

if CLIENT then
    include( "pac3restrictor/core/cl/cl_init.lua" )
end