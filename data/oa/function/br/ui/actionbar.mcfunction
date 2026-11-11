function oa:br/ui/teammates/prepare
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return run function oa:curse/radar/hud
execute if score @s oa.kind matches 10 run return run function oa:itori/hud with storage oa:br_args
$execute unless entity @s[tag=br.playing] run return run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒",color:"white"},{nbt:"display",storage:"oa:allies",interpret:true}]
$execute if entity @s[tag=br.alive] if score @s br.out matches 0 run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒 | 境界 "},{score:{name:"@s",objective:"br.edge"}},{text:"m"},{nbt:"display",storage:"oa:allies",interpret:true}]
$execute if entity @s[tag=br.alive] if score @s br.out matches 1 run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT $(cd)秒 | 境界 ",color:"red"},{score:{name:"@s",objective:"br.edge"}},{text:"m（安置外）",color:"red"},{nbt:"display",storage:"oa:allies",interpret:true}]
execute unless entity @s[tag=br.alive] run title @s actionbar [{text:"観戦中 | 境界 "},{score:{name:"@s",objective:"br.edge"}},{text:"m"},{nbt:"display",storage:"oa:allies",interpret:true}]
