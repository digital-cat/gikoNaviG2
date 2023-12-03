# ギコナビ避難所版II ﾊﾞﾀ73(1.74.0.876) 人柱版

本ソフトウェアは、ギコナビ避難所版 ﾊﾞﾀ70(1.71.0.861)からの改造版です。

### ﾊﾞﾀ73の主な変更点
- HTTPS対応
- ５ちゃんねる対応
- UPLIFT対応
- したらば仕様変更対応

### 変更履歴
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

### 開発環境
- Delphi 2007
- Indy10
- OpenSSL
- Tnt Delphi UNICODE Controls
