import json,os,sys
R=sys.argv[1]
adv=f"{R}/data/oa/advancement/ach"; fn=f"{R}/data/oa/function"
masters=[(1,"yuua_master","帽子の主","golden_helmet","ゆうあ"),(2,"fish_master","大漁旗","cod","ぴちぴち"),
(3,"lazi_master","騒音の主","note_block","lazi"),(4,"nero_master","疫病神","spider_eye","ネロノワール"),
(5,"curse_master","呪われし者","wither_skeleton_skull","キリング"),(6,"yuttari_master","影の暗殺者","ender_pearl","ゆったり"),
(7,"hotchikisu_master","針山","arrow","ほちきす"),(8,"komame_master","豆台風","slime_ball","こまめ"),
(9,"tayayuyu_master","ガチャの申し子","amethyst_shard","たやゆゆ"),(10,"itori_master","いとりの申し子","lightning_rod","いとり")]
hidden=[("peace_win","平和主義者","white_banner","1キルもせずに優勝した"),
("walker","地平線の向こうへ","leather_boots","1試合で3000m以上移動した"),
("jumper","ウサギ跳び","rabbit_foot","1試合で300回以上ジャンプした"),
("close_call","紙一重","glistering_melon_slice","体力1ハート以下で優勝した"),
("first_out","開幕ダッシュ失敗","skeleton_skull","試合で最初に脱落した"),
("weapon_all","武器博士","beacon","10種すべての固有武器マスター実績を解除した")]
def w(id,title,desc,icon,frame,hid):
    d={"parent":"oa:ach/root","display":{"icon":{"id":"minecraft:"+icon},"title":{"text":title},"description":{"text":desc},"frame":frame,"show_toast":True,"announce_to_chat":False,"hidden":hid},"criteria":{"done":{"trigger":"minecraft:impossible"}}}
    json.dump(d,open(f"{adv}/{id}.json","w"),ensure_ascii=False,indent=2)
ids=[]; lst=[]
for k,id,t,ic,n in masters:
    desc=f"{n}：固有武器を装備したまま3キル連続した"
    w(id,t,desc,ic,"goal",False); ids.append(id)
    lst.append((id,t,desc,False))
for id,t,ic,desc in hidden:
    w(id,t,desc,ic,"challenge" if id=="weapon_all" else "goal",True); ids.append(id); lst.append((id,t,desc,True))
with open(f"{fn}/ach/list.mcfunction","a") as f:
    for id,t,desc,h in lst:
        f.write(f'\nexecute if entity @s[advancements={{oa:ach/{id}=true}}] run tellraw @s [{{text:"✔ ",color:"green"}},{{text:"{t}",color:"gold"}},{{text:" ／ {desc}",color:"gray"}}]')
        if h: f.write(f'\nexecute unless entity @s[advancements={{oa:ach/{id}=true}}] run tellraw @s [{{text:"・ ",color:"dark_gray"}},{{text:"？？？",color:"dark_gray"}},{{text:" ／ 隠し実績",color:"dark_gray"}}]')
        else: f.write(f'\nexecute unless entity @s[advancements={{oa:ach/{id}=true}}] run tellraw @s [{{text:"・ ",color:"dark_gray"}},{{text:"{t}",color:"white"}},{{text:" ／ {desc}",color:"dark_gray"}}]')
with open(f"{fn}/br/stats/count_ach.mcfunction","a") as f:
    for id in ids: f.write(f'\nexecute if entity @s[advancements={{oa:ach/{id}=true}}] run scoreboard players add @s oa.t_ach 1')
with open(f"{fn}/ach/revoke_all.mcfunction","a") as f:
    for id in ids: f.write(f'\nadvancement revoke @s only oa:ach/{id}')
