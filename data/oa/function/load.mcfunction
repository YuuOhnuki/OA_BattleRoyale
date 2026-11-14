scoreboard objectives add oa.admin trigger
scoreboard objectives add oa.return trigger
scoreboard objectives add oa.id dummy
scoreboard objectives add oa.serial dummy
scoreboard objectives add oa.owner dummy
scoreboard objectives add oa.have dummy
scoreboard objectives add oa.kind dummy
scoreboard objectives add oa.old dummy
scoreboard objectives add oa.cd dummy
scoreboard objectives add oa.mark dummy
scoreboard objectives add oa.decoy dummy
scoreboard objectives add oa.breath dummy
scoreboard objectives add oa.beat dummy
scoreboard objectives add oa.use minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add oa.skill trigger
scoreboard objectives add oa.alt trigger
scoreboard objectives add oa.death deathCount
scoreboard objectives add oa.left minecraft.custom:minecraft.leave_game
scoreboard objectives add oa.seen dummy
scoreboard objectives add oa.tmp dummy
scoreboard objectives add oa.wait dummy
scoreboard objectives add oa.team dummy
scoreboard objectives add oa.epoch dummy
scoreboard players add #id oa.id 0
scoreboard players add #serial oa.serial 0
scoreboard players add #epoch oa.epoch 1
scoreboard objectives add oa.steps dummy
scoreboard objectives add oa.life dummy
scoreboard objectives add oa.hop dummy
scoreboard objectives add oa.push dummy
scoreboard objectives add oa.blocked dummy
scoreboard objectives add oa.water dummy
scoreboard objectives add oa.wdelay dummy
scoreboard objectives add oa.noise dummy
function oa:config
# Installation never opts players in, changes game modes, or edits gamerules.

scoreboard objectives add oa.sonic dummy
scoreboard objectives add oa.back dummy

scoreboard objectives add br.state dummy
scoreboard objectives add br.pick dummy
scoreboard objectives add br.flag dummy
scoreboard objectives add br.time dummy
scoreboard objectives add br.sec dummy
scoreboard objectives add br.live dummy
scoreboard objectives add br.mode dummy
scoreboard objectives add br.saved dummy
scoreboard objectives add br.left dummy
scoreboard objectives add br.tmp dummy
scoreboard objectives add br.x dummy
scoreboard objectives add br.z dummy
scoreboard objectives add br.team dummy
scoreboard objectives add br.phase dummy
scoreboard objectives add br.restore dummy
scoreboard players add #state br.state 0
scoreboard players set #20 br.tmp 20
scoreboard players set #1000 br.tmp 1000

scoreboard players set #two br.tmp 2
scoreboard players set #500 br.tmp 500
scoreboard players set #150 br.tmp 150

scoreboard objectives add br.round dummy
scoreboard objectives add br.retry dummy
scoreboard players add #round br.round 0

scoreboard objectives add br.edge dummy
scoreboard players set #minus1 br.tmp -1

scoreboard objectives add br.out dummy
scoreboard objectives add br.preview dummy
scoreboard players add #vclock br.tmp 0

scoreboard players set #ten br.tmp 10

scoreboard objectives add br.member dummy
scoreboard players set #60 br.tmp 60

function oa:br/ui/load_names

scoreboard objectives add br.chest dummy
scoreboard objectives add br.cstage dummy
scoreboard objectives add br.regen dummy
scoreboard objectives add br.ore dummy
scoreboard objectives add br.ray dummy
scoreboard objectives add br.mcoal minecraft.mined:minecraft.coal_ore
scoreboard objectives add br.mdcoal minecraft.mined:minecraft.deepslate_coal_ore
scoreboard objectives add br.mred minecraft.mined:minecraft.redstone_ore
scoreboard objectives add br.mdred minecraft.mined:minecraft.deepslate_redstone_ore
scoreboard players add #refill br.flag 0

scoreboard objectives add oa.shade dummy

scoreboard objectives add oa.ktimer dummy

scoreboard objectives add oa.hoparc dummy

scoreboard objectives add br.open minecraft.custom:minecraft.open_chest

scoreboard objectives add oa.radar trigger
scoreboard objectives add oa.rindex dummy
scoreboard objectives add oa.rclock dummy

