
execute unless data storage oa:day backup run return 0
execute in oa:br run function oa:br/day/set with storage oa:day backup
execute in oa:br run time resume
data remove storage oa:day backup
