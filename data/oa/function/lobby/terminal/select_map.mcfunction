execute unless entity @s[tag=br.admin] unless entity @s[tag=br.host] run return 0
execute unless score #state br.state matches 0 run return 0
execute if score #game oa.game matches 1 run return run tellraw @s {text:"TDMは専用の立体工廠を使います",color:"yellow"}
$execute unless data storage oa:maps saved.$(key){state:3} run return run tellraw @s {text:"この会場は未生成です。管理者に作成を依頼してください",color:"yellow"}
$function oa:map/select {key:"$(key)"}
