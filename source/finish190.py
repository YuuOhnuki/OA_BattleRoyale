from pathlib import Path
exec(Path('release_1_9_0/build190.py').read_text().split('# Permission and session gates.')[0])
# Debug mace locks and periodic state cleanup.
edit('debug/restore_slot','$execute if items entity @s $(slot) *[minecraft:enchantments~[{enchantments:"oa:debug_curse"}]]','$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:5}}]')
# Native cooldown is restored as soon as its restriction is re-enabled.
add('debug/patch_hand','$execute unless entity @s[tag=oa.db_free_cd] if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/restore_furo_cooldown')
# First build did not put a snapshot root before nested writes in shuffle; create it explicitly.
edit('debug/gacha/9','data modify storage oa:db_shuffle positions set value []','data modify storage oa:db_shuffle positions set value []\ndata modify storage oa:db_shuffle args set value {}')
# Attribute-aware melee controls and mob counter callback.
d=json.loads((P/'data/oa/advancement/nero/decoy_hit.json').read_text())
d['criteria']['hit']['conditions']['player']={'type':'minecraft:all_of','terms':[d['criteria']['hit']['conditions']['player'],{'type':'minecraft:entity_properties','entity':'this','predicate':{'minecraft:nbt':'{Tags:["oa.db_mobs"]}'}}]}
d['criteria']['hit']['conditions']['damage']['type']['source_entity']={'minecraft:nbt':'{Tags:["oa.debug_mob"]}'}
d['rewards']['function']='oa:debug/nero_hit';j('advancement/debug/nero_hit.json',d)
w('debug/nero_hit','advancement revoke @s only oa:debug/nero_hit\nfunction oa:nero/decoy_hit')
# Never let a debug player counter their own execution recursively.
p=P/'data/oa/enchantment/hat.json';d=json.loads(p.read_text())
for e in d['effects']['minecraft:post_attack'][:2]:
 branch=e['requirements']['terms'][1]
 branch['terms'].append({'type':'minecraft:inverted','term':{'type':'minecraft:damage_source_properties','predicate':{'tags':[{'id':['oa:execution','oa:yuua_counter'],'expected':True}]}}})
j('enchantment/hat.json',d)
# The generic root damage protection gate also honors the opted-in caster.
edit('hotchikisu/root_target','execute if entity @s[tag=br.pvp_grace]','execute unless entity @a[tag=oa.caster,tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace]')
# Simple stable native horizontal Motion for mob explosions.
w('debug/mob/blast_push','''tag @s add oa.db_blast_victim
execute at @e[type=minecraft:item_display,tag=oa.f_current,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["oa.db_blast_dir"]}
execute as @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=oa.db_blast_victim,limit=1] feet
execute at @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] rotated as @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] rotated ~ 0 positioned ^ ^ ^1.2 run summon minecraft:marker ~ ~ ~ {Tags:["oa.db_blast_vector"]}
execute store result score #db_vec_x oa.tmp run data get entity @e[tag=oa.db_blast_vector,limit=1] Pos[0] 10000
execute store result score #db_vec_z oa.tmp run data get entity @e[tag=oa.db_blast_vector,limit=1] Pos[2] 10000
execute store result score #db_base_x oa.tmp run data get entity @e[tag=oa.db_blast_dir,limit=1] Pos[0] 10000
execute store result score #db_base_z oa.tmp run data get entity @e[tag=oa.db_blast_dir,limit=1] Pos[2] 10000
scoreboard players operation #db_vec_x oa.tmp -= #db_base_x oa.tmp
scoreboard players operation #db_vec_z oa.tmp -= #db_base_z oa.tmp
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get #db_vec_x oa.tmp
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get #db_vec_z oa.tmp
data modify entity @s Motion[1] set value 0.45d
kill @e[tag=oa.db_blast_dir]
kill @e[tag=oa.db_blast_vector]
tag @s remove oa.db_blast_victim''')
# Source ownership on furoball mobs is preserved by the existing owner id.
# Fix temporary lifetime contexts so stopped debug projectiles do not survive to a real match.
pre('furoball/tick','execute if entity @s[tag=oa.db_projectile] unless entity @a[tag=oa.debug] run return run kill @s')
# Restore private component patches if a test item is dropped or passed to another player.
j('item_modifier/debug/mark_patch.json',{'type':'minecraft:set_custom_data','tag':'{oa_db_patch:1b}'})
j('item_modifier/debug/clear_patch.json',{'type':'minecraft:set_custom_data','tag':'{oa_db_patch:0b}'})
add('debug/patch_hand','$item modify entity @s $(slot) oa:debug/mark_patch')
add('debug/restore_slot','$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_db_patch:1b}] run item modify entity @s $(slot) oa:debug/clear_patch')
# Restore all patched inventory slots on a non-debug player's next check.
w('debug/restore_foreign','\n'.join(f'execute if items entity @s {s} *[minecraft:custom_data~{{oa_db_patch:1b}}] run function oa:debug/restore_slot {{slot:"{s}"}}' for s in [f'hotbar.{i}' for i in range(9)]+[f'inventory.{i}' for i in range(27)]+['weapon.offhand']))
pre('player_tick','execute unless entity @s[tag=oa.debug] run function oa:debug/restore_foreign')
# Dropped curse variants are returned to the normal binding enchantment unconditionally.
add('world_tick','''execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa_db_patch:1b}}}}] run function oa:debug/restore_ground
execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5}}}}}] run item modify entity @s contents oa:debug/bind''')
w('debug/restore_ground','''item modify entity @s contents oa:debug/remove_remainder
execute if items entity @s contents *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s contents oa:debug/restore_furo_cooldown
item modify entity @s contents oa:debug/clear_patch''')
# The debug multi-inventory variant still upgrades every item, but its head slot is manual.
# Register item-test utilities missing from the old book.
add('admin/dispatch','''execute if score @s oa.admin matches 42 run loot give @s loot oa:debug/bandage
execute if score @s oa.admin matches 43 run loot give @s loot oa:debug/kit
execute if score @s oa.admin matches 44 run give @s minecraft:snowball 16
execute if score @s oa.admin matches 45 run give @s minecraft:egg 16''')
for id,base,mod in [('bandage','minecraft:paper','heal1'),('kit','minecraft:paper','heal2')]:
 j('loot_table/debug/'+id+'.json',{'type':'minecraft:generic','pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':base,'functions':[{'type':'minecraft:reference','name':'oa:medical/'+mod}]}]}]})
