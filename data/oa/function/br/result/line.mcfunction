scoreboard players operation @s br.st_tmp = @s br.st_dmg
scoreboard players operation @s br.st_tmp /= #10 br.tmp
scoreboard players operation #walk br.tmp = @s br.st_walk
scoreboard players operation #walk br.tmp += @s br.st_sprint
scoreboard players operation #walk br.tmp /= #100 br.tmp
tellraw @a[tag=oa.res_view] [{text:" ",color:"gray"},{selector:"@s",color:"white"},{text:"  キル ",color:"gray"},{score:{name:"@s",objective:"br.st_kill"},color:"red"},{text:" ／ 与ダメ ",color:"gray"},{score:{name:"@s",objective:"br.st_tmp"},color:"gold"},{text:" ／ 移動 ",color:"gray"},{score:{name:"#walk",objective:"br.tmp"},color:"aqua"},{text:"m ／ 開封 ",color:"gray"},{score:{name:"@s",objective:"br.st_open"},color:"green"}]
