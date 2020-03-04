pacRestrictor = {}
pacRestrictor.RestrictedRanks = {}

if SERVER then
    AddCSLuaFile( "pac3restrictor/core/cl/cl_init.lua" )

    include( "pac3restrictor/core/sv/sv_init.lua" )
end

if CLIENT then
    include( "pac3restrictor/core/cl/cl_init.lua" )
end
