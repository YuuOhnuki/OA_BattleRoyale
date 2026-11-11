scoreboard players set #hit oa.tmp 1
scoreboard players set @s oa.blocked 0
execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return run function oa:combat/decoy_intercept
execute if entity @s[tag=oa.decoy_grace] run return 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
tag @s add oa.throw_hit
execute as @a[tag=oa.caster,limit=1] run damage @a[tag=oa.throw_hit,limit=1] 0.01 minecraft:thrown by @s
execute if entity @e[type=minecraft:snowball,tag=oa.throw_current,limit=1] run function oa:throwable/chill
tag @s remove oa.throw_hit
particle minecraft:crit ~ ~1 ~ 0.3 0.4 0.3 0.02 8 normal @a[distance=..24]
playsound minecraft:entity.player.attack.knockback player @a[distance=..24] ~ ~ ~ 0.6 1.3
