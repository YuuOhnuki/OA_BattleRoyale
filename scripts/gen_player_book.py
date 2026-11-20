"""Short player guide; generated from current rules. No inventory slot is overwritten."""
from pathlib import Path
import json
r=Path(__file__).resolve().parents[1]; f=r/'data/oa/function/lobby/guide/book.mcfunction'
def page(title,body,links):
 e=[{'text':title+'\n\n','color':'dark_aqua','bold':True},{'text':body+'\n\n','color':'black'}]
 for label,command in links:e.append({'text':'▸ '+label+'\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':command}})
 return {'raw':{'text':'','extra':e}}
pages=[
page('ようこそ OAへ','探索と固有武器で戦うゲームです。\n正面へ少し進むと出撃受付。\n参加→チーム→準備完了！',[('メニュー /oa','/oa'),('参加・観戦','/oa play')]),
page('BRとTDM','BR：装備を集め、最後まで生き残る。ソロとチーム戦。\nTDM：赤青2チーム、5分間のキル数勝負。',[('ゲーム案内','/oa mode'),('マップを見る','/oa maps')]),
page('参加とチーム','参加状態はメニュー上部で確認。\nチーム変更は試合前に。\nBRは各最大3人。TDMは開始時に人数を調整。',[('参加・観戦','/oa play'),('チームを選ぶ','/oa team')]),
page('TDMの出撃','最初と復活待ちの10秒間に武器を選べます。\n死亡するとチェーン防具へ。\n地面の武器はシフトで交換。',[('固有武器を選ぶ','/tdm')]),
page('練習場','荷物を預けて武器を試せます。\n退出時は練習の荷物を消し、預けた荷物を戻します。\n参加登録とチームは保持。',[('練習場メニュー','/oa practice')]),
page('固有武器の操作','基本は右クリックでスキル。武器の説明に操作とCTを表示。\n展示室はロビー左側。\nゆーは在庫から自動発動。',[('武器を練習する','/oa practice')]),
page('記録と遊び方','右のギャラリーに戦績を展示。\n自分の戦績・実績・前回の結果はメニューから確認。\n案内本の再取得もできます。',[('戦績・実績','/oa records'),('遊び方 / 案内本','/oa guide')])]
prefix=['execute if entity @s[tag=br.playing] run return 0','execute if entity @s[tag=oa.practice] run return 0']
for slot in ['inventory.*','hotbar.*','weapon.offhand']:
 prefix.append(f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa_player_book:1b,guide_v202:1b}}] run return 0')
prefix+=['clear @s *[minecraft:custom_data~{oa_player_book:1b}]','scoreboard players set #guide_free oa.tmp 0']
for slot in [f'hotbar.{n}' for n in range(9)]+[f'inventory.{n}' for n in range(27)]:prefix.append(f'execute unless items entity @s {slot} * run scoreboard players set #guide_free oa.tmp 1')
prefix.append('execute if score #guide_free oa.tmp matches 0 run return run tellraw @s {text:"案内本を受け取るには持ち物に空きを作ってください。メニューは /oa",color:"yellow"}')
content={'title':{'raw':'OA はじめての案内'},'author':'OA','generation':0,'resolved':True,'pages':pages}
prefix.append('give @s minecraft:written_book[minecraft:written_book_content='+json.dumps(content,ensure_ascii=False,separators=(',',':'))+',minecraft:custom_name={text:"OA はじめての案内",color:"aqua",italic:false},minecraft:custom_data={oa_player_book:1b,guide_v202:1b},minecraft:max_stack_size=1] 1')
f.write_text('\n'.join(prefix)+'\n',encoding='utf-8')
assert all(len(''.join(x['text'] for x in p['raw']['extra']))<170 for p in pages)
print('Player guide:',len(pages),'short pages')
