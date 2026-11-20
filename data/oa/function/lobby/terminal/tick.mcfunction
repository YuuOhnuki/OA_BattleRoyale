# 1.9.203: 出撃ターミナル（terminal:203）の毎tick。戦績の表示はプラグイン（menu/LobbyGallery）が更新する。
tag @a remove br.lobby_now
function oa:lobby/select_area with storage oa:lobby origin
execute if score #state br.state matches 0 as @a[tag=br.lobby_now,tag=!br.watch,tag=!br.in_lobby,tag=!br.playing,tag=!br.optout] at @s run function oa:br/join
tag @a[tag=br.lobby_now] add br.in_lobby
tag @a[tag=!br.lobby_now] remove br.in_lobby
execute as @a[tag=br.lobby_now] at @s run function oa:lobby/comfort
execute as @a[tag=oa.lobby_safe,tag=!br.lobby_now] run attribute @s minecraft:fall_damage_multiplier modifier remove oa:lobby_fall
tag @a[tag=oa.lobby_safe,tag=!br.lobby_now] remove oa.lobby_safe
execute if score #perf oa.tmp matches 0 run function oa:lobby/protect_exhibits
