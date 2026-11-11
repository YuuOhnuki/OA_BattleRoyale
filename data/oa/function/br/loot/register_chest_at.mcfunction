execute unless block ~ ~ ~ minecraft:chest run return run tellraw @s {text:"チェストの上に立って実行してください",color:"red"}
execute unless block ~ ~ ~ minecraft:chest[type=single] run return run tellraw @s {text:"ラージチェストは非対応です。単体チェストで登録してください",color:"red"}
execute if entity @e[tag=br.chest,distance=..0.2] run return 0
summon minecraft:marker ~ ~ ~ {Tags:["br.chest"]}
tellraw @s {text:"補充用チェストを登録しました。登録チェストには私物を保管しないでください",color:"green"}
