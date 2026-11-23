# マップ選択ボタン（stone_button）のマーカーで実行。押された瞬間に1回だけ反応する
execute unless block ~ ~ ~ minecraft:stone_button[powered=true] run return run tag @s remove oa.button_latched
execute if entity @s[tag=oa.button_latched] run return 0
tag @s add oa.button_latched
execute unless entity @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run return 0
# 1.9.168: 前へ／次へ（生成済みのマップを順に回す。lobby/mapsel/step）
execute if entity @s[tag=oa.mapsel_prev] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/step {dir:-1}
execute if entity @s[tag=oa.mapsel_next] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/step {dir:1}
# 1.9.231: マップごとのボタン（0 地上・1 ネザー・2 洞窟・3 天空島・4 エンド）
execute if entity @s[tag=oa.mapsel_k0] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"br"}
execute if entity @s[tag=oa.mapsel_k1] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"nether"}
execute if entity @s[tag=oa.mapsel_k2] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"cave"}
execute if entity @s[tag=oa.mapsel_k3] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"sky"}
execute if entity @s[tag=oa.mapsel_k4] as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run function oa:lobby/mapsel/pick {key:"end"}
