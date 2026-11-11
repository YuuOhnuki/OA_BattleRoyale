execute as @a[tag=br.lobby,scores={br.saved=1}] run function oa:br/discard_backup
execute in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=br.spawn]
tellraw @a[tag=br.admin] {text:"登録した開始地点が不足しているか、配置用の座標を取得できませんでした。ソロは参加人数分、チーム戦はチーム数分を登録してください。所持品は変更していません。",color:"red"}
