advancement revoke @s only oa:nero/decoy_hit
execute if entity @s[tag=br.pvp_grace] run return 0
execute unless entity @s[tag=oa.self_decoy] run return 0
function oa:nero/pop
function oa:ach/give {id:"nero_decoy",name:"ビビらせてやる！"}
# 1.9.173: 1試合で10回受け流すと「弱さを見せるな、絶対にだ！」
execute if entity @s[tag=br.playing] run scoreboard players add @s br.a_ndec 1
execute if score @s br.a_ndec matches 10.. run function oa:ach/give {id:"nero_decoy10",name:"弱さを見せるな、絶対にだ！"}
# Damage event updates the responsible attacker before granting this advancement.
execute on attacker if entity @s[type=minecraft:player] at @s run function oa:nero/blind_attacker
function oa:nero/decoy_return

execute on attacker if entity @s[tag=oa.debug_mob] at @s run function oa:nero/blind_attacker
