# 1.9.212：ブタの大行進（15秒・危険度2）。生存者ごとに3〜5匹（観戦者には出さない）。上限は cfg.pig_cap・mob_cap
scoreboard players add @a br.dpig 0
execute as @a[tag=br.alive,gamemode=!spectator,sort=random] at @s run function oa:disaster/k11/spawn_for