# Native use remainder doesn't cover thrown snowballs or eggs; replenish their use counters.
add('load','scoreboard objectives add oa.db_snow minecraft.used:minecraft.snowball\nscoreboard objectives add oa.db_egg minecraft.used:minecraft.egg')
add('debug/tick','''execute if entity @s[tag=oa.db_infinite,gamemode=!creative] if score @s oa.db_snow matches 1.. run function oa:debug/refund_snow
execute if entity @s[tag=oa.db_infinite,gamemode=!creative] if score @s oa.db_egg matches 1.. run function oa:debug/refund_egg
scoreboard players set @s oa.db_snow 0
scoreboard players set @s oa.db_egg 0''')
for n in ['snow','egg']:
 w('debug/refund_'+n,f'''execute store result storage oa:debug_refund count int 1 run scoreboard players get @s oa.db_{n}
function oa:debug/refund_{n}_macro with storage oa:debug_refund''')
 w('debug/refund_'+n+'_macro','$give @s minecraft:'+('snowball' if n=='snow' else 'egg')+' $(count)')
# Short labels and deliberate pagination: all nine uniques share ONE page.
def text(s,color='black',**kw):return {'text':s,'color':color,**kw}
def btn(s,cmd,color='dark_blue'):return text(s,color,underlined=True,click_event={'action':'run_command','command':cmd})
def page(title,*parts):return {'raw':{'text':'','extra':[text(title+'\n━━━━━━━━━━━━\n','dark_purple',bold=True),*parts]}}
def adminbtn(s,n):return btn(s+'\n','/trigger oa.admin set '+str(n))
uniques=[('ゆうあ',20),('ぴちぴち',21),('lazi',22),('ネロ',23),('キリング',24),('ゆったり',25),('ほちきす',26),('こまめ',27),('たやゆゆ',36)]
itempage=page('固有装備を入手',text('クリックで1個入手\n','gray'),*[adminbtn(n,i) for n,i in uniques])
items2=page('消耗品・通常武器',*[adminbtn(n,i) for n,i in [('ゆー｜オーバーワーク',28),('ふろボール',37),('木のバット',9),('ノックバック棒',10),('包帯',42),('応急キット',43),('バフ医療品6種',17),('雪玉 ×16',44),('卵 ×16',45)]])
def bookgive(title,pages,marker,namecolor='gold',macro=False):
 c={'title':{'raw':title},'author':'OA BattleRoyale','generation':0,'resolved':True,'pages':pages}
 cmd='give @s minecraft:written_book[minecraft:written_book_content='+json.dumps(c,ensure_ascii=False,separators=(',',':'))+',minecraft:custom_name='+json.dumps(text(title,namecolor,italic=False),ensure_ascii=False,separators=(',',':'))+',minecraft:custom_data='+json.dumps(marker,separators=(',',':'))+',minecraft:max_stack_size=1] 1'
 return ('$' if macro else '')+cmd
