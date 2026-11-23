# 1.9.242：初心者救済モードの復活（本人として）。配置は途中参加（admin/players/live_join）と同じく、今の安置の中の安全な床を探す
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 2 in oa:br_cave run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 3 in oa:br_sky run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 4 in oa:br_end run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute store result score #width oa.tmp if score #map oa.mapid matches 0 in oa:br run worldborder get
execute store result score #width oa.tmp if score #map oa.mapid matches 1 in oa:br_nether run worldborder get
execute store result score #width oa.tmp if score #map oa.mapid matches 2 in oa:br_cave run worldborder get
execute store result score #width oa.tmp if score #map oa.mapid matches 3 in oa:br_sky run worldborder get
execute store result score #width oa.tmp if score #map oa.mapid matches 4 in oa:br_end run worldborder get
scoreboard players set #two oa.tmp 2
scoreboard players operation #width oa.tmp /= #two oa.tmp
scoreboard players remove #width oa.tmp 2
execute if score #width oa.tmp matches ..0 run return 0
data modify storage oa:roster_spawn args set from storage oa:br center
scoreboard players set #7 br.tmp 7
scoreboard players set #10 br.tmp 10
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
function oa:br/zone/area {use:"now",margin:2}
execute if score #zrb br.tmp matches 1.. run scoreboard players operation #width oa.tmp = #zone_range br.tmp
execute if score #zrb br.tmp matches 1.. run data modify storage oa:roster_spawn args.x set from storage oa:br_spawn x
execute if score #zrb br.tmp matches 1.. run data modify storage oa:roster_spawn args.z set from storage oa:br_spawn z
execute store result storage oa:roster_spawn args.range int 1 run scoreboard players get #width oa.tmp
function oa:admin/players/spawn with storage oa:roster_spawn args
# 失敗したら復活待ちのまま（br/second から毎秒やり直す）
execute unless score #roster_spawn oa.tmp matches 1 run return 0
tag @s remove br.rescue
spectate
tag @s remove oa.spec_init
execute if score @s oa.team matches 1.. run scoreboard players operation @s br.flag = @s oa.team
execute if score #map oa.mapid matches 0 in oa:br at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute if score #map oa.mapid matches 1 in oa:br_nether at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute if score #map oa.mapid matches 2 in oa:br_cave at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute if score #map oa.mapid matches 3 in oa:br_sky at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute if score #map oa.mapid matches 4 in oa:br_end at @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 2 in oa:br_cave run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 3 in oa:br_sky run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute if score #map oa.mapid matches 4 in oa:br_end run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
execute at @s run function oa:br/tp_fix
tag @s add br.tpfix
scoreboard players set #tpfix_t br.flag 0
schedule function oa:br/tp_fix_all 3t
function oa:br/enter
# 保護期間は終わっている（tick 7200 以降）。着地の安全のため5秒だけ耐性
effect clear @s minecraft:resistance
tag @s remove br.pvp_grace
tag @s remove br.spawn_protection
execute if score #mode br.mode matches 0 run team join oa_brsolo @s
effect give @s minecraft:resistance 5 4 true
scoreboard players set @s br.tp_ok 1
execute at @s run function oa:br/rescue/kit
tellraw @a[tag=br.playing] [{selector:"@s"},{text:" が復活しました",color:"aqua"},{text:"（初心者救済）",color:"gray"}]
tellraw @s [{text:"✚ 初心者救済モード：",color:"aqua"},{text:"復活しました。固有武器・チェーンの防具一式・パン5個・包帯5個を渡しました（固有武器は足元）。",color:"white"}]
execute at @s run playsound minecraft:item.totem.use player @s ~ ~ ~ 0.6 1.2
