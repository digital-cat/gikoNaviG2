@echo off
rem このバッチファイルを動かすには nkf および pas2dox が必要です。
rem nkf: http://www.vector.co.jp/soft/dos/util/se295362.html
rem pas2dox: http://pas2dox.sourceforge.net/

rem pas2dox が Shift_JIS に毒されないように EUC-JP に変換
nkf --euc<%1>_tmp_
rem pas2dox にかける
pas2dox _tmp_
rem 後始末
del _tmp_
