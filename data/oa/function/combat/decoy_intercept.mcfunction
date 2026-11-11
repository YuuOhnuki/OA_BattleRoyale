scoreboard players set @s oa.blocked 1
function oa:nero/pop
execute as @a[tag=oa.caster,limit=1] at @s run function oa:nero/blind_attacker
function oa:nero/decoy_return
