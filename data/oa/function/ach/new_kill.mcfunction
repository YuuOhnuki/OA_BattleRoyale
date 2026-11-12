scoreboard players operation @s br.st_kp = @s br.st_kill
function oa:ach/give {id:"first_kill",name:"初陣"}
execute if score @s br.st_kill matches 3.. run function oa:ach/give {id:"kills3",name:"ハットトリック"}
execute if score @s br.st_kill matches 5.. run function oa:ach/give {id:"kills5",name:"殲滅者"}
execute unless items entity @s weapon.mainhand * run function oa:ach/give {id:"fist_kill",name:"拳で語る"}
execute if score @s oa.kind matches 1 run function oa:ach/give {id:"yuua_kill",name:"帽子の洗礼"}
execute if score @s oa.kind matches 2 run function oa:ach/give {id:"fish_kill",name:"初釣果"}
execute if score @s oa.kind matches 5 run function oa:ach/give {id:"curse_kill",name:"呪いの一撃"}
execute if score @s oa.kind matches 8 run function oa:ach/give {id:"komame_kill",name:"豆の一撃"}
execute if score @s oa.kind matches 3 run function oa:ach/give {id:"lazi_kill",name:"音の洗礼"}
execute if score @s oa.kind matches 4 run function oa:ach/give {id:"nero_kill",name:"疫病の洗礼"}
execute if score @s oa.kind matches 6 run function oa:ach/give {id:"yuttari_kill",name:"奇襲の洗礼"}
execute if score @s oa.kind matches 7 run function oa:ach/give {id:"hotchikisu_kill",name:"針の洗礼"}
execute if score @s oa.kind matches 9 run function oa:ach/give {id:"tayayuyu_kill",name:"変態の洗礼"}
execute if score @s oa.kind matches 10 run function oa:ach/give {id:"itori_kill",name:"いとりの一撃"}
execute if score @s oa.kind matches 8 if score @s oa.small matches 1.. run function oa:ach/give {id:"komame_big",name:"小さな巨人"}
execute if score #mission br.tmp matches 4 unless items entity @s weapon.mainhand * if score @s br.mdone matches 0 run function oa:br/mission/clear
execute unless score @s oa.kind = @s br.wkk run scoreboard players set @s br.wkc 0
scoreboard players operation @s br.wkk = @s oa.kind
scoreboard players add @s br.wkc 1
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 1 run function oa:ach/give {id:"yuua_master",name:"帽子の主"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 2 run function oa:ach/give {id:"fish_master",name:"大漁旗"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 3 run function oa:ach/give {id:"lazi_master",name:"騒音の主"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 4 run function oa:ach/give {id:"nero_master",name:"疫病神"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 5 run function oa:ach/give {id:"curse_master",name:"呪われし者"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 6 run function oa:ach/give {id:"yuttari_master",name:"影の暗殺者"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 7 run function oa:ach/give {id:"hotchikisu_master",name:"針山"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 8 run function oa:ach/give {id:"komame_master",name:"豆台風"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 9 run function oa:ach/give {id:"tayayuyu_master",name:"ガチャの申し子"}
execute if score @s br.wkc matches 3.. if score @s oa.kind matches 10 run function oa:ach/give {id:"itori_master",name:"いとりの申し子"}
function oa:ach/check_meta
