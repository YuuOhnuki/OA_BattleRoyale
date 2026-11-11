execute unless entity @s[tag=br.admin] run return 0
execute unless data storage oa:lobby origin{ready:1b} run return 0
function oa:lobby/performance_count with storage oa:lobby origin