scoreboard objectives add oa.jump minecraft.custom:minecraft.jump
scoreboard objectives add oa.hcool dummy
scoreboard objectives add oa.owait dummy
scoreboard objectives add oa.otime dummy

scoreboard objectives add oa.notice dummy

scoreboard objectives add oa.kpush dummy

scoreboard objectives add oa.kby dummy

scoreboard objectives add oa.hlift dummy

scoreboard objectives add br.join trigger
scoreboard objectives add br.leave trigger
scoreboard objectives add oa.menu trigger
scoreboard objectives add oa.test trigger
scoreboard objectives add br.clean dummy
scoreboard players add #busy br.clean 0
scoreboard players add #clean_ready br.clean 0
scoreboard objectives add oa.gtime dummy
scoreboard players add #total oa.gtime 0
scoreboard objectives add oa.born dummy
scoreboard objectives add br.opened dummy

execute if score #busy br.clean matches 1 run schedule function oa:br/cleanup/wait 1t replace

scoreboard objectives add oa.kboost dummy

scoreboard objectives add br.lcnt dummy
scoreboard objectives add br.lmode dummy
scoreboard players add #quiet_depth oa.tmp 0

scoreboard objectives add br.lobby trigger

scoreboard objectives add oa.mfx dummy
function oa:br/bars/load

scoreboard objectives add oa.root dummy
scoreboard objectives add oa.bleed dummy
scoreboard objectives add oa.bleed_by dummy

scoreboard objectives add oa.small dummy

scoreboard objectives add br.login_leave minecraft.custom:minecraft.leave_game
scoreboard objectives add br.login_seen dummy
scoreboard players add @a br.login_leave 0
execute as @a run scoreboard players operation @s br.login_seen = @s br.login_leave
gamerule minecraft:locator_bar false
execute unless score #state br.state matches 1 run function oa:br/border/idle
scoreboard objectives add br.login_epoch dummy
scoreboard players add #epoch br.login_epoch 1
execute as @a run scoreboard players operation @s br.login_epoch = #epoch br.login_epoch



scoreboard objectives add br.tp_ok dummy
scoreboard objectives add oa.batcool dummy
scoreboard objectives add oa.proj dummy
scoreboard objectives add oa.powner dummy

scoreboard objectives add oa.throw_hits dummy

scoreboard objectives add oa.tpush dummy

scoreboard objectives add oa.roster trigger

scoreboard objectives add oa.ghp dummy

scoreboard objectives add oa.gspeed dummy

scoreboard objectives add oa.gfire dummy

scoreboard objectives add oa.gby dummy

scoreboard objectives add oa.gbomb dummy

scoreboard objectives add oa.gevent dummy

scoreboard objectives add oa.glift dummy

scoreboard objectives add oa.gsize dummy

scoreboard objectives add oa.gpeace dummy

scoreboard objectives add oa.gmood dummy

scoreboard objectives add oa.gglow dummy

scoreboard objectives add oa.gslot dummy

scoreboard objectives add oa.gres_amp dummy

scoreboard objectives add oa.gres_left dummy

scoreboard objectives add oa.fowner dummy

scoreboard objectives add oa.fteam dummy

scoreboard objectives add oa.ftime dummy

scoreboard objectives add oa.fup dummy

scoreboard objectives add oa.lobby trigger

scoreboard objectives add oa.guard_fx dummy

scoreboard objectives add oa.fage dummy

scoreboard objectives add oa.fair dummy

scoreboard objectives add oa.control trigger

scoreboard objectives add oa.pending dummy

scoreboard objectives add oa.qby dummy

scoreboard objectives add oa.qleft dummy

scoreboard objectives add oa.fcage dummy

scoreboard objectives add oa.debug_cmd trigger
scoreboard objectives add oa.db_seen dummy
scoreboard objectives add oa.db_cd dummy
scoreboard objectives add oa.db_unique dummy
scoreboard objectives add oa.db_match dummy
scoreboard objectives add oa.db_grace dummy
scoreboard objectives add oa.db_team dummy
scoreboard objectives add oa.db_consume dummy
scoreboard objectives add oa.db_wear dummy
scoreboard objectives add oa.db_bind dummy
scoreboard objectives add oa.db_mobs dummy
scoreboard objectives add oa.db_heal dummy

