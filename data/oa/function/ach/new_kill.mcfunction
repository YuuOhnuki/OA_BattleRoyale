scoreboard players operation @s br.st_kp = @s br.st_kill
function oa:ach/give {id:"first_kill",name:"初陣"}
execute if score @s br.st_kill matches 3.. run function oa:ach/give {id:"kills3",name:"ハットトリック"}
execute if score @s oa.kind matches 3 run function oa:ach/give {id:"lazi_kill",name:"音の洗礼"}
execute if score @s oa.kind matches 4 run function oa:ach/give {id:"nero_kill",name:"疫病の洗礼"}
execute if score @s oa.kind matches 6 run function oa:ach/give {id:"yuttari_kill",name:"奇襲の洗礼"}
execute if score @s oa.kind matches 7 run function oa:ach/give {id:"hotchikisu_kill",name:"針の洗礼"}
execute if score @s oa.kind matches 9 run function oa:ach/give {id:"tayayuyu_kill",name:"変態の洗礼"}
execute if score @s oa.kind matches 10 run function oa:ach/give {id:"itori_kill",name:"いとりの一撃"}
execute if score @s oa.kind matches 8 if score @s oa.small matches 1.. run function oa:ach/give {id:"komame_big",name:"小さな巨人"}
execute if score #mission br.tmp matches 4 unless items entity @s weapon.mainhand * if score @s br.mdone matches 0 run function oa:br/mission/clear
