from pathlib import Path
import json,zipfile,re,shutil
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_4_1'
def comp(t,**kw):return dict(text=t,**kw)
def button(label,n):return comp(label+'\n\n',color='dark_blue',underlined=True,click_event={'action':'run_command','command':f'/trigger oa.admin set {n}'})
def page(title,buttons,note=''):
 xs=[comp(title+'\n\n',color='dark_purple',bold=True)]+[button(t,n) for t,n in buttons]
 if note:xs.append(comp(note,color='dark_gray'))
 return {'raw':{'text':'','extra':xs}}
pages=[page('OA 管理ブック', [('準備チェック',2),('ソロ開始',5),('チーム開始',6),('試合中止・復元',7)],'クリックで実行\n管理者のみ操作可'),page('生成・配置', [('現在地にマップ生成',3),('現在地にロビー作成',4),('生成を停止',11),('生成を再開',12)],'新規生成・作成は範囲を上書きします。'),page('再建・記録', [('マップを全面再生成',13),('ロビーを再建',14),('累計統計を全消去',8),('自分の統計を見る',15)],'上書き・消去に注意。先にワールドを保存。'),page('アイテムテスト', [('木のバットを入手',9),('ノックバック棒を入手',10),('バフ6種を入手',17),('チャット管理メニュー',1)],'試合のアイテム制限は通常どおり有効。'),{'raw':{'text':'使い方\n\n右クリックで本を開き、青い項目をクリックします。\n\n現在地基準の操作は、立っている場所で実行します。\n\n結果はチャットに表示。閉じたら再度開いてください。\n\n再発行：\n/trigger oa.admin set 16','color':'black'}}]
book={'title':{'raw':'OA 管理ブック'},'author':'OA BattleRoyale','generation':0,'resolved':True,'pages':pages}
cs={'minecraft:written_book_content':book,'minecraft:custom_name':{'text':'OA 管理ブック','color':'gold','italic':False},'minecraft:custom_data':{'oa_admin_book':True},'minecraft:max_stack_size':1,'minecraft:lore':[{'text':'右クリックで開く／項目をクリックして管理','color':'gray','italic':False}]}
args=','.join(k+'='+json.dumps(v,ensure_ascii=False,separators=(',',':')) for k,v in cs.items())
text='''execute unless entity @s[tag=br.admin] run return 0
execute if items entity @s inventory.* *[minecraft:custom_data~{oa_admin_book:1b}] run return run tellraw @s {text:"管理ブックはインベントリ内にあります。右クリックで開いてください。",color:"gold"}
execute if items entity @s hotbar.* *[minecraft:custom_data~{oa_admin_book:1b}] run return run tellraw @s {text:"管理ブックはホットバーにあります。右クリックで開いてください。",color:"gold"}
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_admin_book:1b}] run return run tellraw @s {text:"管理ブックはオフハンドにあります。",color:"gold"}
'''+f'give @s minecraft:written_book[{args}] 1\n'+'tellraw @s {text:"OA管理ブックを配布しました。右クリックで開いて操作できます。",color:"green"}\n'
(F/'admin/book.mcfunction').write_text(text)
with (F/'admin.mcfunction').open('a') as f:f.write('function oa:admin/book\n')
with (F/'admin/dispatch.mcfunction').open('a') as f:f.write('execute if score @s oa.admin matches 16 run function oa:admin/book\nexecute if score @s oa.admin matches 17 run function oa:give/buffs\n')
with (F/'admin/menu.mcfunction').open('a') as f:f.write('tellraw @s [{text:"[管理ブックを受け取る]",color:"gold",click_event:{action:"run_command",command:"/trigger oa.admin set 16"}}]\n')
p=P/'README_JA.md';s=p.read_text().replace('以後は `/trigger oa.admin` とチャットのクリック式メニューで操作します。','初回登録時に「OA 管理ブック」が配布されます。右クリックで本を開き、青い項目をクリックして操作します。本のページは試合・生成・再建と統計・テスト・案内に分かれています。従来の `/trigger oa.admin` とチャットメニューも使用できます。本の再発行は `/trigger oa.admin set 16`。持ち物に既にある場合は追加配布しません。');s=s.replace('ほかのプレイヤーが管理用triggerを実行しても','本を渡しても管理権限は移りません。ほかのプレイヤーが本や管理用triggerを実行しても');s=s.replace('| 管理メニュー | /trigger oa.admin |','| 管理ブック再発行 | /trigger oa.admin set 16 |\n| チャット管理メニュー | /trigger oa.admin |');p.write_text(s)
for p in [P/'pack.mcmeta',P/'VALIDATION.json',P/'README_JA.md',F/'br/ui/start.mcfunction']:
 s=p.read_text().replace('1.4.0','1.4.1');p.write_text(s)
shutil.copyfile(__file__,P/'source/make_book141.py')
# Check actual page length and actions; references must resolve to guarded dispatch actions.
for pg in pages:
 raw=pg['raw'];text=raw.get('text','')+''.join(c['text'] for c in raw.get('extra',[]));assert text.count('\n')<=14
 for c in raw.get('extra',[]):
  if 'click_event' in c:
   n=int(c['click_event']['command'].split()[-1]);assert f'matches {n} run' in (F/'admin/dispatch.mcfunction').read_text() or n==13
for p in P.rglob('*.json'):json.loads(p.read_text())
for p in P.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),p
  m=re.search(r'(?:^\$?|\brun )function (oa(?:_map2|_map)?:[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   n,f=m[1].split(':',1);assert (P/f'data/{n}/function/{f}.mcfunction').exists(),(p,m[1])
with zipfile.ZipFile(O/'OA_BattleRoyale_v1.4.1.zip','w',zipfile.ZIP_DEFLATED) as z:
 for p in P.rglob('*'):
  if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(P))
with zipfile.ZipFile(O/'OA_BattleRoyale_v1.4.1.zip') as z:assert z.testzip() is None
print('Pass:5 structured pages, actions map to guarded dispatcher, function refs/JSON/ZIP. Runtime not tested.')
