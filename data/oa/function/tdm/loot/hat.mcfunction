scoreboard players set #hat_clock tdm.sys 0
scoreboard players set #drop_kind tdm.sys 1
execute as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/create
tellraw @a[tag=tdm.player] {text:"レアドロップ：ゆうあの帽子が出現！"}
