scoreboard players set #inside br.flag 0
execute unless dimension oa:br unless dimension oa:br_nether unless dimension oa:br_cave unless dimension oa:br_sky unless dimension oa:br_end run return 0
execute summon minecraft:marker run function oa:br/border/read_position
