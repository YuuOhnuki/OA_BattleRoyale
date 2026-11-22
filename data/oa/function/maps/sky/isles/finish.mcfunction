# 生成: scripts/build_map_sky.py（直接編集しない）。島を置き終えた
data modify storage oa_map2:job working set value 0b
execute store result score #sp_n oa.tmp run data get storage oa:spawn_points points
execute store result score #isle_n oa.tmp run data get storage oa:maps sky_isles
tellraw @a[tag=br.admin] [{text:"[天空島] まわりの島 ",color:"green"},{score:{name:"#isle_n",objective:"oa.tmp"},color:"green"},{text:" 個を置きました（",color:"green"},{nbt:"sky_isles[]",storage:"oa:maps",color:"white",separator:"・"},{text:"）。チェスト ",color:"green"},{score:{name:"#chests",objective:"oa.map2"},color:"green"},{text:"個・開始地点 ",color:"green"},{score:{name:"#sp_n",objective:"oa.tmp"},color:"green"},{text:"か所。",color:"green"}]
execute as @a[tag=br.admin] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.6 1.2
