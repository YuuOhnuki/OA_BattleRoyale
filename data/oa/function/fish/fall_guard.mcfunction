# 1.9.187: ぴちぴちを持って空中にいる間は落下ダメージを0にしておき、着地して2 tick 後に外す（落ちながら持ち替えても落下ダメージを受けない）。
# ぴちぴちの落下ダメージ無効は主手のエンチャント（enchantment/fish.json）なので、持ち替えると外れていた
execute if score @s oa.kind matches 2 if predicate oa:airborne unless entity @s[tag=oa.fish_fall] run function oa:fish/fall_on
execute if entity @s[tag=oa.fish_fall] if score @s oa.kind matches 2 run scoreboard players set @s oa.ffall 0
execute if entity @s[tag=oa.fish_fall] unless predicate oa:airborne run scoreboard players add @s oa.ffall 1
execute if entity @s[tag=oa.fish_fall] if predicate oa:airborne run scoreboard players set @s oa.ffall 0
execute if entity @s[tag=oa.fish_fall] if score @s oa.ffall matches 2.. run function oa:fish/fall_off
