# 前回の結果の並び順の鍵（生き残った時間が長い順、同じならキルが多い順）
scoreboard players set #100 oa.tmp 100
scoreboard players set @s br.lkey 0
scoreboard players operation @s br.lkey = @s br.surv
scoreboard players operation @s br.lkey *= #100 oa.tmp
scoreboard players operation @s br.lkey += @s br.st_kill
