# 1.9.242：チェスト補充（tick 7200）以降、毎秒（br/second から）復活待ちの人を復活させる（配置に失敗した人・その時いなかった人も次の秒にやり直す）
execute unless score #state br.state matches 1 run return 0
execute unless score #time br.time matches 7200.. run return 0
execute as @a[tag=br.rescue,tag=br.playing,tag=!br.alive] unless entity @s[tag=oa.dead] at @s run function oa:br/rescue/revive
