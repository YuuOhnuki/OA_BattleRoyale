# 1.9.240：ニワトリ大量発生（20秒・危険度1）。生存者ごとに8〜12羽、既定種類上限60/全体90。観戦者には出さない。
execute as @a[tag=br.alive,gamemode=!spectator,sort=random] at @s run function oa:disaster/k8/spawn_for