execute as @a[tag=oa.debug] at @s run function oa:debug/stop

scoreboard objectives add oa.db_snow minecraft.used:minecraft.snowball
scoreboard objectives add oa.db_egg minecraft.used:minecraft.egg

scoreboard objectives add oa.gallery_id dummy
scoreboard objectives add oa.exbtn dummy
scoreboard objectives add oa.exread dummy

scoreboard objectives add oa.gallery trigger

scoreboard objectives add oa.fvel dummy
scoreboard players set #f_accel oa.tmp 187500
scoreboard players set #f_air95 oa.tmp 95
scoreboard players set #f_air100 oa.tmp 100

scoreboard objectives add oa.riptide minecraft.used:minecraft.trident

scoreboard players set #perf oa.tmp 0

# Interpreted text components must never be an empty list.
data modify storage oa:allies display set value [{text:""}]

execute if score #state br.state matches 0 if data storage oa:br center run function oa:br/border/auto

execute if data storage oa:lobby_job {working:1b} if data storage oa:lobby_job old run schedule function oa:lobby/delete_wait 1t replace

execute if data storage oa_map2:job {deleting:1b} run schedule function oa:map/internal/delete/wait 1t replace

scoreboard objectives add oa.tfall dummy

tag @a add oa.inv_dirty

execute unless data storage oa:lobby_events {initialized:1b} run data modify storage oa:lobby_events skins set value 1b
data modify storage oa:lobby_events initialized set value 1b
execute unless data storage oa:lobby_events {working:1b} run function oa:lobby/events/request

function oa:migration/remove_statistics

scoreboard objectives add oa.gstiff dummy
scoreboard objectives add oa.gexpose dummy
scoreboard objectives add oa.ex_taken minecraft.custom:minecraft.damage_taken
scoreboard objectives add oa.ex_absorb minecraft.custom:minecraft.damage_absorbed
scoreboard objectives add oa.ex_prev dummy
scoreboard objectives add oa.ex_aprev dummy

scoreboard objectives add oa.i_round dummy
scoreboard objectives add oa.i_uses dummy
scoreboard objectives add oa.i_unlock dummy
scoreboard objectives add oa.i_next dummy
scoreboard objectives add oa.i_cycle dummy
scoreboard objectives add oa.i_lock dummy
scoreboard objectives add oa.i_charge dummy
scoreboard objectives add oa.i_range dummy
scoreboard objectives add oa.i_sub dummy
scoreboard objectives add oa.i_stamp dummy
scoreboard objectives add oa.i_shield dummy
scoreboard objectives add oa.i_boost dummy
scoreboard objectives add oa.i_leap dummy
scoreboard objectives add oa.i_yaw dummy
scoreboard objectives add oa.i_frame dummy
execute in minecraft:overworld run kill @e[distance=0..,tag=oa.itori_proxy]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_proxy]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_proxy]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.itori_proxy]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.itori_proxy]

scoreboard objectives add oa.i_fxlife dummy

scoreboard objectives add oa.i_ver dummy
# 練習場に入る前の昭心の進行度の退避先（v1.9.117）
scoreboard objectives add oa.ib_set dummy
scoreboard objectives add oa.ib_pts dummy
scoreboard objectives add oa.ib_ore dummy
scoreboard objectives add oa.ib_chest dummy
scoreboard objectives add oa.ib_round dummy
execute as @a run function oa:itori/migrate1932
execute in minecraft:overworld run kill @e[distance=0..,tag=oa.i_orange_floor]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.i_orange_floor]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.i_orange_floor]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.i_orange_floor]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.i_orange_floor]

execute in minecraft:overworld run kill @e[distance=0..,tag=oa.i_citlali_circle]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.i_citlali_circle]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.i_citlali_circle]
execute in minecraft:overworld run kill @e[distance=0..,tag=oa.i_citlali_column]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.i_citlali_column]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.i_citlali_column]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.i_citlali_circle]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.i_citlali_column]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.i_citlali_circle]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.i_citlali_column]

scoreboard objectives add oa.i_pending dummy
scoreboard objectives add oa.i_castround dummy
scoreboard objectives add oa.i_casttime dummy
execute as @a[tag=oa.itori_windup] run function oa:itori/windup_cancel

