execute unless entity @s[type=minecraft:player] run return run tellraw @a {text:"鉱石登録はプレイヤーから実行してください。コンソールでは execute as <名前> at @s run function oa:br/mining/register",color:"red"}
execute at @s unless dimension oa:br unless dimension oa:br_nether run return run tellraw @s {text:"鉱石の登録はBR専用ディメンションで実行してください",color:"red"}
execute if score #state br.state matches 1.. run return run tellraw @s {text:"試合中・終了処理中は登録できません。/function oa:br/stop の完了後に実行してください",color:"red"}
scoreboard players set #registered br.flag 0
execute at @s positioned ~ ~-0.05 ~ align xyz positioned ~0.5 ~0.5 ~0.5 run function oa:br/mining/internal/register_block
execute if score #registered br.flag matches 0 at @s positioned ~ ~-0.55 ~ align xyz positioned ~0.5 ~0.5 ~0.5 run function oa:br/mining/internal/register_block
execute if score #registered br.flag matches 0 at @s positioned ~ ~-1.05 ~ align xyz positioned ~0.5 ~0.5 ~0.5 run function oa:br/mining/internal/register_block
execute if score #registered br.flag matches 0 run function oa:br/mining/internal/look
execute if score #registered br.flag matches 0 run tellraw @s {text:"対象が見つかりません。石炭鉱石かレッドストーン鉱石（深層岩版も可）の上に立つか、6ブロック以内で鉱石を見て実行してください。石炭・レッドストーンのブロックは対象外です",color:"red"}
