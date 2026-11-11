# Find a safe current-border spawn before touching inventory or existing backup.
execute in oa:br run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute store result score #width oa.tmp in oa:br run worldborder get
scoreboard players set #two oa.tmp 2
scoreboard players operation #width oa.tmp /= #two oa.tmp
scoreboard players remove #width oa.tmp 2
execute if score #width oa.tmp matches ..0 run return run tellraw @a[tag=oa.roster_actor] {text:"安置が小さすぎるため途中参加できません。",color:"yellow"}
data modify storage oa:roster_spawn args set from storage oa:br center
execute store result storage oa:roster_spawn args.range int 1 run scoreboard players get #width oa.tmp
function oa:admin/players/spawn with storage oa:roster_spawn args
execute unless score #roster_spawn oa.tmp matches 1 run return run function oa:admin/players/spawn_failed
execute unless score @s br.saved matches 1 run function oa:br/save_player
execute unless score @s br.saved matches 1 run return run function oa:admin/players/spawn_failed
scoreboard players operation @s br.flag = @s br.pick
tag @s remove br.watch
tag @s add br.lobby
execute in oa:br at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute in oa:br run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
function oa:br/enter
execute if score #time br.time matches 1200.. run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #time br.time matches 1200.. run tag @s remove br.spawn_protection
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run team join oa_brgrace @s
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run tag @s add br.native_grace
scoreboard players set @s br.tp_ok 1
tellraw @s {text:"管理者により試合へ参加しました。",color:"green"}
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を試合へ参加させました。",color:"green"}]
