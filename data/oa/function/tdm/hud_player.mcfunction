scoreboard players set @s tdm.weapon 0
data modify storage oa:tdm_hud name set value {text:"固有武器なし",color:"gray"}
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set @s tdm.weapon 1
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set @s tdm.weapon 1
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set @s tdm.weapon 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players set @s tdm.weapon 2
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players set @s tdm.weapon 2
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players set @s tdm.weapon 2
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players set @s tdm.weapon 3
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players set @s tdm.weapon 3
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players set @s tdm.weapon 3
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players set @s tdm.weapon 4
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players set @s tdm.weapon 4
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players set @s tdm.weapon 4
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players set @s tdm.weapon 5
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players set @s tdm.weapon 5
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players set @s tdm.weapon 5
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players set @s tdm.weapon 6
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players set @s tdm.weapon 6
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players set @s tdm.weapon 6
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s tdm.weapon 7
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s tdm.weapon 7
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s tdm.weapon 7
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players set @s tdm.weapon 8
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players set @s tdm.weapon 8
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players set @s tdm.weapon 8
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set @s tdm.weapon 10
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set @s tdm.weapon 10
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set @s tdm.weapon 10
execute if score @s tdm.weapon matches 1 run data modify storage oa:tdm_hud name set value {"text":"ゆうあ","color":"#fdc5f9","italic":false,"bold":true}
execute if score @s tdm.weapon matches 2 run data modify storage oa:tdm_hud name set value {"text":"ぴちぴち","color":"#2529ff","italic":false,"bold":true}
execute if score @s tdm.weapon matches 3 run data modify storage oa:tdm_hud name set value {"text":"らじ","color":"#ffad29","italic":false,"bold":true}
execute if score @s tdm.weapon matches 4 run data modify storage oa:tdm_hud name set value {"text":"ネロノワール","color":"#B5B5C2","italic":false,"bold":true}
execute if score @s tdm.weapon matches 5 run data modify storage oa:tdm_hud name set value {"text":"キリング","color":"#8d59ff","italic":false,"bold":true}
execute if score @s tdm.weapon matches 6 run data modify storage oa:tdm_hud name set value {"text":"ゆったり","color":"#65fff0","italic":false,"bold":true}
execute if score @s tdm.weapon matches 7 run data modify storage oa:tdm_hud name set value {"text":"ほちきす","color":"#851c1c","italic":false,"bold":true}
execute if score @s tdm.weapon matches 8 run data modify storage oa:tdm_hud name set value {"text":"こまめ","color":"#51c5ff","italic":false,"bold":true}
execute if score @s tdm.weapon matches 10 run data modify storage oa:tdm_hud name set value {"text":"いとり","color":"#006dff","italic":false,"bold":true}
scoreboard players set @s tdm.ct 0
execute if score @s oa.cd matches 1.. run scoreboard players operation @s tdm.ct = @s oa.cd
scoreboard players add @s tdm.ct 19
scoreboard players set #twenty tdm.sys 20
scoreboard players operation @s tdm.ct /= #twenty tdm.sys
function oa:tdm/hud_line with storage oa:tdm_hud
