# 生成: scripts/build_map_sky.py（直接編集しない）。島を置き終えた
execute if score #map_failed oa.map2 matches 1.. run return run function oa:maps/sky/isles/failed
data modify storage oa_map2:job working set value 0b
scoreboard players set #image_sky oa.tmp 0
function oa:map/internal/save_cur {key:"sky"}
execute store result score #sp_n oa.tmp run data get storage oa:spawn_points points
execute store result score #isle_n oa.tmp run data get storage oa:maps sky_isles
tellraw @a[tag=br.admin] [{text:"[天空島] まわりの島 ",color:"green"},{score:{name:"#isle_n",objective:"oa.tmp"},color:"green"},{text:" 個を置きました（",color:"green"},{nbt:"sky_isles[]",storage:"oa:maps",interpret:true,color:"white",separator:"・"},{text:"）。チェスト ",color:"green"},{score:{name:"#chests",objective:"oa.map2"},color:"green"},{text:"個・開始地点 ",color:"green"},{score:{name:"#sp_n",objective:"oa.tmp"},color:"green"},{text:"か所。",color:"green"}]
execute as @a[tag=br.admin] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.6 1.2