adminpages=[page('OA 管理メニュー',text('青文字をクリックして操作\n\n','gray'),adminbtn('① 準備状態を確認',2),adminbtn('② ソロで試合開始',5),adminbtn('② チームで試合開始',6),adminbtn('試合を中止して復元',7),adminbtn('デバッグ開始／専用ブック',40),text('\n右下の矢印で次のページへ','gray')),
 page('準備・中心座標',*[adminbtn(n,i) for n,i in [('現在地をBR中心に登録',29),('生成したマップ中心を使う',30),('登録した中心へ移動',31),('現在地にマップを生成',3),('現在地にロビーを作成',4),('基本設定を補完',33),('ロビーへ移動',32)]],text('\n生成は周囲を書き換えます。','red')),
 page('参加者・復活',adminbtn('プレイヤーを選んで管理',35),text('参加・観戦・復活・GM変更\n\n','gray'),adminbtn('自分のゲームモード',38),adminbtn('自分を復活',39),adminbtn('自分の統計',15)),itempage,items2,
 page('生成・統計の管理',*[adminbtn(n,i) for n,i in [('生成を停止',11),('生成を再開',12),('マップを全面再生成',13),('ロビーを再建',14),('累計統計をリセット',8),('飛び道具の状態確認',34)]],text('\n再生成・統計消去は取り消せません。','red')),
 page('デバッグの使い方',text('待機中に本人の制限を変更。\n通常の試合開始で自動解除。\n\n','black'),adminbtn('デバッグを開始',40),adminbtn('デバッグブックを再発行',41),text('\n専用ブックでCT・所持数・標的・消費などを切替。','gray'))]
w('admin/book','''execute unless entity @s[tag=br.admin] run return 0
clear @s *[minecraft:custom_data~{oa_admin_book:1b}]
'''+bookgive('OA 管理ブック',adminpages,{'oa_admin_book':True,'book_v190':True})+'\ntellraw @s {text:"管理ブック：右クリックで開く → 青文字をクリック。",color:"gold"}')
# Debug book embeds readable snapshots of each personal setting; reissue on every toggle.
opts=[('cd','CT制限'),('unique','固有装備1個制限'),('match','試合中・生存者限定'),('grace','保護期間の使用制限'),('team','味方へのスキル無効'),('consume','OA消耗品の消費'),('wear','帽子・マスクの時間消耗'),('bind','キリングの取り外し禁止'),('mobs','モブも標的にする'),('heal','ロビー自動回復')]
prep=['execute unless entity @s[tag=br.admin,tag=oa.debug] run return run tellraw @s {text:"管理ブックからデバッグを開始してください。",color:"yellow"}','clear @s *[minecraft:custom_data~{oa_debug_book:1b}]']
for key,_ in opts:
 prep += [f'data modify storage oa:debug_book {key} set value "なし"',f'execute if score @s oa.db_{key} matches 1 run data modify storage oa:debug_book {key} set value "あり"']
prep+=['function oa:debug/book_give with storage oa:debug_book','tellraw @s {text:"デバッグブックを更新しました。開き直すと現在の設定が表示されます。",color:"aqua"}']
w('debug/book','\n'.join(prep))
dbpages=[page('デバッグ操作',text('設定は自分だけに適用\n試合開始・再参加で解除\n\n','gray'),btn('状態を更新\n','/trigger oa.debug_cmd set 3'),btn('CT・状態をリセット\n','/trigger oa.debug_cmd set 4'),btn('デバッグを終了\n','/trigger oa.debug_cmd set 2','dark_red'),adminbtn('自分のゲームモード',38),text('\n標的テストはサバイバル推奨。','gray'))]
for a,b,title in [(0,5,'制限の切り替え 1'),(5,10,'制限の切り替え 2')]:
 parts=[]
 for i in range(a,b):
  key,label=opts[i];parts.extend([btn(label+'\n','/trigger oa.debug_cmd set '+str(100+i)),text('現在：$('+key+')\n','dark_green')])
 dbpages.append(page(title,*parts))
