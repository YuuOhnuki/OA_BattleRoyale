# 1.9.212：竜巻（15秒・危険度4）。生存者のだれかから12ブロック離れた所に竜巻（目印 oa.dis_tornado）を出す。
# 動き・吸い寄せ・打ち上げ・見た目はプラグイン（disaster/DisasterService。境界の内側に保ち、地形は壊さない、直接のダメージなし）
scoreboard players set #tornado br.tmp 1
execute as @a[tag=br.alive,gamemode=!spectator,sort=random,limit=1] at @s run function oa:disaster/k10/spawn
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.breeze.wind_burst ambient @s ~ ~ ~ 1 0.5
