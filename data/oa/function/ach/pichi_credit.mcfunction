scoreboard players operation #by br.tmp = @s br.hopby
execute as @a[tag=br.playing,tag=br.alive] if score @s br.pid = #by br.tmp run function oa:ach/give {id:"pichi_20s",name:"魚のまま20秒"}