dbpages += [page('標的を用意する',btn('動かない標的（牛）\n\n','/trigger oa.debug_cmd set 5'),btn('反撃用ハスクを出す\n\n','/trigger oa.debug_cmd set 6'),btn('周囲のテスト用モブを削除\n','/trigger oa.debug_cmd set 7'),text('\n通常のモブも48m内で対象化。\nロビーの展示物は対象外。','gray')),itempage,items2,
 page('テストの範囲',text('対象は近くのモブとデバッグ中の管理者。一般プレイヤーは巻き込みません。\n\nCT・消費・寿命などを「あり」にすると通常制限を再現。\n\n搭乗中・壁判定・同時発射数の安全制限は残ります。','black'))]
w('debug/book_give',bookgive('OA デバッグブック',dbpages,{'oa_debug_book':True,'book_v190':True},'aqua',True))
# Participant guide: clear action page, concise rules, readable grouped gear cards.
playerpages=[page('OA バトルロワイヤル',text('探索 → 装備 → 最後の生存者へ\n\n','dark_green',bold=True),btn('▶ ゲームに参加\n\n','/trigger oa.lobby set 1'),btn('▷ 観戦する\n\n','/trigger oa.lobby set 2'),btn('↩ ロビーへ戻る\n\n','/trigger oa.lobby set 6'),btn('★ 自分の統計\n','/trigger oa.lobby set 3'),text('\n次ページ：チーム選択','gray')),
 page('チームを選ぶ',text('同じ色が味方です。\nソロ戦では各自で戦います。\n\n','gray'),*[btn('チーム'+str(i)+'（'+c+'）\n','/trigger oa.lobby set '+str(100+i),col) for i,c,col in [(1,'赤','dark_red'),(2,'青','dark_blue'),(3,'緑','dark_green'),(4,'黄','gold'),(5,'紫','dark_purple')]]),
 page('チームを選ぶ 2',*[btn('チーム'+str(i)+'（'+c+'）\n\n','/trigger oa.lobby set '+str(100+i),col) for i,c,col in [(6,'水色','dark_aqua'),(7,'桃','light_purple'),(8,'橙','gold'),(9,'白','gray'),(10,'黒','black')]]),
 page('試合の流れ',text('① マップ内へランダム配置\n② 最初の1分は保護期間\n③ チェスト・鉱石から補給\n④ 開始6分でチェスト補充\n⑤ 安置が段階的に縮小\n⑥ 最後の1人／1チームが勝利\n\n倒されると観戦へ。\n安置の外ではダメージ！','black')),
 page('探索のコツ',text('通常の破壊・設置はできません。登録された鉱石は採掘でき、1分で戻ります。\n\n石炭：食料や満腹度回復\n赤石：医療品やHP回復\n\n包帯はすぐ回復。応急キットは2秒かけて使用。バフ医療品は10秒間の強化。','black')),
 page('固有装備の基本',text('1人1個まで。交換したいときは現在の固有装備を捨てます。\n\n手持ち武器：右クリックでスキル。頭装備：右クリックで装着。\n\nキリングは通常取り外せず、1分で壊れます。\nCTはアクションバーを確認。','black'))]
gear=[('ゆうあ：麦わら帽子','攻撃と反撃で相手を倒す。光り続ける30秒の使い捨て帽子。'),('ぴちぴち：冷凍さかな','速く走り、高く跳ぶ。殴った相手をしばらく跳ねさせる。'),('lazi：防音マスク','周囲に音波攻撃。ときどき息切れして動きが遅くなる。'),('ネロ：ペスト医師の杖','右クリックで印・帰還。しゃがみ右クリックで本人デコイ。CT10秒。'),('キリング：呪いのきマスク','速く動き、敵の攻撃を25%で無効化。盲目と大音量に注意。'),('ゆったり：瞬間奇襲','相手の背後へ奇襲し、1秒後に戻る。CT10秒。'),('ほちきす：ホッチキス','右クリックで近くの相手を2.5秒拘束。殴ると出血。CT15秒。'),('こまめ：小豆バー','10秒間ちび化して強化。殴ると鈍足。CT20秒。'),('たやゆゆ：変態ガチャ','右クリックで16種類の効果からランダム発動。CT45秒。')]
for i in range(0,len(gear),2):
 parts=[]
 for title,desc in gear[i:i+2]:parts += [text(title+'\n','dark_blue',bold=True),text(desc+'\n\n')]
 playerpages.append(page('固有装備ガイド',*parts))
