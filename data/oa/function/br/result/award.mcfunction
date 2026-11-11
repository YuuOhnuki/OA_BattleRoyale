scoreboard players set #hmax br.tmp 0
$execute as @a[tag=oa.last_result] if score @s $(obj) > #hmax br.tmp run scoreboard players operation #hmax br.tmp = @s $(obj)
execute if score #hmax br.tmp matches ..0 run return 0
$execute as @a[tag=oa.last_result] if score @s $(obj) = #hmax br.tmp run tag @s add oa.hl_tmp
$tellraw @a[tag=oa.res_view] [{text:" ◆ $(label)：",color:"$(color)"},{selector:"@a[tag=oa.hl_tmp]",color:"white"},{text:"  ",color:"gray"},{score:{name:"#hmax",objective:"br.tmp"},color:"yellow"},{text:"$(unit)",color:"gray"}]
tag @a remove oa.hl_tmp
