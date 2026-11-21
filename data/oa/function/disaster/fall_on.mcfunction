# 落下ダメージ無効を付ける（引数なし。残り秒は呼び出し側が br.dfall に入れる）
attribute @s minecraft:fall_damage_multiplier modifier remove oa:dis_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:dis_fall -1 add_multiplied_total
tag @s add oa.dis_fall
