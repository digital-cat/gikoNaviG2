# ギコナビ(避難所版II)　変更履歴

### ﾊﾞﾀ75の主な変更点
- どんぐり対応
- 板別Cookie管理廃止
- IPv6対応
- NGワード形式に正規表現２（SkRegExp）追加
- その他改良／不具合修正

### ﾊﾞﾀ74の主な変更点
- Unicode対応
- お絵描き（画像添付）対応
- 投稿プレビューのCSS／スキン適用対応
- その他改良／不具合修正

### ﾊﾞﾀ73の主な変更点
- HTTPS対応
- ５ちゃんねる対応
- UPLIFT対応
- したらば仕様変更対応

## リリース毎の変更履歴

#### 2024/12/22 ﾊﾞﾀ75(1.75.1.911)
- 個別あぼーん解除画面変更
- わっちょいをNGワードに追加する際に左側の記号を含むよう修正
- URL補完対象に「imgur.com/」追加

#### 2024/12/17 ﾊﾞﾀ74(1.75.0.910)
- デバッグログ出力削除

#### 2024/12/17 ﾊﾞﾀ74(1.75.0.909)
- NGワードの形式に正規表現２（SkRegExp）を追加
- 画像プレビューのサイズ選択肢追加
- ID:CAP_USERの日時・IDの強調表示機能を追加
- 同じワッチョイのレスあぼーん／NGワード登録機能追加
- 画像プレビュー表示するファイル拡張子に「.jpg:orig」追加
- UPLIFTログインエラーが多発する場合がある問題改善

#### 2024/10/27 ﾊﾞﾀ74(1.75.0.908)
- 同じワッチョイへのアンカー表示機能追加
- UPLIFT非ログイン時の巡回制限緩和
- 画像プレビューHTMLにキャッシュ不使用のヘッダ追加
- 画像プレビュー表示するファイル拡張子に「.jpg:large」追加
- URLのリンク作成改良
- どんぐりシステム画面のログイン情報表示等改良

#### 2024/09/29 ﾊﾞﾀ74(1.75.0.907)
- URLのプロトコル短縮表記判定改良
- どんぐりシステム画面でIME制御しない設定追加

#### 2024/09/16 ﾊﾞﾀ74(1.75.0.906)
- レスのdatコピー機能追加
- どんぐりシステム画面配色変更（ダークからライト）でアイテムリスト背景色が変わらない不具合修正（一部改善）
- 警備員メール登録WEBページ変更に対応
- URLのプロトコル短縮表記パターン追加（ps://、s://、://）

#### 2024/09/02 ﾊﾞﾀ74(1.75.0.905)
- どんぐりシステムホーム画面自動更新機能追加
- ハンターの警備員認識設定対応

#### 2024/08/20 ﾊﾞﾀ74(1.75.0.904)
- どんぐりアイテムバッグ仕様変更に対応
- どんぐりサービスで資源パック作成に対応
- どんぐりアリーナ及びログへのリンクを追加

#### 2024/08/12 ﾊﾞﾀ74(1.75.0.903)
- どんぐりアイテムバッグ仕様変更に対応
- まちBBSプラグインで鯖名のないURLに対応

#### 2024/07/14 ﾊﾞﾀ74(1.75.0.902)
- どんぐり用通信モジュールを通信毎に再構築するオプション追加
- どんぐり「ロックされていない装備をすべて解体」仕様変更対応

#### 2024/07/09 ﾊﾞﾀ74(1.75.0.901)
- どんぐり用通信モジュールを通信毎に再構築する修正（検証用修正）

#### 2024/07/08 ﾊﾞﾀ74(1.75.0.900)
- itest版URLのコピー及びWEBブラウザ表示・アドレスバー表示に対応
- 書き込み成功時に対象のスレ一覧またはスレを再読み込みするオプション追加
- オプション画面「その他動作１」「その他動作２」の項目整理
- シリアルNo.付きどんぐりアイテムの表記に対応
- どんぐりアイテム関係のエラー発生時にアイテムの操作ができなくなる不具合修正

#### 2024/06/23 ﾊﾞﾀ74(1.75.0.899)
- どんぐりアイテム強化画面に降下（ダウングレード）機能追加
- どんぐり装備中アイテムの強化ボタン追加
- スレタイあぼーんに透明あぼーん機能追加
- スレURLクリック時にプロトコル違い（http/https）を無視するよう変更

