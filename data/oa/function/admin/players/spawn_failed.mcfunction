execute in oa:br run kill @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn]
tellraw @a[tag=oa.roster_actor] {text:"安全な配置または所持品保存に失敗したため参加処理を中止しました。",color:"red"}
