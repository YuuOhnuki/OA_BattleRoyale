summon minecraft:text_display ~ ~0.9 ~ {Tags:["tdm.loot_label","tdm.label_new"],text:{text:""},billboard:"center",background:1073741824,line_width:220,view_range:0.5f,brightness:{block:15,sky:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.65f,0.65f,0.65f]}}

data modify entity @e[tag=tdm.label_new,limit=1] text set from storage oa:tdm_label component
