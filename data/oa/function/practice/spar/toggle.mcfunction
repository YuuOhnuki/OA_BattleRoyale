execute unless entity @s[tag=oa.practice] run return run tellraw @s {text:"練習場の中で使ってください。",color:"yellow"}
execute if entity @s[tag=oa.spar] run return run function oa:practice/spar/off
tag @s add oa.spar
team join oa_spar @s
effect clear @s minecraft:resistance
effect give @s minecraft:resistance infinite 2 true
tellraw @s [{text:"【模擬戦ON】",color:"red",bold:true},{text:"他の模擬戦ONの人と戦えます。体力が少なくなると「KO」で入口に戻り、回復します。やめる時はもう一度 /trigger oa.spar",color:"white"}]
tellraw @a[tag=oa.practice,tag=!oa.spar] [{selector:"@s"},{text:" が模擬戦を始めました（参加は /trigger oa.spar）",color:"gold"}]
