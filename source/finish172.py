from pathlib import Path
import json,shutil,re
p=Path('revision/pack');f=p/'data/oa/function';b=f/'tayayuyu';m=b/'move'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# Abort if anyone could not be captured; do not grant gather protection after a failed commit.
x=b/'gather.mcfunction';s=x.read_text().replace('scoreboard players set #g_tries oa.tmp 8','execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort\nexecute unless score #g_count oa.tmp matches 1.. run return run function oa:tayayuyu/move/abort\nscoreboard players set #g_tries oa.tmp 8').replace('execute as @a[tag=br.alive] at @s run function oa:tayayuyu/peace','execute unless score #g_commit_ok oa.tmp matches 1 run return 0\nexecute as @a[tag=br.alive] at @s run function oa:tayayuyu/peace');w(x,s)
x=m/'commit.mcfunction';w(x,'scoreboard players set #g_commit_ok oa.tmp 0\n'+x.read_text()+'\nscoreboard players set #g_commit_ok oa.tmp 1\n')
x=m/'check.mcfunction';s=x.read_text();s=s.replace('execute if score #g_dx oa.tmp < #g_limit oa.tmp run scoreboard players add #g_loc_ok oa.tmp 0\n','').replace('scoreboard players operation #g_limit oa.tmp *= #g_two oa.tmp\nscoreboard players operation #g_limit oa.tmp -= #g_limit oa.tmp','scoreboard players set #g_limit oa.tmp 0');w(x,s)
# Moving clears position locks, but does not cure bleeding or ongoing jumps.
x=m/'player.mcfunction';s=x.read_text().replace('function oa:hotchikisu/status_cleanup\nfunction oa:status/end_hop','''attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
tag @s remove oa.stapled
scoreboard players set @s oa.root 0''');w(x,s)
# Own time-limited effects survive equipment cleanup; native effects retain hidden lower effects.
w(b/'refresh_effects.mcfunction','''execute if score @s oa.gpeace matches 1.. run function oa:tayayuyu/refresh_peace
execute if score @s oa.gmood matches 1.. run function oa:tayayuyu/refresh_mood
execute if score @s oa.gglow matches 1.. run function oa:tayayuyu/refresh_glow
''')
for obj,effect,amp,typ in [('gpeace','resistance',4,'peace'),('gmood','blindness',0,'mood'),('gglow','glowing',0,'glow')]:
 w(b/f'refresh_{typ}.mcfunction',f'''scoreboard players operation #g_effect_time oa.tmp = @s oa.{obj}
scoreboard players add #g_effect_time oa.tmp 19
scoreboard players set #g_twenty oa.tmp 20
scoreboard players operation #g_effect_time oa.tmp /= #g_twenty oa.tmp
execute store result storage oa:g_effect seconds int 1 run scoreboard players get #g_effect_time oa.tmp
function oa:tayayuyu/effect_{typ} with storage oa:g_effect
''')
 w(b/f'effect_{typ}.mcfunction',f'$effect give @s minecraft:{effect} $(seconds) {amp} true\n')
x=b/'tick.mcfunction';s=x.read_text();s=s.replace('execute if score @s oa.gsize matches 1.. run return 0','function oa:tayayuyu/refresh_effects\nexecute if score @s oa.gsize matches 1.. run return 0',1);w(x,s)
# Docs describe the current behavior and durations; existing files only.
x=p/'WEAPONS_JA.md';s=x.read_text().replace('7種から等確率','16種から等確率').replace('7種の全体','16種の全体').replace('ガチャ7種','ガチャ16種').replace('各結果は1/7','各結果は1/16（6.25%）')
s=s.replace('| TNT | 足元にTNTの表示を置き、2秒後に爆発演出。半径4m内へ最大6HP。同じガチャの複数爆発が重なっても1回分まで。地形破壊なし |','''| TNT | 足元にTNTの表示を置き、2秒後に爆発演出。半径4m内へ最大6HP。同じガチャの複数爆発が重なっても1回分まで。地形破壊なし |
| 全員ちび化 | 生存者全員が通常の0.5倍サイズ、15秒 |
| 席替えタイム | 生存者同士で安全確認済みの位置をランダム交換。2人以上で自分自身の場所には当たらない。危険な元位置は安置内の代替地点へ |
| 強制集合 | 中央周辺へ全員を配置し、3秒間保護。安全な配置先がなければ移動中止 |
| 平和な世界 | 生存者全員を5秒間保護。通常のPvP・環境・エリア外ダメージを無効化。特殊攻撃スキルも使用不可 |
| 全員キリング気分 | 生存者全員に盲目と移動速度属性＋50%、5秒。お面や呪いは配布しない |
| 丸見え大会 | 生存者全員に発光10秒。各自の位置で派手な爆発音・花火風の粒子 |
| 空腹の時間 | 生存者全員に空腹Iを10秒 |
| 全員巨大化 | 生存者全員が通常の1.75倍サイズ、10秒 |
| 大ハズレ：自己紹介 | 使用者だけ15秒発光し、使用者の名前を全参加者へ通知。音・花火風の粒子 |''')
s+='''
サイズ変更は新しいガチャ結果で上書きし、重ね掛けで極端なサイズにはしません。こまめの縮小中はガチャのサイズを優先し、終了時にこまめの効果が残っていればそのサイズへ戻ります。巨大化は低い天井・狭い通路で詰まる場合があり、実機確認が必要です。
席替えはランダムな順序に並べた参加者の位置を、0以外のランダムな個数だけずらす方式です。全員の位置を先に保存し、安置・床・頭上・溶岩等を検査してから移動。強制集合は中央から最大8m、現在の安置内で配置を試行。移動時は本人デコイ・ゆったりの帰還待ち・ほちきすの位置拘束を解除し、勝手に元の場所へ引き戻されないようにします。印・出血・跳ね・CTは保持します。移動中止でもガチャのCTは消費します。
平和・強制集合の保護には既存のPvP保護用チームと耐性Vを使用し、終了時に元の対戦チームを戻します。管理者の /kill や奈落等のバニラで耐性を無視する致死処理は対象外です。
固有装備9種の表示名は「人の名前：二つ名」に統一し、既存の所持品と地面アイテムも更新します。固有装備ではない「ゆー | オーバーワーク」の名称は維持します。
''';w(x,s)
x=p/'README_JA.md';s=x.read_text().replace('ガチャ7種','ガチャ16種').replace('7種のガチャ','16種のガチャ').replace('データパック1.7.0','データパック1.7.2')
s+='''
たやゆゆのガチャは16種類から等確率（各6.25%）、CT45秒。追加9種類の内容・継続時間・安全な移動の制約はWEAPONS_JA.mdに記載しています。平和／強制集合の保護終了時は元の試合チームへ復帰します。固有装備9種は「人の名前：二つ名」の表示名へ自動更新します。リソースパックは完全版1.7.0を継続使用します。マップ再生成は不要です。
''';w(x,s)
x=p/'LOOT_JA.md';s=x.read_text();s+='\nたやゆゆのスキル内抽選は全16結果が各6.25%です。装備自体の出現率・ほかのアイテムの出現率は変更しません。\n';w(x,s)
shutil.copy('/tmp/finish172.py',p/'source/finish172.py')
print('172 fixes and docs written')
