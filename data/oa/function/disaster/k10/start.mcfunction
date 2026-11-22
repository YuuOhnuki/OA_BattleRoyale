# 1.9.212：竜巻（危険度4）。1.9.226 から30秒、目印（oa.dis_tornado）はプラグインがマップの中心に出す（#tornado=1 が合図）。
# 動き・吸い寄せ・打ち上げ・見た目もプラグイン（disaster/DisasterService。中心からランダムに動き、境界の内側に保ち、地形は壊さない、直接のダメージなし）
scoreboard players set #tornado br.tmp 1
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.breeze.wind_burst ambient @s ~ ~ ~ 1 0.5
