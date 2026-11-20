# 保存する順位と同じ基準：2＋自分より生存時間が長い非優勝者の人数。同時脱落は同順位。
scoreboard players operation #survived br.tmp = @s br.surv
scoreboard players set @s br.st_tmp 2
scoreboard players set #longer br.tmp 0
execute as @a[tag=br.playing,tag=!br.winner] if score @s br.surv > #survived br.tmp run scoreboard players add #longer br.tmp 1
scoreboard players operation @s br.st_tmp += #longer br.tmp
title @s subtitle [{text:"優勝：",color:"yellow"},{selector:"@a[tag=br.winner]"}]
title @s title [{text:"あなたは ",color:"white"},{score:{name:"@s",objective:"br.st_tmp"},color:"aqua",bold:true},{text:" 位",color:"white"}]
