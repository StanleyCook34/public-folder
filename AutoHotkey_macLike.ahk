;===  windowsショートカットをmac風にするAutoHotkeyスクリプト　=========

#InstallKeybdHook
#UseHook

; =========  使われる方へ　==========================================

; http://www.karakaram.com/mac-control 記事内のコードを参考させて頂き、
; 加えて、windowsのwinキーをMacのcommandキーに対応してみました。
; 実際にwindows用bluetoothキーボードなどをMacにつなぐとそのように認識されます。

; 何やらセミコロンだらけですが、これはAutoHotkeyのコメントアウトです。
; C言語などでは、行のコメントアウトは"//"ですが、
; AutoHotkeyでは";"を用います。ただし、行頭以外では
; 手前にスペースをひとつ以上開ける必要があります。

; このプログラムでのショートカットを無効にしたいソフトもあるでしょうから、
; disableWindowListというグループを設けました。
; このグループに登録されたプロセスは、このプログラムから除外されます。
; プロセス名はタスクマネージャーの詳細表示の「詳細」タブの「名前」になり、
; 拡張子が.exeの名前です。
; グループへの登録方法は、
; "GroupAdd disableWindowList, ahk_exe "に続けて、
; 無効にしたいプロセス名を記述してグループに登録してください。

; 例えば、chromeを無効にしたい場合は、以下のようになります。
; (例) GroupAdd disableWindowList, ahk_exe chrome.exe
; chrome.exeがプロセス名です。


; 冒頭の#UseHook は、a::a のような無限ループになるコードの暴走を未然に
; 防ぎ、ctrl+A と win+A などを両立させるためにもあります。

; Windowsのスタートアップに登録しておけば、いつでもこのプログラムが有効になります。
; Windows10のスタートアップの場所は、
; C:\Users\[ユーザー名]\AppData\Roaming\Microsoft\Windows\Start Menu
; \Programs\Startup です。
; そこにこのプログラムをコンパイルした実行ファイルのショートカットを登録してください。

; ウィルス対策ソフトのAvastを利用していると、
; AutoHotkeyのコンパイル後のexeファイル実行時にチェックが入りましたが、
; ウィルスと誤認識されることなく使えています。


;=========  以下、コード部  ===========================================



;---------　無効にしたいプロセスのグループ登録　------------------

; GroupAdd disableWindowList, ahk_exe blender.exe ; Blender(3Dソフト)
; GroupAdd disableWindowList, ahk_exe chrome.exe ; Chrome(ブラウザ)


;---------  関数  ----------------------------------------------

; 除外グループに属しているか判定する
is_disable_window()
{
  IfWinActive ahk_group disableWindowList
  {
    return 1
  }
	
  return 0
}

; 引数のreplace_keyに変換したいキーの組み合わせの文字を渡す。
send_key(replace_key)
{
  if (is_disable_window())
  {
    Send,%A_ThisHotkey% ;A_ThisHotkeyは組み込み変数
    return
  }
  Send,%replace_key%
  return
}


;--------- ショートカットの設定　--------------------------  

; ctrl + A : 先頭へ移動
^a::send_key("{Home}")

; shift + ctrl + A : 先頭へ選択移動
+^a::send_key("+{Home}")

; ctrl + E : 末尾へ移動
^e::send_key("{End}")

; shift + ctrl + E : 末尾へ選択移動 
+^e::send_key("+{End}")

; ctrl + B : 左へ移動
^b::send_key("{Left}")

; shift + ctrl + B : 左へ選択移動
+^b::send_key("+{Left}")

; ctrl + F : 右へ移動
^f::send_key("{Right}")

; shift + ctrl + F : 右へ選択移動
+^f::send_key("+{Right}")

; ctrl + P : 上へ移動
^p::send_key("{Up}")

; shift + ctrl + P : 上へ選択移動
+^p::send_key("+{Up}")

; ctrl + N : 下へ移動
^n::send_key("{Down}")

; shift + ctrl + N : 下へ選択移動
+^n::send_key("+{Down}")

; ctrl + H : Backspace
^h::send_key("{BS}")

; ctrl + D : Delete
^d::send_key("{Del}")

; ctrl + K : カーソル位置から末尾まで削除
^k::send_key("+{End}{Del}")

; ctrl + M : Enter
; ^m::send_key("{Return}")

; ctrl + U : 前の単語の先頭にカーソルを移動
^u::send_key("^{Left}")

; ctrl + I : 次の単語の先頭にカーソルを移動
^i::send_key("^{Right}")


; win + A : すべてを選択
#a::send_key("^a")

; win + C : コピー
#c::send_key("^c")

; win + V : 貼り付け
#v::send_key("^v")

; win + X : 切り取り
#x::send_key("^x")

; win + F : 検索
#f::send_key("^f")

;======================================================================
