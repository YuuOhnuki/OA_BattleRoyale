# マップ選択ボタン（stone_button）のマーカーで実行。押された瞬間に1回だけ反応する
execute unless block ~ ~ ~ minecraft:stone_button[powered=true] run return run tag @s remove oa.button_latched
execute if entity @s[tag=oa.button_latched] run return 0
tag @s add oa.button_latched
execute unless entity @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run return 0
execute if entity @s[tag=oa.mapsel_br] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"br"}
execute if entity @s[tag=oa.mapsel_nether] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"nether"}
