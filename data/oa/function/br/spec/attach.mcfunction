scoreboard players operation #t br.tmp = @s br.sp
tag @a remove oa.spec_target
execute as @a[tag=br.alive] if score @s br.pid = #t br.tmp run tag @s add oa.spec_target
spectate @a[tag=oa.spec_target,limit=1] @s
title @s actionbar [{text:"観戦中：",color:"gray"},{selector:"@a[tag=oa.spec_target,limit=1]",color:"white"},{text:"　[スニーク]で解除",color:"dark_gray"}]
tag @a remove oa.spec_target
