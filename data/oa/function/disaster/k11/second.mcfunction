# プラグインの隊列更新が0.5秒ごとに爆発を行う。旧プラグイン/無効時は従来の毎秒処理へ戻す。
execute unless score #pig_march oa.plugin matches 1 as @e[type=minecraft:pig,tag=oa.dis_pig] at @s run function oa:disaster/k11/boom
