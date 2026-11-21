# 1.9.212：ニワトリ大量発生（12秒・危険度1）。生存者ごとに5〜8羽（観戦者には出さない）。上限は cfg.chicken_cap・mob_cap
execute as @a[tag=br.alive,gamemode=!spectator,sort=random] at @s run function oa:disaster/k8/spawn_for
