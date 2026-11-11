bossbar add oa:pvp_grace {text:"PvP保護",color:"green"}
bossbar set oa:pvp_grace color green
bossbar set oa:pvp_grace max 60
bossbar add oa:zone_timer {text:"安置",color:"aqua"}
bossbar set oa:zone_timer color blue
execute unless score #state br.state matches 1 run function oa:br/bars/hide
