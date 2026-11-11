scoreboard objectives remove br.ui0
scoreboard objectives add br.ui0 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui0 numberformat blank
scoreboard objectives setdisplay sidebar.team.gray br.ui0
team add oa_brsolo
team modify oa_brsolo color gray
team modify oa_brsolo friendlyFire true
execute if score #mode br.mode matches 0 run team join oa_brsolo @a[tag=br.playing]
scoreboard players set OA_alive br.ui0 15
scoreboard players set OA_width br.ui0 14
scoreboard players set OA_phase br.ui0 13
scoreboard players set OA_next br.ui0 12
scoreboard players set OA_version br.ui0 10
scoreboard objectives remove br.ui1
scoreboard objectives add br.ui1 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui1 numberformat blank
scoreboard objectives setdisplay sidebar.team.light_purple br.ui1
team modify oa_br1 color light_purple
scoreboard players set OA_alive br.ui1 15
scoreboard players set OA_width br.ui1 14
scoreboard players set OA_phase br.ui1 13
scoreboard players set OA_next br.ui1 12
scoreboard players set OA_version br.ui1 10
scoreboard players set OA_header br.ui1 8
scoreboard players display name OA_header br.ui1 {text:"チーム1のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui1 7
scoreboard players display name OA_mate1 br.ui1 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui1 6
scoreboard players display name OA_mate2 br.ui1 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui1 5
scoreboard players display name OA_mate3 br.ui1 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 1
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=1}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui2
scoreboard objectives add br.ui2 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui2 numberformat blank
scoreboard objectives setdisplay sidebar.team.aqua br.ui2
team modify oa_br2 color aqua
scoreboard players set OA_alive br.ui2 15
scoreboard players set OA_width br.ui2 14
scoreboard players set OA_phase br.ui2 13
scoreboard players set OA_next br.ui2 12
scoreboard players set OA_version br.ui2 10
scoreboard players set OA_header br.ui2 8
scoreboard players display name OA_header br.ui2 {text:"チーム2のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui2 7
scoreboard players display name OA_mate1 br.ui2 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui2 6
scoreboard players display name OA_mate2 br.ui2 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui2 5
scoreboard players display name OA_mate3 br.ui2 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 2
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=2}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui3
scoreboard objectives add br.ui3 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui3 numberformat blank
scoreboard objectives setdisplay sidebar.team.red br.ui3
team modify oa_br3 color red
scoreboard players set OA_alive br.ui3 15
scoreboard players set OA_width br.ui3 14
scoreboard players set OA_phase br.ui3 13
scoreboard players set OA_next br.ui3 12
scoreboard players set OA_version br.ui3 10
scoreboard players set OA_header br.ui3 8
scoreboard players display name OA_header br.ui3 {text:"チーム3のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui3 7
scoreboard players display name OA_mate1 br.ui3 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui3 6
scoreboard players display name OA_mate2 br.ui3 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui3 5
scoreboard players display name OA_mate3 br.ui3 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 3
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=3}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui4
scoreboard objectives add br.ui4 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui4 numberformat blank
scoreboard objectives setdisplay sidebar.team.blue br.ui4
team modify oa_br4 color blue
scoreboard players set OA_alive br.ui4 15
scoreboard players set OA_width br.ui4 14
scoreboard players set OA_phase br.ui4 13
scoreboard players set OA_next br.ui4 12
scoreboard players set OA_version br.ui4 10
scoreboard players set OA_header br.ui4 8
scoreboard players display name OA_header br.ui4 {text:"チーム4のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui4 7
scoreboard players display name OA_mate1 br.ui4 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui4 6
scoreboard players display name OA_mate2 br.ui4 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui4 5
scoreboard players display name OA_mate3 br.ui4 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 4
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=4}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui5
scoreboard objectives add br.ui5 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui5 numberformat blank
scoreboard objectives setdisplay sidebar.team.green br.ui5
team modify oa_br5 color green
scoreboard players set OA_alive br.ui5 15
scoreboard players set OA_width br.ui5 14
scoreboard players set OA_phase br.ui5 13
scoreboard players set OA_next br.ui5 12
scoreboard players set OA_version br.ui5 10
scoreboard players set OA_header br.ui5 8
scoreboard players display name OA_header br.ui5 {text:"チーム5のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui5 7
scoreboard players display name OA_mate1 br.ui5 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui5 6
scoreboard players display name OA_mate2 br.ui5 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui5 5
scoreboard players display name OA_mate3 br.ui5 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 5
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=5}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui6
scoreboard objectives add br.ui6 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui6 numberformat blank
scoreboard objectives setdisplay sidebar.team.yellow br.ui6
team modify oa_br6 color yellow
scoreboard players set OA_alive br.ui6 15
scoreboard players set OA_width br.ui6 14
scoreboard players set OA_phase br.ui6 13
scoreboard players set OA_next br.ui6 12
scoreboard players set OA_version br.ui6 10
scoreboard players set OA_header br.ui6 8
scoreboard players display name OA_header br.ui6 {text:"チーム6のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui6 7
scoreboard players display name OA_mate1 br.ui6 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui6 6
scoreboard players display name OA_mate2 br.ui6 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui6 5
scoreboard players display name OA_mate3 br.ui6 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 6
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=6}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui7
scoreboard objectives add br.ui7 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui7 numberformat blank
scoreboard objectives setdisplay sidebar.team.dark_purple br.ui7
team modify oa_br7 color dark_purple
scoreboard players set OA_alive br.ui7 15
scoreboard players set OA_width br.ui7 14
scoreboard players set OA_phase br.ui7 13
scoreboard players set OA_next br.ui7 12
scoreboard players set OA_version br.ui7 10
scoreboard players set OA_header br.ui7 8
scoreboard players display name OA_header br.ui7 {text:"チーム7のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui7 7
scoreboard players display name OA_mate1 br.ui7 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui7 6
scoreboard players display name OA_mate2 br.ui7 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui7 5
scoreboard players display name OA_mate3 br.ui7 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 7
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=7}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui8
scoreboard objectives add br.ui8 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui8 numberformat blank
scoreboard objectives setdisplay sidebar.team.gold br.ui8
team modify oa_br8 color gold
scoreboard players set OA_alive br.ui8 15
scoreboard players set OA_width br.ui8 14
scoreboard players set OA_phase br.ui8 13
scoreboard players set OA_next br.ui8 12
scoreboard players set OA_version br.ui8 10
scoreboard players set OA_header br.ui8 8
scoreboard players display name OA_header br.ui8 {text:"チーム8のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui8 7
scoreboard players display name OA_mate1 br.ui8 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui8 6
scoreboard players display name OA_mate2 br.ui8 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui8 5
scoreboard players display name OA_mate3 br.ui8 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 8
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=8}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui9
scoreboard objectives add br.ui9 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui9 numberformat blank
scoreboard objectives setdisplay sidebar.team.white br.ui9
team modify oa_br9 color white
scoreboard players set OA_alive br.ui9 15
scoreboard players set OA_width br.ui9 14
scoreboard players set OA_phase br.ui9 13
scoreboard players set OA_next br.ui9 12
scoreboard players set OA_version br.ui9 10
scoreboard players set OA_header br.ui9 8
scoreboard players display name OA_header br.ui9 {text:"チーム9のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui9 7
scoreboard players display name OA_mate1 br.ui9 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui9 6
scoreboard players display name OA_mate2 br.ui9 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui9 5
scoreboard players display name OA_mate3 br.ui9 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 9
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=9}] run function oa:br/ui/assign_member
scoreboard objectives remove br.ui10
scoreboard objectives add br.ui10 dummy {text:"OAバトルロワイヤル",color:"gold",bold:true}
scoreboard objectives modify br.ui10 numberformat blank
scoreboard objectives setdisplay sidebar.team.dark_gray br.ui10
team modify oa_br10 color dark_gray
scoreboard players set OA_alive br.ui10 15
scoreboard players set OA_width br.ui10 14
scoreboard players set OA_phase br.ui10 13
scoreboard players set OA_next br.ui10 12
scoreboard players set OA_version br.ui10 10
scoreboard players set OA_header br.ui10 8
scoreboard players display name OA_header br.ui10 {text:"チーム10のメンバー",color:"yellow"}
scoreboard players set OA_mate1 br.ui10 7
scoreboard players display name OA_mate1 br.ui10 {text:" —",color:"gray"}
scoreboard players set OA_mate2 br.ui10 6
scoreboard players display name OA_mate2 br.ui10 {text:" —",color:"gray"}
scoreboard players set OA_mate3 br.ui10 5
scoreboard players display name OA_mate3 br.ui10 {text:" —",color:"gray"}
scoreboard players set #member br.tmp 0
data modify storage oa:br_ui_args view set value 10
execute if score #mode br.mode matches 1 as @a[tag=br.playing,scores={oa.team=10}] run function oa:br/ui/assign_member
function oa:br/ui/update

function oa:br/grace/start

team modify oa_brsolo nametagVisibility never
function oa:br/ui/version
