- [GUILTY GEAR Xrd開発スタッフが送るアニメ調キャラモデリングTIPS](https://www.slideshare.net/ASW_Yokohama/guilty-gear-xrdtips-124324946)

# 脚
- [にゃんたろう さんのイラスト一覧 - ニコニコ静画 (イラスト)](https://seiga.nicovideo.jp/user/illust/2849610) 
	- [【ＭＭＤモデル配布】脚 / にゃんたろう さんのイラスト - ニコニコ静画 (イラスト)](https://seiga.nicovideo.jp/seiga/im5164519)

- [https://twitter.com/ksk_st/status/1345360593423802370](https://twitter.com/ksk_st/status/1345360593423802370)
- [【身体の描き方】画力と表現力が劇的に上がる「神技作画」 | イラスト・マンガ描き方ナビ](https://www.clipstudio.net/oekaki/archives/152526)
- [意外と知らないお尻の描き方 ～ステップアップ！イラストを上手く描くコツ！～ | いちあっぷ](https://ichi-up.net/2022/05) 

# room
- [作成した3Dモデルの中にthree.jsで影をつける方法](https://zenn.dev/kaito_takase/articles/c96c2ed77fbaee)

# 練習
- 続けられるように部品化して、部分ごとにアップデートしていく方式にしてみる
- 全部1weight でロボットとかドールみたいな感じにする
- hips - spine - chest - neck -head
	- upper-lower-hand
		- thumb0,1,2
		- index0,1,2
		- middle0,1,2
		- ring0,1,2
		- little0,1,2
	- upper-lower-foot-toe
shoulder 捨てる
部品わけ。交換可能ように大きめに球体関節いれておく
- Hips-Spine-Chest-Neck	
- 球？ Head
- 球 Arm
	- Hand-fingers
- 球 Leg 
	- Foot-Toe		
- 素の glTF エクスポーターで有効な要素を使う
