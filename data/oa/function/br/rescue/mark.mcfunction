# 1.9.242：初心者救済モード。チェスト補充（tick 7200）より前に倒れた人は、脱落ではなく「復活待ち」にする（br/eliminate から、本人として）
# 降参・切断（br/surrender）は対象外
execute unless score #rescue br.flag matches 1 run return 0
execute unless score #state br.state matches 1 run return 0
execute unless score #time br.time matches ..7199 run return 0
execute if entity @s[tag=br.surrendering] run return 0
tag @s add br.rescue
tellraw @a[tag=br.playing] [{selector:"@s"},{text:" が倒れた",color:"yellow"},{text:"　補充で復活",color:"gray"}]
tellraw @s [{text:"✚ 初心者救済：",color:"aqua"},{text:"6分のチェスト補充で復活します",color:"white"}]
