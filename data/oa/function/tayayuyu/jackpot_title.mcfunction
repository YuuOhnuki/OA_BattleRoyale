# 1.9.192: 大当たりで決着した試合の、優勝のタイトルが出て約1秒後に切り替える（br/win_solo・win_team から 20 tick 後に schedule。1.9.193）
tag @a remove oa.g_jp_view
tag @a[tag=br.playing,tag=br.winner] add oa.g_jp_view
tag @a[tag=br.winner] add oa.g_jp_view
title @a[tag=oa.g_jp_view] times 5 80 25
title @a[tag=oa.g_jp_view] subtitle {text:"大当たり：神引き",color:"yellow"}
title @a[tag=oa.g_jp_view] title {text:"たやゆゆの勝ち",color:"gold",bold:true}
execute as @a[tag=oa.g_jp_view] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 0.8
execute as @a[tag=oa.g_jp_view] at @s run playsound minecraft:entity.firework_rocket.large_blast master @s ~ ~ ~ 1 1
execute as @a[tag=oa.g_jp_view] at @s run particle minecraft:totem_of_undying ~ ~1 ~ 0.8 1 0.8 0.4 80 normal @s
tag @a remove oa.g_jp_view
