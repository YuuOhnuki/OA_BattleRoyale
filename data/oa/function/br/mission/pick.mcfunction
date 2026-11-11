execute store result score #mission br.tmp run random value 1..5
execute as @a[tag=br.playing] run function oa:br/mission/reset
function oa:br/mission/announce
