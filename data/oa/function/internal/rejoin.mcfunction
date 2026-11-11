function oa:tayayuyu/clear
execute if entity @s[tag=oa.debug,tag=!oa.practice] run function oa:debug/stop
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
function oa:status/reset
function oa:internal/cleanup
scoreboard players operation @s oa.seen = @s oa.left
scoreboard players operation @s oa.epoch = #epoch oa.epoch
scoreboard players set @s oa.kind -1

function oa:furoball/clear_up

function oa:tayayuyu/fall_clear

tag @s add oa.inv_dirty

function oa:migration/statistics_books

function oa:furoball/upgrade_inventory

function oa:itori/effects_end
