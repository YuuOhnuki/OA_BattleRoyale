execute unless entity @s[tag=oa.player] run return run tellraw @s {text:"先に /function oa:test/join を実行してください",color:"red"}
give @s minecraft:totem_of_undying[minecraft:custom_name={text:"ゆー：オーバーワーク",color:"gold",italic:false},minecraft:custom_data={oa_overwork:1b},minecraft:max_stack_size=1,minecraft:item_model="oa:yu",minecraft:lore=[{text:"手に持っていると致死ダメージ時に身代わりになる",color:"gray",italic:false},{text:"発動後に強化、その後は毒・吐き気・鈍足",color:"gray",italic:false}]] 1

execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa_overwork:1b}] run item modify entity @s weapon.mainhand oa:lore/yu
