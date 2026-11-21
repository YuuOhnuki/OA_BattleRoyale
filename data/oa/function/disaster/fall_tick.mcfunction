# 1.9.212：重力異常・竜巻のあとの落下ダメージ無効の残り秒（br.dfall）。0になったら外す
scoreboard players remove @a[scores={br.dfall=1..}] br.dfall 1
execute as @a[tag=oa.dis_fall,scores={br.dfall=..0}] run function oa:disaster/fall_off
scoreboard players remove @a[scores={br.dpig=1..}] br.dpig 1