#### 2024/06/19 ﾊﾞﾀ74(1.75.0.898)
- Windows11でスレの先頭部分しか表示されない場合がある問題の対処方法追加
- どんぐりシステム画面装備中アイテムの表示方法変更

#### 2024/06/16 ﾊﾞﾀ74(1.75.0.897)
- どんぐりシステム画面でお知らせを名前として拾ってしまう不具合を修正

#### 2024/06/16 ﾊﾞﾀ74(1.75.0.896)
- どんぐりシステム画面HP項目表示に対応
- どんぐりシステム画面アイテム強化に対応

#### 2024/06/08 ﾊﾞﾀ74(1.75.0.895)
- どんぐりシステム画面変更に対応
- ギコナビ起動時のどんぐりシステム自動ログイン機能追加
- ギコナビ本体でのどんぐりシステムログイン・ログアウト・再認証機能追加

#### 2024/06/02 ﾊﾞﾀ74(1.75.0.894)
- どんぐりシステム画面変更に対応
- どんぐりシステム自動ログインに対応

#### 2024/05/31 ﾊﾞﾀ74(1.75.0.893)
- 警備員アカウントの登録に対応
- 警備員及びハンターのメールによるログインに対応
- どんぐりシステム各サービスのコスト情報取得機能追加
- どんぐりアイテムのソート機能追加

#### 2024/05/25 ﾊﾞﾀ74(1.75.0.892)
- デバッグコードが有効化されていた不具合を修正

#### 2024/05/25 ﾊﾞﾀ74(1.75.0.891)
- どんぐりシステム画面仕様変更対応
- どんぐりシステム宝箱仕様変更対応
- ハンターネーム変更・どんぐり転送対応
- どんぐりシステムWEBリンク追加
- レスエディタどんぐり枯れメッセージ変更対応
- Cookie削除メニュー選択時のガイドメッセージ追加
- UPLIFT Cookie期限切れ時にログアウトするよう変更

#### 2024/05/21 ﾊﾞﾀ74(1.75.0.890)
- どんぐりシステム仕様変更対応

#### 2024/05/19 ﾊﾞﾀ74(1.75.0.889)
- どんぐりシステム画面レイアウト変更
- 工作センター鉄のキー作成対応
- 警備員の制限削除
- レスエディタ引用して貼り付けの不具合修正
- 書き込みエラー時のスクリプトエラー表示抑止

#### 2024/05/13 ﾊﾞﾀ74(1.75.0.888)
- どんぐりシステムアイテムバッグ機能追加
- どんぐりシステム画面アイコンタスクバー表示オプション追加
- 表示済みどんぐりシステム画面前面表示処理追加
- 「TAKO」Cookie受信検知機能追加

#### 2024/05/03 ﾊﾞﾀ74(1.75.0.887)
- User-Agent内バージョン番号固定機能追加
- どんぐり大砲の玉作成機能追加
- どんぐりシステム画面ダークモード追加
- ポップアップメニュー先頭にどんぐり大砲表示追加
- クラシック版URL対応

#### 2024/04/28 ﾊﾞﾀ74(1.75.0.886)
- どんぐりシステム画面改修
- どんぐりレベル復活対応
- ログ検索画面不具合修正

#### 2024/04/22 ﾊﾞﾀ74(1.75.0.885)
- ドングリシステム画面改修
- どんぐり大砲改修
- Cookie管理画面追加
- 板別Cookie・オプション画面どんぐりCookie廃止
- どんぐりが枯れたメッセージにログアウトの選択肢追加

#### 2024/04/15 ﾊﾞﾀ74(1.75.0.884)
- ドングリシステム画面修正
- どんぐり大砲機能追加
- broken_acornエラー時にCookieを消すかどうか選択できるよう変更

#### 2024/04/13 ﾊﾞﾀ74(1.75.0.883)
- IPv6設定のリセットボタンが無効化されない不具合修正

#### 2024/04/13 ﾊﾞﾀ74(1.75.0.882)
- UPLIFTの自動ログインがエラーになる不具合修正
- Cookie処理を大幅見直し
- どんぐりCookie処理改善
- ドングリシステムへのログインと情報表示
- IPv6有効時の除外ドメインリストを初期値に戻す機能追加

#### 2024/04/07 ﾊﾞﾀ74(1.75.0.881)
- どんぐり暫定対応
- IPv6有効時にギコナビ更新でエラーになる不具合修正

