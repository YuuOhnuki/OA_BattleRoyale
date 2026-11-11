scoreboard players remove @s oa.dpst 1
execute if score @s oa.dpst matches 1.. run return 0
scoreboard players operation #dps oa.tmp = @s br.st_dmg
scoreboard players operation #dps oa.tmp -= @s oa.dpsb
execute if score #dps oa.tmp matches ..0 run return run tellraw @s {text:"【ダメージ計測】結果：ダメージが計測されませんでした。",color:"yellow"}
scoreboard players operation #dpsh oa.tmp = #dps oa.tmp
scoreboard players set #10 oa.tmp 10
scoreboard players set #100 oa.tmp 100
scoreboard players operation #dpsh oa.tmp /= #10 oa.tmp
scoreboard players operation #dpsi oa.tmp = #dps oa.tmp
scoreboard players operation #dpsi oa.tmp /= #100 oa.tmp
scoreboard players operation #dpsf oa.tmp = #dps oa.tmp
scoreboard players operation #dpsf oa.tmp /= #10 oa.tmp
scoreboard players operation #dpsf oa.tmp %= #10 oa.tmp
tellraw @s [{text:"【ダメージ計測】10秒間の合計 ",color:"gold"},{score:{name:"#dpsh",objective:"oa.tmp"},color:"yellow"},{text:" HP ／ 毎秒 ",color:"gold"},{score:{name:"#dpsi",objective:"oa.tmp"},color:"yellow"},{text:".",color:"yellow"},{score:{name:"#dpsf",objective:"oa.tmp"},color:"yellow"},{text:" HP（1ハート＝2HP）",color:"gray"}]
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 1.2