scoreboard objectives add oa.i_held dummy

scoreboard objectives add oa.i_flins dummy
scoreboard objectives add oa.i_dive dummy
scoreboard objectives add oa.i_burn dummy
scoreboard objectives add oa.i_burnby dummy

scoreboard objectives add oa.db_hp dummy
scoreboard objectives add oa.db_label dummy

function oa:br/ui/version
scoreboard objectives add oa.i_ore dummy
scoreboard objectives add oa.i_chest dummy
scoreboard objectives add oa.i_points dummy

team add oa_practice
team modify oa_practice friendlyFire false
team modify oa_practice collisionRule never

scoreboard objectives add oa.practice_resp dummy
execute if data storage oa:practice {building:1b} run schedule function oa:practice/build_wait 2t replace

function oa:br/team/setup

execute in oa:practice as @e[type=minecraft:zombie,tag=oa.practice_dummy,tag=!oa.practice_quiet,distance=0..] run function oa:practice/dummy_unname

# 1.9.98 終了時リザルト用の統計
scoreboard objectives add br.st_kill playerKillCount
scoreboard objectives add br.st_dmg minecraft.custom:minecraft.damage_dealt
scoreboard objectives add br.st_walk minecraft.custom:minecraft.walk_one_cm
scoreboard objectives add br.st_sprint minecraft.custom:minecraft.sprint_one_cm
scoreboard objectives add br.st_open dummy
scoreboard objectives add br.st_tmp dummy

# 1.9.98 武器実績
scoreboard objectives add br.pid dummy
scoreboard objectives add br.hstreak dummy
scoreboard objectives add br.hopby dummy

# 1.9.98 空中補給
scoreboard objectives add br.sup dummy
scoreboard objectives add br.st_kp dummy
scoreboard objectives add br.gacha dummy
scoreboard objectives add oa.result trigger
scoreboard objectives add oa.achv trigger
scoreboard objectives add oa.tutorial trigger
scoreboard objectives add oa.tutdone dummy
scoreboard objectives add oa.mission trigger
scoreboard objectives add oa.mclear dummy
scoreboard objectives add br.mdone dummy
scoreboard objectives add br.st_jmp minecraft.custom:minecraft.jump
scoreboard players add #nobeginner br.flag 0
scoreboard objectives add br.suptype dummy
scoreboard objectives add oa.t_games dummy
scoreboard objectives add oa.t_win dummy
scoreboard objectives add oa.t_kill dummy
scoreboard objectives add oa.t_ach dummy
scoreboard objectives add oa.t_rank dummy
scoreboard objectives add oa.dps trigger
scoreboard objectives add oa.spar trigger
scoreboard objectives add oa.dpsb dummy
scoreboard objectives add oa.dpst dummy
scoreboard objectives add oa.sparko dummy
team add oa_spar
team modify oa_spar friendlyFire true
team modify oa_spar collisionRule never

# 1.9.107: spectator camera, highlights, weapon mastery
scoreboard objectives add oa.spec trigger
scoreboard objectives add br.sp dummy
scoreboard objectives add br.wkk dummy
scoreboard objectives add br.wkc dummy
scoreboard objectives add br.surv dummy
scoreboard objectives add br.st_dist dummy
scoreboard objectives add br.mqz minecraft.mined:minecraft.nether_quartz_ore
scoreboard objectives add br.mng minecraft.mined:minecraft.nether_gold_ore
scoreboard objectives add oa.mapid dummy
scoreboard players add #map oa.mapid 0

# 1.9.111: version display (TAB list + /trigger oa.ver) and load-complete message
scoreboard objectives add oa.ver trigger
scoreboard objectives add br.dtmr dummy
scoreboard objectives add br.gkind dummy
scoreboard objectives add br.lkey dummy
scoreboard objectives add br.qwalk minecraft.custom:minecraft.walk_one_cm
scoreboard objectives add br.qspr minecraft.custom:minecraft.sprint_one_cm
scoreboard objectives add br.qsneak minecraft.custom:minecraft.crouch_one_cm
scoreboard objectives add br.qjump minecraft.custom:minecraft.jump
scoreboard players set #3 br.tmp 3
function oa:ach/info
