tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：天変地異",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 生存者全員をランダムな場所へ", "color": "gray"}
# 1.9.191: 開始地点（oa:spawn_points、マップ全体に登録してある）から1人ずつ別の地点を選ぶ
execute unless data storage oa:spawn_points points[0] run return run tellraw @a[tag=br.playing] {text:"開始地点が登録されていないため、移動は中止しました。",color:"yellow"}
data modify storage oa:spawn_pool points set from storage oa:spawn_points points
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead,sort=random] at @s run function oa:tayayuyu/chaos
