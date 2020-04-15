#include <ScreenCapture.au3>

Opt("SendKeyDelay", 50)
Opt("SendKeyDownDelay", 50)

HotKeySet("{PAUSE}", "Solve")

Global Const $cords[8][2] =  [[480,278], [624,278], _
							  [480,422], [624,422], _
							  [480,566], [624,566], _
							  [480,710], [624,710]]
Global Const $width = 106
Global Const $height = 106
Global Const $debug = false
Func Solve()
   Local $solved = 0
   $tooltip = ""
   For $i = 0 To 7 Step 1
	  $left = $cords[$i][0]
	  $top = $cords[$i][1]
	  $right = $left + $width
	  $bottom  = $top + $height
	  $checksum = PixelChecksum($left, $top, $right, $bottom)
	  If FileExists("components\" & $checksum & ".jpg") Then
		 Send("{ENTER}")
		 $solved += 1
	  ElseIf $debug Then
		 _ScreenCapture_Capture("invalid\" & $checksum & ".jpg", $left, $top, $right, $bottom)
	  EndIf
	  If $solved < 4 Then
		 Send("{RIGHT}")
	  EndIf
   Next
   If $solved = 4 Then
	  If $debug Then
		 DirRemove("invalid",1)
		 DirCreate("invalid")
	  EndIf
	  Send("{TAB}")
   EndIf
EndFunc

While 1
   Sleep(1000)
WEnd