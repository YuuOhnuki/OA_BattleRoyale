scoreboard players add @a oa.batcool 0
scoreboard players remove @a[scores={oa.batcool=1..}] oa.batcool 1
tag @a[scores={oa.batcool=0}] add oa.bat_ready
tag @a[scores={oa.batcool=1..}] remove oa.bat_ready
