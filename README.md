# vrc_check_log_of_added_friends
VRChatにて、特定のログファイルから追加されたフレンドのページを開く\
（今回遊んで新しくフレンドになった人に、ノート書いとかなきゃ……ってのが結構あったので）

# 最初に確認すること
- VRChatのログ出力機能をあらかじめ有効化しておいてください。\
（「設定」の「デバッグ情報」にあります。）

# 手順
1. 「ログファイルを解析する.bat」を起動する
2. 解析したいログファイルを選択する。（一応VRCのログファイルがおいてある場所が開くはず）
3. 勝手にブラウザでユーザのページが表示される。

# 注意
- 個人的に作ったものなので、動作保証は不可です。\
VRCの仕様変更等で動作しなくなる可能性があります。

- ログファイルの仕様を勝手に予想して作ったものですので、フレンド外の人が表示される可能性があります。\
例えば、フレンド追加後すぐに解除された場合は想定していません。\
上記の場合は、おそらくユーザページが開きます。

- ログファイルは放置すると勝手に消えるらしいです。\
保存しておきたい場合は、消える前にバッチを流すか、バックアップを取っておいてください。

# 仕様
ざっくりログファイルを確認した感じ、フレンド追加時にログファイルの「is no longer Muted」が流れてそうだったので、\
その文字列をGrepし、ユーザIDを探してリンクを開くみたいな感じです。

ちゃんとGUIを作らず*バッチ*と*シェルスクリプト*にしたのは、単にめんどくさかったからです。\
まぁ、個人用に作ったのがメインなので……

# その他利用に関して
基本的な使用に対して制限はしません。\
MITライセンスに準拠してください。
