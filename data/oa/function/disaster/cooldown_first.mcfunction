# 1.9.212：試合の最初の災害までの秒（cfg.first_min〜first_max。1.9.211 までは 50〜80）
$execute store result score #dis_cd br.tmp run random value $(first_min)..$(first_max)
