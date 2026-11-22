execute if score #active tdm.sys matches 1 run return run tellraw @s {text:"TDMの途中参加はできません。次の試合から参加してください",color:"yellow"}
# Find a safe current-border spawn before touching inventory or existing backup.
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
execute if score #width oa.tmp matches ..0 run return run tellraw @a[tag=oa.roster_actor] {text:"安置が小さすぎるため途中参加できません。",color:"yellow"}
data modify storage oa:roster_spawn args set from storage oa:br center
# 1.9.218: 今の安置（円）の中に収まる範囲・中心
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
execute unless score #roster_spawn oa.tmp matches 1 run return run function oa:admin/players/spawn_failed
# 1.9.180: 開始時（br/start）と同じく、保存の前に ID を付ける（ID がないと保存先が p0 になり、試合後に復元できない）
execute unless score @s oa.id matches 1.. run function oa:internal/id
execute unless score @s br.saved matches 1 run function oa:br/save_player
execute unless score @s br.saved matches 1 run return run function oa:admin/players/spawn_failed
scoreboard players operation @s br.flag = @s br.pick
tag @s remove br.watch
tag @s add br.lobby
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
# 1.9.180: 途中参加も、開始時（tp_position・tp_fix_all）と同じく地中埋まりを補正する。TPの直後と、3tick後から10tickごとに7回
execute at @s run function oa:br/tp_fix
tag @s add br.tpfix
scoreboard players set #tpfix_t br.flag 0
schedule function oa:br/tp_fix_all 3t
function oa:br/enter
execute if score #time br.time matches 1200.. run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #time br.time matches 1200.. run tag @s remove br.spawn_protection
# 1.9.185: 保護期間中もソロのチーム（oa_brsolo）のまま（ダメージはプラグインが止める）
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run team join oa_brsolo @s
# 1.9.148: 猶予後のソロ戦はチームに入れ直す（入らないと名前が見えたままになる）
execute if score #time br.time matches 1200.. if score #mode br.mode matches 0 run team join oa_brsolo @s
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run tag @s add br.native_grace
scoreboard players set @s br.tp_ok 1
tellraw @s {text:"管理者により試合へ参加しました。",color:"green"}
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を試合へ参加させました。",color:"green"}]
