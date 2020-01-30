#Persistent  ; Keep the script running until the user exits it.
#SingleInstance ignore

NomeProgramma := "myTRG"
Menu, Tray, NoStandard
Menu, Tray, Tip, %NomeProgramma%

process=myTRG.exe 
Process, Exist, %process%
if	pid :=	ErrorLevel
{
	Loop 
	{
		WinClose, ahk_pid %pid%, , 5	; will wait 5 sec for window to close
		if	ErrorLevel	; if it doesn't close
			Process, Close, %pid%	; force it 
		Process, Exist, %process%
	}	Until	!pid :=	ErrorLevel
}


TrayTip, Aggiornamento myTRG, attendere....`n, 30, 17

Sleep, 3000 
ExitApp