CryptoWrapper for Delphi 6  Personal (Windows)

�y�T�v�z
Windows��CryptoAPI���g��wrapper�ł��B
�p�X���[�h�����ňÍ�������Ƃ��A���������p�r�B
�ܘ_�p�X���[�h���Ă������ł��B
����A�����ق��������ƈ��S�B

�y������z
CryptoAPI �̓�����͈ȉ��̒ʂ�炵���ł��B
  Windows NT: Requires version 4.0 or later.
  Windows: Requires Windows 95 OSR2 or later
	 (or Windows 95 with IE 3.02 or later).
  Windows CE: Unsupported.

�y�ŏ��Ɏ�_�H�z
�p�X���[�h��������Encode����ꍇ�AUserKey(EXCHANGE)�𗘗p���Ă܂��B
���ꂪ�܂������ꍇ�Ɍ���Key�𐶐�����悤�ɂ��Ă�(���|�����Łj�����A
�ǂ�����Key���㏑�ō����ƕۑ����Ă��������m�������ł��Ȃ��Ȃ��āA
�u���ĂȂ��̂ɂȂ�œǂ߂Ȃ��́H�v�ɂȂ�܂��B

�p�X���[�h������Encode����ꍇ�͏�L�͊֌W�Ȃ��ł����ǁA
��������Ƒ��̃t���[�ȃR�[�h�����ėp�I�����B
�ܒ��ĂƂ��āA�p�X���[�h�t���ŕʓr�ۑ����Ă����Ƃ����̂��A�������ł��B
�u�y�b�g�̖��O�́H�v�Ƃ�������B

�y���̑��z
UserKey��Windows�̃��[�U���ɊǗ�����Ă�݂����ł��B
�p�X���[�h�����Ȃ������ꍇ�AEncode�����̂Ƃ͕ʂ�
�A�J�E���g(Windows�̃��c)�ł͕����ł��܂���B


�y�t�H���_�z
CryptAuto
	�L�[�R���e�i��User�̌����L�[��������Ώ���ɍ�����Ⴄ
	���C���o�[�W�����ł��B

Crypt4Init
	�L�[�R���e�i��User�̌����L�[��������΍��@�����@�̃T���v��AP�ł��B
	��L��CryptAuto���Ă�ł邾���ł��B
	�L�[�����̂͂P�����Ƃ��Ηǂ���ŁB

Crypt
	�u�L�[�R���e�i��User�̌����L�[��������Ώ���ɍ�����Ⴄ�v������
	�폜�����o�[�W�����ł��B
	�����ꍇ�ɂ͖ܘ_�Í����ł��܂���B
	���C���o�[�W�������s���Ȏ��ɁB

CryptPwdOnly
	�L�[�R���e�i��������΍�邯��User�̌����L�[�͍��Ȃ��o�[�W�����ł��B
	�p�X���[�h���w�肷��ꍇ�ɂ͂���ŊԂɍ����܂��B

Innacurate
	<em>�C���`�L</em>Base64�ł��B
	�Í������̂Ƃ͊֌W����܂���B
	������Ə����Ă݂������B

�yUsage�z
	class THogeCrypt*;	// * �̂Ƃ����Unit�Ƃ��Q�Ƃ��ĉ�����

	constructor THogeCrypt*.Create;	// ����
	destructor THogeCrypt*.Destroy;	// �ς�

	function THogeCrypt*.Encrypt(	// �Í�������
		PlainText: TStream;	// [in] �Í�������������
		Password: String;	// [in] �p�X���[�h�B�󕶎���ł��B
		Encrypted: TStream	// [out]�Í�������ďo�Ă���
	): Boolean;	// ���s������False

	function THogeCrypt*.Decrypt(	// ��������
		Crypted: TStream;	// [in] �Í�������Ă����
		Password: String;	// [in] �p�X���[�h�B�󕶎�����L��B
		Decrypted: TStream	// [out]��������ďo�Ă���
	): Boolean;	// ���s������False

	�Í������ꂽ���m�̓o�C�i����ɂȂ�܂��B

�y��ԑ�؂Ȃ��Ɓz
���ۏ؁B�������̑����ł������R�ɁB

This program is free software, and distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

-----------------------
2002 Twiddle
