execute unless entity @s[type=minecraft:player] run return run tellraw @a {text:"鉱石登録はプレイヤーから実行してください。コンソールでは execute as <名前> at @s run function oa:br/mining/register",color:"red"}
execute at @s unless dimension oa:br run return run tellraw @s {text:"鉱石の登録はBR専用ディメンションで実行してください",color:"red"}
execute if score #state br.state matches 1.. run return run tellraw @s {text:"試合中・終了処理中は登録できません。/function oa:br/stop の完了後に実行してください",color:"red"}
scoreboard players set #registered br.flag 0
function oa:br/mining/internal/look
execute if score #registered br.flag matches 0 run tellraw @s {text:"視線先6ブロック以内に対象の鉱石がありません。手前のブロックを避け、石炭鉱石かレッドストーン鉱石を見てください（深層岩版も可）",color:"red"}
