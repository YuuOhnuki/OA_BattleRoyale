# ハズレのガチャ（瀕死・足が棒・完全無防備）を引いた使用者本人を10秒間発光させる。解除は丸見え（reveal）と同じ仕組み（oa.gglow）
effect give @s minecraft:glowing 10 0 true
execute unless score @s oa.gglow matches 200.. run scoreboard players set @s oa.gglow 200
tag @s add oa.gacha_glow
tag @s add oa.gacha_affected
