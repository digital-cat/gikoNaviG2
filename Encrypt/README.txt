CryptoWrapper for Delphi 6  Personal (Windows)

【概要】
WindowsのCryptoAPIを使うwrapperです。
パスワード抜きで暗号化するとか、そういう用途。
勿論パスワードつけてもいいです。
いや、つけたほうが何かと安心。

【動作環境】
CryptoAPI の動作環境は以下の通りらしいです。
  Windows NT: Requires version 4.0 or later.
  Windows: Requires Windows 95 OSR2 or later
	 (or Windows 95 with IE 3.02 or later).
  Windows CE: Unsupported.

【最初に弱点？】
パスワードをつけずにEncodeする場合、UserKey(EXCHANGE)を利用してます。
これがまだ無い場合に限りKeyを生成するようにしてあ(りま|るつもりで）すが、
どこかでKeyを上書で作られると保存しておいたモノが復号できなくなって、
「壊れてないのになんで読めないの？」になります。

パスワードをつけてEncodeする場合は上記は関係ないですけど、
そうすると他のフリーなコード方が汎用的かも。
折衷案として、パスワード付きで別途保存しておくというのもアリかもです。
「ペットの名前は？」とかいうやつ。

【その他】
UserKeyはWindowsのユーザ毎に管理されてるみたいです。
パスワードをつけなかった場合、Encodeしたのとは別の
アカウント(Windowsのヤツ)では復号できません。


【フォルダ】
CryptAuto
	キーコンテナやUserの交換キーが無ければ勝手に作っちゃう
	お任せバージョンです。

Crypt4Init
	キーコンテナやUserの交換キーが無ければ作る　だけ　のサンプルAPです。
	上記のCryptAutoを呼んでるだけです。
	キーを作るのは１回やっとけば良いんで。

Crypt
	「キーコンテナやUserの交換キーが無ければ勝手に作っちゃう」部分を
	削除したバージョンです。
	無い場合には勿論暗号化できません。
	お任せバージョンが不安な時に。

CryptPwdOnly
	キーコンテナが無ければ作るけどUserの交換キーは作らないバージョンです。
	パスワードを指定する場合にはこれで間に合います。

Innacurate
	<em>インチキ</em>Base64です。
	暗号化自体とは関係ありません。
	ちょっと書いてみただけ。

【Usage】
	class THogeCrypt*;	// * のところはUnitとか参照して下され

	constructor THogeCrypt*.Create;	// 準備
	destructor THogeCrypt*.Destroy;	// 済んだ

	function THogeCrypt*.Encrypt(	// 暗号化する
		PlainText: TStream;	// [in] 暗号化したいもの
		Password: String;	// [in] パスワード。空文字列でも可。
		Encrypted: TStream	// [out]暗号化されて出てくる
	): Boolean;	// 失敗したらFalse

	function THogeCrypt*.Decrypt(	// 復号する
		Crypted: TStream;	// [in] 暗号化されてるもの
		Password: String;	// [in] パスワード。空文字列も有り。
		Decrypted: TStream	// [out]復号されて出てくる
	): Boolean;	// 失敗したらFalse

	暗号化されたモノはバイナリ列になります。

【一番大切なこと】
無保証。改造その他何でもご自由に。

This program is free software, and distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

-----------------------
2002 Twiddle