#### 2024/03/23 ﾊﾞﾀ74(1.75.0.880)
- IPv6対応
- 板一覧更新で除外板を指定できるよう変更
- レス投稿時に改行コードを付けないよう変更
- レス全体再取得時に手動あぼ～ん情報をクリアしないオプション追加

#### 2024/01/08 ﾊﾞﾀ74(1.75.0.879)
- ギコナビ更新画面変更
- リンクバーの位置を復元できない不具合修正
- Beログイン不具合修正

#### 2023/12/30 ﾊﾞﾀ74(1.74.1.878)
- 画像添付機能有効無効設定追加
- 画像添付ボタン位置改良
- Beログインをセキュア接続に変更

#### 2023/12/10 ﾊﾞﾀ73(1.74.0.877)
- ５ちゃんねるレス書き込みに画像添付機能追加
- Shift-JISモード書き込み無効化

#### 2023/12/03 ﾊﾞﾀ73(1.74.0.876)
- 起動時にエラーメッセージが表示される場合がある不具合修正

#### 2023/12/03 ﾊﾞﾀ73(1.74.0.875)
- スレ一覧のUnicode対応処理一部見直し
- レスエディタのスキン適用プレビューからリンク及びイベント削除
- レスエディタCSS/スキン適用プレビューのbodyタグに"preview"クラス追加
- Shift-JISモードのスレ立てエディタにUnicodeモードのタイトル欄が表示される不具合修正

#### 2023/11/27 ﾊﾞﾀ73(1.74.0.874)
- ウインドウタイトルUnicode対応
- オプション項目追加：エディタのフォント設定を板情報表示にも適用
- オプション項目追加：プレビュー表示にCSSまたはスキンを適用
- レス番号を含むスマホURLの不具合修正
- サーバ名のないスマホURL対応

#### 2023/11/18 ﾊﾞﾀ73(1.74.0.873)
- Unicode対応強化
- ダークcssスクロールバー色設定
- マウスジェスチャー設定を保存／読み込みできない不具合修正
- キー設定の編集中に選択したショートカットキーが変わってしまう不具合修正

#### 2023/11/11 ﾊﾞﾀ73(1.74.0.872)
- Unicode対応強化
- スレ立て送信パラメータ配置を870相当に戻す
- ダーク系スタイルシート追加

#### 2023/11/03 ﾊﾞﾀ73(1.74.0.871)
- Unicode対応強化

#### 2023/10/23 ﾊﾞﾀ73(1.74.0.870)
- レスエディタのUnicode対応強化
- IDのNGワード追加時にslipを除外するよう変更
- ソースコード整理

#### 2023/10/16 ﾊﾞﾀ73(1.74.0.869)
- 範囲あぼーん機能追加
- レス内の５ちゃんURL判定を改善

#### 2023/09/23 ﾊﾞﾀ73(1.74.0.868)
- 書き込み失敗時の文字化け修正
- アドレスバーに２ちゃんねるURLを入力するとwebブラウザで表示する不具合修正
- スマホURLに対応

#### 2023/09/18 ﾊﾞﾀ73(1.73.0.867)
- dat落ち／過去ログ取得の不具合修正

#### 2023/08/26 ﾊﾞﾀ72(1.72.0.866)
- UPLIFTに対応
- 一部だけ取得済みでdat落ちしたスレを続きから取得するよう修正

#### 2023/08/26 ﾊﾞﾀ72(1.72.0.865)
- ギコナビ更新に対応
- スレタブのスクロールボタンで右クリックした際の不具合修正

#### 2023/08/13 ﾊﾞﾀ72(1.72.0.864)
- ５ちゃんねる投稿で不要となったCookieを送らないよう修正
- 一部だけ取得済みでdat落ちしたスレを取得した際の不具合修正
- スレ絞り込み履歴が表示されない不具合修正
- OpenSSLドキュメント追加
- OpenSSLバージョン情報表示

#### 2023/08/05 ﾊﾞﾀ72(1.72.0.863)
- 保存されたタブの２ちゃんねるURLからの復元に対応
- 強制再取得／あぼーん再取得の不具合修正
- スレURLがポップアップ表示されない不具合修正
- 投稿内容に「&」が含まれているとそこで切れてしまう不具合修正

#### 2023/07/30 ﾊﾞﾀ72(1.72.0.862)
- HTTPS対応
- ５ちゃんねる対応
- したらば仕様変更対応
