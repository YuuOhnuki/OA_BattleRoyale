bossbar add oa:pvp_grace {text:"PvP保護",color:"green"}
bossbar set oa:pvp_grace color green
bossbar set oa:pvp_grace max 60
bossbar add oa:zone_timer {text:"安地",color:"aqua"}
bossbar set oa:zone_timer color blue
bossbar add oa:disaster {text:"災害",color:"red"}
bossbar set oa:disaster color red
bossbar set oa:disaster style notched_10
execute unless score #state br.state matches 1 run function oa:br/bars/hide
bossbar set oa:zone_timer name {text:"安地",color:"aqua"}
