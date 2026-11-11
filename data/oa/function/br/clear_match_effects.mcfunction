function oa:itori/effects_end
execute if entity @s[tag=oa.gacha_affected] run function oa:tayayuyu/clear
execute if entity @s[tag=oa.furo_fall] run function oa:furoball/clear_up
execute if entity @s[tag=oa.taya_fall] run function oa:tayayuyu/fall_clear
execute if entity @s[tag=jp_no_fall] run function jumppad:clear_fall_immunity
