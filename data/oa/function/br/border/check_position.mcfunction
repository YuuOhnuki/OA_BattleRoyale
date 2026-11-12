scoreboard players set #inside br.flag 0
execute unless dimension oa:br unless dimension oa:br_nether run return 0
execute summon minecraft:marker run function oa:br/border/read_position
