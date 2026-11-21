$function oa:disaster/mob_spawn {kind:"$(kind)"}
scoreboard players remove #mob_n br.tmp 1
$execute if score #mob_n br.tmp matches 1.. run function oa:disaster/mob_loop {kind:"$(kind)"}
