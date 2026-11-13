# 補給物資の表示フェーズ（3秒ごとに交互）の間は、試合中の通常バーを出さない
execute if score #state br.state matches 1 if score #sup_phase br.tmp matches 1 if entity @s[tag=br.playing] run return 0
# 災害の警告を出している3秒間（#dis_phase=1）は、警告を受けている本人の通常バーを出さない
execute if score #state br.state matches 1 if score #dis_phase br.tmp matches 1 if entity @s[tag=br.playing,tag=br.dis_msg] run return 0
function oa:br/ui/teammates/prepare
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return run function oa:curse/radar/hud
execute if score @s oa.kind matches 10 run return run function oa:itori/hud with storage oa:br_args
$execute unless entity @s[tag=br.playing] run return run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒",color:"white"},{nbt:"display",storage:"oa:allies",interpret:true}]
$execute if entity @s[tag=br.alive] if score @s br.out matches 0 run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒 | 境界 "},{score:{name:"@s",objective:"br.edge"}},{text:"m"},{nbt:"display",storage:"oa:allies",interpret:true}]
$execute if entity @s[tag=br.alive] if score @s br.out matches 1 run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒 | 境界 ",color:"red"},{score:{name:"@s",objective:"br.edge"}},{text:"m（安置外）",color:"red"},{nbt:"display",storage:"oa:allies",interpret:true}]
execute unless entity @s[tag=br.alive] run title @s actionbar [{text:"観戦中 | 境界 "},{score:{name:"@s",objective:"br.edge"}},{text:"m"},{nbt:"display",storage:"oa:allies",interpret:true}]
