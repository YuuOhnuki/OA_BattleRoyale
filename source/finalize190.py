from pathlib import Path
import json,shutil
P=Path('revision/pack');F=P/'data/oa/function'
# Match the 26.3 loot-entry field name. Copy the existing, already-used modifiers verbatim.
for n,kind in [('bandage','heal1'),('kit','heal2')]:
 p=P/'data/oa/loot_table/debug'/f'{n}.json';d=json.loads(p.read_text());entry=d['pools'][0]['entries'][0];entry.pop('functions',None);entry['modifier']=[json.loads((P/'data/oa/item_modifier/medical'/f'{kind}.json').read_text())];p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
# Initialize tests before normal item-grant routes without requiring a separate chat command.
p=F/'admin/dispatch.mcfunction';s=p.read_text();at=s.index('execute if score @s oa.admin matches 1 run');s=s[:at]+'''execute if score @s oa.admin matches 20..28 run function oa:test/join
execute if score @s oa.admin matches 36..37 run function oa:test/join
'''+s[at:];p.write_text(s)
# Use the normal event-wide TNT damage cap for debug mobs as well.
p=F/'tayayuyu/bomb_explode.mcfunction';s=p.read_text().replace('as @e[tag=oa.debug_mob,distance=..4] run damage @s 6 minecraft:explosion','as @e[tag=oa.debug_mob,distance=..4] at @s run function oa:tayayuyu/bomb_prepare');p.write_text(s)
# Undead mobs must not be damaged by a player-oriented instant-health helper.
p=F/'debug/gacha/1.mcfunction';p.write_text('execute as @e[tag=oa.target] at @s run function oa:debug/gacha/health\n')
p=F/'debug/gacha/health.mcfunction';p.write_text('''execute unless entity @s[tag=oa.debug_mob] run return run function oa:tayayuyu/health
attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:max_health modifier add oa:gacha_hp 20 add_value
scoreboard players set @s oa.ghp 300
execute store result score #db_hp oa.tmp run data get entity @s Health 1000
scoreboard players add #db_hp oa.tmp 20000
execute store result score #db_max oa.tmp run attribute @s minecraft:max_health get 1000
execute if score #db_hp oa.tmp > #db_max oa.tmp run scoreboard players operation #db_hp oa.tmp = #db_max oa.tmp
execute store result entity @s Health float 0.001 run scoreboard players get #db_hp oa.tmp
tag @s add oa.gacha_affected
tag @s add oa.gacha_hp
''')
# Keep binding restoration safe on items picked up by normal players, even before test enrollment.
p=F/'tick.mcfunction';s=p.read_text();s='execute as @a[tag=!oa.player,tag=!oa.debug] run function oa:debug/restore_foreign\n'+s;p.write_text(s)
# Drop-only repairs are conditional to avoid rewriting every helmet every tick in a real match.
p=F/'world_tick.mcfunction';s=p.read_text().replace('execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5}}}}}] run item modify entity @s contents oa:debug/bind','execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:enchantments":{"oa:debug_curse":1}}}}] run item modify entity @s contents oa:debug/bind');p.write_text(s)
# Versioned book granting remains automatic for players, but admins explicitly reissue via menu.
# Precise scope notes.
p=P/'README_JA.md';s=p.read_text();s+='''
管理ブックの新版は全9固有装備を同じページに掲載しています。デバッグ時のモブには通常攻撃の魚ジャンプ・こまめ鈍足・ほちきす出血、音波・奇襲・拘束・ふろボールなどを適用します。雪玉・卵はバニラの飛行・衝突を維持し、消滅した直後の既存OA追加効果処理にもデバッグ対象を含めます。モブのノックバックにはMobのMotionを使う箇所があり、プレイヤーと移動距離は揃いません。
''';p.write_text(s)
# Builders are retained as source, not importable libraries.
p=Path('release_1_9_0/finish190.py');s=p.read_text();p.write_text('from pathlib import Path\n'+s)
for n in ['build190.py','finish190.py','polish190.py','finalize190.py']:
 shutil.copyfile(Path('release_1_9_0')/n,P/'source'/n)
