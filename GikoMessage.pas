unit GikoMessage;

interface

uses
	Classes, IniFiles;

type
	//! MessageList
	TGikoMessageListType = (gmLogout, gmLogin, gmForceLogin, gmSureItiran,
			gmUnKnown, gmSureSyutoku, gmSureDiff, gmNotMod, gmAbort, gmError,
			gmNewRes, gmNewSure, gmResError, gmSureError, gmBeLogout, gmBeLogin);

	TGikoMessage = class(THashedStringList)
	private
	public
		constructor Create;
		function GetMessage(MesType: TGikoMessageListType): String;
	end;

implementation

const
	DEF_MESSAGES : array[0..15] of string = (  '���O�A�E�g���܂���',
											   '���O�C�����܂��� - ',
											   '�������O�C�����܂��� - ',
											   '[�X���ꗗ�擾����]',
											   '(���̕s���j',
											   '[�X���擾����]',
											   '[�X�������擾����]',
											   '[���X�V]',
											   '[���f]',
											   '[�G���[]',
											   '[���X���M�I��]',
											   '[�V�X�����M�I��]',
											   '[���X���M���s]',
											   '[�V�X�����M���s]',
                                               'BE���O�A�E�g���܂���',
											   'BE���O�C�����܂��� - ');

	MESSAGE_KEYS : array[0..15] of String = ( 'Logout', 'Login',
											'ForceLogin', 'SureItiran',
											'UnKnown', 'SureSyutoku',
											'SureDiff', 'NotMod',
											'Abort', 'Error',
											'NewRes', 'NewSure',
											'ResError', 'SureError',
                                            'BELogout', 'BELogin');

constructor TGikoMessage.Create;
begin
	inherited Create;
	Self.Sorted := true;
	Self.Duplicates := dupIgnore;
end;
//! MesType�Ŏw�肳�ꂽ���b�Z�[�W��������擾����
function TGikoMessage.GetMessage(MesType: TGikoMessageListType): String;
begin
	Result := '';
	if MesType in [gmLogout..gmBeLogin] then begin
		//Key�Ō������Č�����΂����Ԃ�
		Result := Self.Values[MESSAGE_KEYS[Ord(MesType)]];
		if Result = '' then begin
			//������Ȃ��̂ŁA�f�t�H���g�ŕԂ�
			Result := DEF_MESSAGES[Ord(MesType)];
		end;
	end;
end;

end.
 