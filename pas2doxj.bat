@echo off
rem ���̃o�b�`�t�@�C���𓮂����ɂ� nkf ����� pas2dox ���K�v�ł��B
rem nkf: http://www.vector.co.jp/soft/dos/util/se295362.html
rem pas2dox: http://pas2dox.sourceforge.net/

rem pas2dox �� Shift_JIS �ɓł���Ȃ��悤�� EUC-JP �ɕϊ�
nkf --euc<%1>_tmp_
rem pas2dox �ɂ�����
pas2dox _tmp_
rem ��n��
del _tmp_
