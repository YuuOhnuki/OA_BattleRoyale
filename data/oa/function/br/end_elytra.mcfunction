# 1.9.236：異界（#map 4）では、試合の開始・途中参加のときに、防御力+6（鉄のチェストプレートと同じ）のエリトラを胸に着せる（br/enter から）。
# ふつうの装備なので、外したり、別の防具に着け替えたりできる。
execute unless score #map oa.mapid matches 4 run return 0
execute if score #game oa.game matches 1 run return 0
item replace entity @s armor.chest with minecraft:elytra[minecraft:attribute_modifiers=[{type:"minecraft:armor",id:"oa:end_elytra_armor",amount:6.0d,operation:"add_value",slot:"chest"}],minecraft:custom_name={text:"異界の翼",color:"light_purple",italic:false},minecraft:lore=[{text:"防御力+6（鉄のチェストプレートと同じ）",color:"gray",italic:false},{text:"異界の試合の開始時に着る。外すこともできる",color:"dark_gray",italic:false}],minecraft:custom_data={oa_end_elytra:1b}]
