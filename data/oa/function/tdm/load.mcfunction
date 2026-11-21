scoreboard objectives add tdm.heal dummy
scoreboard objectives add tdm.food dummy
scoreboard objectives add tdm.weapon dummy
scoreboard objectives add tdm.ct dummy
scoreboard objectives add tdm.dropid dummy
scoreboard objectives add tdm.lock dummy
scoreboard objectives add oa.game trigger
scoreboard objectives add oa.tdm trigger
scoreboard objectives add tdm.sys dummy
scoreboard objectives add tdm.ui dummy
scoreboard objectives add tdm.load dummy
scoreboard objectives add tdm.team dummy
scoreboard objectives add tdm.kills playerKillCount
scoreboard objectives add tdm.prev dummy
scoreboard objectives add tdm.points dummy
scoreboard objectives add tdm.wait dummy
scoreboard objectives add tdm.guard dummy
scoreboard objectives add tdm.armor dummy
scoreboard objectives add tdm.type dummy
scoreboard objectives add tdm.cool dummy
scoreboard objectives add tdm.board dummy {text:"TDM | 5分間キル勝負",color:"gold"}
scoreboard players add #game oa.game 0
scoreboard players add #active tdm.sys 0
# Reload/restart ends a TDM safely; offline inventories remain in the BR backup store.
execute if score #active tdm.sys matches 1 run function oa:tdm/stop
scoreboard players set #building tdm.sys 0
schedule clear oa:tdm/map/ready
tag @a remove tdm.pending_start
