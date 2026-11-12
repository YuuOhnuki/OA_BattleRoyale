scoreboard players add @a oa.vtab 0
scoreboard players enable @a oa.ver
execute as @a[scores={oa.ver=1..}] run function oa:ver/show
