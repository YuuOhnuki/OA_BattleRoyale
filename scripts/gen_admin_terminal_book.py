"""Paginated admin reference. Existing action IDs remain unchanged."""
import json,sys,re
from pathlib import Path
r=Path(sys.argv[1]);out=r/'data/oa/function/admin'
danger={3,4,7,13,14,47,48,56,57,58}|{base+n for base in [60,80,100] for n in [1,2,3,9,10]}
groups=[('試合運営',[(2,'準備状態'),(5,'BRソロ開始'),(6,'BRチーム開始'),(7,'試合を中止')]),('プレイヤー',[(35,'対象を選んで管理'),(38,'自分のゲームモード'),(39,'自分を復活')]),('ロビー・練習場',[(4,'現在地にロビー作成'),(14,'ロビーを再建'),(32,'ロビーへ移動'),(46,'展示を更新'),(58,'練習場を生成')])]
for name,base in [('地上',60),('ネザー',80),('古代都市',100)]:
 labels=['中心へ移動','会場を生成','会場を再生成','会場を削除','現在地を中心に','生成した中心を使う','ボーダー自動設定','開始地点を追加','開始地点を確認','近くの地点を削除','全開始地点を削除','この会場を選択']
 groups.append((name+'会場',[(base+i,label) for i,label in enumerate(labels)]))
groups += [('固有装備',list(zip([20,21,22,23,24,25,26,27,36,53],['ゆうあ','ぴちぴち','らじ','ねろ','キリング','ゆったり','ほちきす','こまめ','たやゆゆ','いとり']))),('消耗品・武器',[(28,'ゆー'),(37,'ふろボール'),(9,'木のバット'),(10,'ノックバック棒'),(17,'バフ医療品4種'),(42,'包帯'),(43,'応急キット'),(44,'雪玉16個'),(45,'卵16個')]),('診断・保守',[(33,'基本設定を補完'),(34,'飛び道具の診断'),(40,'デバッグ開始'),(41,'デバッグ本'),(51,'展示スキン更新'),(16,'管理ブックを更新')]),('旧管理操作',[(3,'選択会場を生成'),(11,'生成を停止'),(12,'生成を再開'),(13,'選択会場を再生成'),(29,'現在地を中心登録'),(30,'生成した中心を使う'),(31,'会場の中心へ移動'),(47,'ロビーを削除'),(48,'選択会場を削除'),(49,'ボーダー自動設定')])]
groups.append(('旧開始地点操作',[(54,'開始地点を追加'),(55,'開始地点を確認'),(56,'近くの地点を削除'),(57,'全開始地点を削除')]))
def t(s,color='black',**kw):return dict(text=s,color=color,**kw)
def cmd(label,c):return t('▸ '+label+'\n','dark_blue',underlined=True,click_event={'action':'run_command','command':c})
def nav(label,p):return t(label+'\n','dark_blue',underlined=True,click_event={'action':'change_page','page':p})
def page(title,parts):return {'raw':{'text':'','extra':[t(title+'\n\n','dark_purple',bold=True)]+parts}}
pages=[page('運営ダッシュボード',[t('$(mode) / $(map)\n$(state)\n\n'),cmd('管理メニュー','/oamenu'),cmd('出撃設定・開始','/oa host'),cmd('更新確認・反映','/oamenu updates'),nav('全操作の目次',2)]),None,None]
starts=[]
for name,items in groups:
 starts.append((name,len(pages)+1))
 for start in range(0,len(items),5):
  parts=[]
  for code,label in items[start:start+5]:parts.append(cmd(label+(' ※' if code in danger else ''),'/oamenu confirm:'+str(code) if code in danger else '/trigger oa.admin set '+str(code)))
  if start+5<len(items):parts.append(nav('次の項目 ›',len(pages)+2))
  parts.append(nav('‹ 目次',2));pages.append(page(name,parts))
pages[1]=page('管理目次 1/2',[nav(name,n) for name,n in starts[:5]]+[nav('次の目次 ›',3)])
pages[2]=page('管理目次 2/2',[nav(name,n) for name,n in starts[5:]]+[nav('‹ 前の目次',2)])
book={'title':{'raw':'OA 管理ブック'},'author':'OA','generation':0,'resolved':False,'pages':pages}
(out/'book_content.mcfunction').write_text('$give @s minecraft:written_book[minecraft:written_book_content='+json.dumps(book,ensure_ascii=False,separators=(',',':'))+',minecraft:custom_name={text:"OA 管理ブック",color:"gold",italic:false},minecraft:custom_data={oa_admin_book:1b,book_v202:1b},minecraft:max_stack_size=1] 1\n',encoding='utf-8')
lines=['execute unless entity @s[tag=br.admin] run return 0','clear @s *[minecraft:custom_data~{oa_admin_book:1b}]','scoreboard players set #admin_free oa.tmp 0']
for slot in [f'hotbar.{n}' for n in range(9)]+[f'inventory.{n}' for n in range(27)]:lines.append(f'execute unless items entity @s {slot} * run scoreboard players set #admin_free oa.tmp 1')
lines+=['execute if score #admin_free oa.tmp matches 0 run return run tellraw @s {text:"本を受け取るため持ち物に空きを作ってください",color:"yellow"}', 'data modify storage oa:admin_book mode set value "BR"','execute if score #game oa.game matches 1 run data modify storage oa:admin_book mode set value "TDM"','data modify storage oa:admin_book map set value "地上"','execute if score #map oa.mapid matches 1 run data modify storage oa:admin_book map set value "ネザー"','execute if score #map oa.mapid matches 2 run data modify storage oa:admin_book map set value "古代都市"','execute if score #game oa.game matches 1 run data modify storage oa:admin_book map set value "立体工廠"','data modify storage oa:admin_book state set value "待機中（取得時点）"','execute if score #state br.state matches 1.. run data modify storage oa:admin_book state set value "試合進行中（取得時点）"','function oa:admin/book_content with storage oa:admin_book','tellraw @s {text:"管理ブックを更新しました。最新状態は /oamenu で確認",color:"gold"}']
(out/'book.mcfunction').write_text('\n'.join(lines)+'\n',encoding='utf-8')
print('Admin book:',len(pages),'pages; at most 5 actions per reference page')