playerpages += [page('特別な消耗品',text('ゆー｜オーバーワーク\n','dark_red',bold=True),text('致死ダメージを身代わりに受ける。発動後は強化と反動。\n\n'),text('ふろボール\n','dark_red',bold=True),text('右クリックで投げる。爆風で敵を押し出し、自分は跳ね上がる。次の着地まで落下無効。'))]
p=F/'lobby/guide/book.mcfunction';s=p.read_text();lines=s.splitlines();lines=[l for l in lines if not l.startswith('give @s minecraft:written_book')];s='\n'.join(lines).replace('guide_v182','guide_v190')+'\n'+bookgive('OA ロビー案内',playerpages,{'oa_player_book':True,'guide_v190':True},'aqua')+'\n';p.write_text(s)
add('admin/menu','tellraw @s [{text:"[デバッグを開始]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/trigger oa.admin set 40"}}]')
# Existing docs remain the single installation guide.
p=P/'README_JA.md';s=p.read_text();s+='''

## 管理ブック・デバッグ
管理者は `/trigger oa.admin set 16` で新版の管理ブックを受け取れます。試合・準備・参加者・固有装備・通常アイテムを分類し、全9種類の固有装備を1ページにまとめました。一般プレイヤーの案内ブックも、操作→チーム→試合の流れ→アイテムの順に整理しています。

待機中に管理ブックの「デバッグ開始」を選ぶと、本人専用のデバッグブックを配布します。初期状態はCTなし、複数所持可、待機中も使用可、味方対象可、OA消耗品無消費、帽子・マスクの時間消耗なし、キリング取り外し可、モブ対象あり、ロビー回復なしです。ブックの制限ページで各項目を「あり／なし」に切替できます。変更後は本を開き直してください。「試合中・生存者限定」をありにすると待機中限定のデバッグでは該当する試合専用スキルが使えなくなります。

デバッグ設定は他人やワールド全体には適用しません。対象は半径48mの通常モブとデバッグ参加中の管理者で、展示物や一般のロビープレイヤーは対象外です。標的の牛・攻撃用ハスクを本から出せます。実ダメージを試す場合はサバイバルにしてください。ハスクは難易度ピースフルでは維持できません。

「デバッグ終了」、試合開始、死亡、退出後の再参加、リロードで通常設定へ戻ります。終了時に所持品を全消去しません。通常の1個制限へ戻った際の余剰固有装備は消さずに地面へ返します。生成した標的の削除は本の専用ボタンから行います。

消費なしはOAの包帯・応急キット・バフ医療品・ふろボール・ゆー、および雪玉・卵を対象とします。医療品とふろボールは使用後に同じアイテムが残る方式、雪玉・卵は使用回数分を次tickに返す方式です。通常の食料や装備の打撃耐久は対象外です。デバッグ中に変更したOAアイテムを地面へ捨てると通常設定へ戻します。

モブではプレイヤーと体格・重さ・移動AIが違うため、吹き飛び量等は同一にはなりません。空腹はプレイヤー専用です。待機中のガチャ復活結果は「脱落者なし」を表示し、通常試合の復活テストは実際の試合で行います。デバッグの集合・席替えは近くのテスト対象の位置を使い、中央登録を要求しません。搭乗中の発射制限、壁・未読込チャンクの安全確認、同時投射上限は解除しません。

新たなデバッグ用エンチャントを含むため、初回更新時はサーバーを再起動してください。リソパとマップの再生成は不要です。ファイル検査と静的な分岐検査のみ実施し、サーバー読み込み・プレイヤー・複数人テストは未実施です。
''';p.write_text(s)
# Current helpers/build sources are included, private transfer helpers are not.
import shutil
shutil.copyfile('release_1_9_0/build190.py',P/'source/build190.py')
shutil.copyfile('release_1_9_0/finish190.py',P/'source/finish190.py')
