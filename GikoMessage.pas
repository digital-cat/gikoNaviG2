unit GikoMessage;

interface

uses
	Classes, IniFiles;

type
	//! MessageList
	TGikoMessageListType = (gmLogout, gmLogin, gmForceLogin, gmSureItiran,
			gmUnKnown, gmSureSyutoku, gmSureDiff, gmNotMod, gmAbort, gmError,
			gmNewRes, gmNewSure, gmResError, gmSureError, gmBeLogout, gmBeLogin,
      gmDngLogin, gmDngMailLogin, gmDngLogout, gmDngAuth,
      gmMax);

	TGikoMessage = class(THashedStringList)
	private
	public
		constructor Create;
		function GetMessage(MesType: TGikoMessageListType): String;
	end;

implementation

const
	DEF_MESSAGES : array[0..20] of string = (  'ログアウトしました',
											   'ログインしました - ',
											   '強制ログインしました - ',
											   '[スレ一覧取得完了]',
											   '(名称不明）',
											   '[スレ取得完了]',
											   '[スレ差分取得完了]',
											   '[未更新]',
											   '[中断]',
											   '[エラー]',
											   '[レス送信終了]',
											   '[新スレ送信終了]',
											   '[レス送信失敗]',
											   '[新スレ送信失敗]',
                         'BEログアウトしました',
											   'BEログインしました - ',
                         'どんぐりシステムにログインしました',
                         'どんぐりシステムにログインしました - ',
                         'どんぐりシステムからログアウトしました',
                         'どんぐりシステムで再認証しました',
                         '');

	MESSAGE_KEYS : array[0..20] of String = ( 'Logout', 'Login',
											'ForceLogin', 'SureItiran',
											'UnKnown', 'SureSyutoku',
											'SureDiff', 'NotMod',
											'Abort', 'Error',
											'NewRes', 'NewSure',
											'ResError', 'SureError',
											'BELogout', 'BELogin',
                      'DngLogin', 'DngMailLogin', 'DngLogout', 'DngAuth',
                      'MessageMax');

constructor TGikoMessage.Create;
begin
	inherited Create;
	Self.Sorted := true;
	Self.Duplicates := dupIgnore;
end;
//! MesTypeで指定されたメッセージ文字列を取得する
function TGikoMessage.GetMessage(MesType: TGikoMessageListType): String;
begin
	Result := '';
	if MesType in [gmLogout..gmMax] then begin
		//Keyで検索して見つかればそれを返す
		Result := Self.Values[MESSAGE_KEYS[Ord(MesType)]];
		if Result = '' then begin
			//見つからないので、デフォルトで返す
			Result := DEF_MESSAGES[Ord(MesType)];
		end;
	end;
end;

end.
 