tellraw @s {text:"OA準備チェック",color:"gold"}
execute if data storage oa:br center run tellraw @s {"text":"BR中心：登録済み","color":"green"}
execute unless data storage oa:br center run tellraw @s {"text":"BR中心：未登録","color":"red"}
execute if data storage oa:br border_restore run tellraw @s {"text":"基本設定：登録済み","color":"green"}
execute unless data storage oa:br border_restore run tellraw @s {"text":"基本設定：未登録","color":"red"}
execute if data storage oa:lobby origin{ready:1b} run tellraw @s {"text":"ロビー：登録済み","color":"green"}
execute unless data storage oa:lobby origin{ready:1b} run tellraw @s {"text":"ロビー：未登録","color":"red"}
function oa:map/status
scoreboard players set #ready_n oa.tmp 0
execute as @a[tag=br.lobby] run scoreboard players add #ready_n oa.tmp 1
tellraw @s [{text:"参加登録人数：",color:"aqua"},{score:{name:"#ready_n",objective:"oa.tmp"}}]
function oa:admin/state
execute if entity @a[tag=br.lobby,scores={br.pick=0}] run tellraw @s {text:"チーム未選択の参加者がいます（ソロは選択不要）。",color:"yellow"}
tellraw @s {text:"クライアントのリソースパック適用はサーバーから自動確認できません。表示を確認してください。",color:"gray"}

execute if data storage oa:br center run tellraw @s [{text:"BR中心 X/Y/Z：",color:"aqua"},{nbt:"center.x",storage:"oa:br"},{text:" / "},{nbt:"center.y",storage:"oa:br"},{text:" / "},{nbt:"center.z",storage:"oa:br"}]
execute if data storage oa:br center run function oa:br/check_center
execute if data storage oa:br center if score #center_ok br.flag matches 0 run tellraw @s {text:"旧マップの中心です。BR専用ディメンションにマップを生成してください。",color:"red"}
execute if score #state br.state matches 4 run tellraw @s {text:"試合状態：開始前の清掃中",color:"yellow"}
