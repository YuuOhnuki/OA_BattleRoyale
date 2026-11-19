# 1.9.191: 上が空いている間、最大16ブロック上がる（天井の下・洞窟でも落とせるように）
execute if score #tnt_h oa.tmp matches 16.. run return run function oa:tayayuyu/tnt_summon
execute unless block ~ ~1 ~ #oa:spawn_clear run return run function oa:tayayuyu/tnt_summon
scoreboard players add #tnt_h oa.tmp 1
execute positioned ~ ~1 ~ run function oa:tayayuyu/tnt_climb
