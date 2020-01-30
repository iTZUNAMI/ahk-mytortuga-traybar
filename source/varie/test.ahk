#Persistent  ; Keep the script running until the user exits it.

Menu, tray, NoStandard
;aggiungo esci per connessione non presente
Menu, Tray, Add,Connessione Internet non attiva.. [x],Quit

;menu opzioni e versione sempre attive
Menu, mOpzioni, Add, Avvio Automatico, AvvioAutomaticoToogle
Menu, mOpzioni, Add, Controlla Aggiornamenti, ContrWeb
Menu, mOpzioni, Add, Suggerisci Sito Web, SuggWeb
Menu, mOpzioni, Add, About, About..
Menu, Tray, Add, Opzioni, :mOpzioni
AutoStart:="on"


;var globali
Lista := {}
cnt:=0
NomeProgramma := "MyTorTuGa"


;controllo che sia connesso altrimenti non scarica la lista
Loop
{
Stato := Connected()

if (Stato = "1") {
 ;rimuovo il pulsante
 Menu, Tray, Delete, Connessione Internet non attiva.. [x]
 break 
}

}

;download lista aggiornata
Menu, Tray, Add,Downloading lista aggiornata.. [x],Quit
;aggiungo esci per download fallito
Loop
{
 
 
IfNotExist,  %A_Temp%\%NomeProgramma%_config.json
  {
  UrlDownloadToFile, https://dl.dropboxusercontent.com/u/2750107/MyTorTuGa/MyTorTuGa_config.json,  %A_Temp%\%NomeProgramma%_config.json
  }

    IfExist,%A_Temp%\%NomeProgramma%_config.json
      {
        fallito := false
        FileRead, var, %A_Temp%\%NomeProgramma%_config.json
        IfInString, var, 404
        {
          ;errore 404 not found
          Menu, Tray, Add,Download fallito... [x],Quit
          fallito := true
        }
        else
        {
          ;file scaricato correttamente
          if (fallito=true) {
          Menu, Tray, Delete, Download fallito... [x]
          }
          ;rimuovo tutti menu
          Menu, Tray, Delete, Downloading lista aggiornata.. [x]
          break
        }
        
    
      }

}


;Connessione Ok e Download lista OK

FileRead, ElencoSiti, %A_Temp%\%NomeProgramma%_config.json

;inizializza - controllo avvio e caso avvio disattivato dopo primo avvio del programma
IfExist,  %A_Temp%\%NomeProgramma%_d
{
; questo file viene creato disabilitando auto avvio
AutoStart:="off"
}
IfExist,  %A_Temp%\%NomeProgramma%_e
{
;non serve fare nulla gia tutto impostato
}
else if (AutoStart="on")
{
  ;inizializza prima volta autoavvio checked
  FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%NomeProgramma%.lnk, %A_ScriptDir% 
  FileAppend, Imposta Start, %A_Temp%\%NomeProgramma%_e ; avvio enabled config file
}

IfExist, %A_Startup%\%NomeProgramma%.lnk
{
Menu, mOpzioni, ToggleCheck, Avvio Automatico ;checked
}


;lettura json e creazione menu submenu e link
Loop
{
	
	tbmenu_titolo := json(ElencoSiti, "tbmenu[" . cnt . "].titolo")
    tbmenu_menu   := json(ElencoSiti, "tbmenu[" . cnt . "].menu")
    tbmenu_sep    := json(ElencoSiti, "tbmenu[" . cnt . "].sep")
    tbmenu_url    := json(ElencoSiti, "tbmenu[" . cnt . "].url")
	cnt++
	if (tbmenu_titolo="") { 
	break 
	} ;fine ciclo finiti i menu
	
	
    ;caso link singolo o menu 
    
    
    ;testo con link singolo o separatore o testo senza link
    if (tbmenu_menu="no"){
      
          ;testo senza link
          if (tbmenu_sep="si"){
            Menu, Tray, Add, %tbmenu_titolo%,TestoVuoto
            Menu, Tray, Disable, %tbmenu_titolo%
          }
          ;testo con link singolo
          if (tbmenu_sep="no"){
            Lista.Insert(tbmenu_titolo, {Indirizzo:tbmenu_url})
            Menu, Tray, Add, %tbmenu_titolo%, ToURL
          }
          ;linea che separa
          if (tbmenu_sep="vuoto"){
            Menu, Tray, Add          
          }
    }  
    ;altrimenti menu con link
    else {
    ;aggiungo tutti i sottomenu (al contrario)
    SubMenu(tbmenu_titolo)
    ;aggiungo il menu principale collegandolo a tutti i sottomenu	
    Menu, Tray, Add, %tbmenu_titolo%, :%tbmenu_titolo%

    }

	;esco nel caso si impalli qualcosa
	 if (cnt > 100) {
	 break 
	 }
}


;aggiunto pulsanti Chiusura
Menu, tray, add 
Menu, Tray, Add,Chiudi,Quit

SubMenu(tbmenu_titolo)
{
    global ElencoSiti
    global Lista
	cnt=0
	Loop
	{
        
		NomeMenu  := json(ElencoSiti, "" . tbmenu_titolo . "[" . cnt . "].nome")
		NomeURL   := json(ElencoSiti, "" . tbmenu_titolo . "[" . cnt . "].url")
        Sep       := json(ElencoSiti, "" . tbmenu_titolo . "[" . cnt . "].sep")
        SottoMenu := json(ElencoSiti, "" . tbmenu_titolo . "[" . cnt . "].smenu")
        cnt++
        
       ; SottoMenu:="no"
        
		if (NomeMenu="") {
		    break 	
		} ;fine elenco

       ;sotto menu del sotto menu 
        if (SottoMenu="si"){

            SubMenu2(NomeMenu)
            Menu, %tbmenu_titolo%, Add, %NomeMenu%, :%NomeMenu%
            
        }
        ; normale
         if (SottoMenu="no"){
           
            if (Sep="vuoto"){
               Menu, %tbmenu_titolo%, Add
            }
            if (Sep="si"){
                Menu, %tbmenu_titolo%, Add, %NomeMenu%,TestoVuoto
                Menu, %tbmenu_titolo%, Disable, %NomeMenu%
            }
            if (Sep="no"){
            Lista.Insert(NomeMenu, {Indirizzo:NomeURL})
            Menu, %tbmenu_titolo%, Add, %NomeMenu%, ToURL
            }
        }
        
        
        
        
            ;esco nel caso si impalli qualcosa
             if (cnt > 100) {
             break 
             }
         
         
	}



}
return


SubMenu2(NomeMenu){
    global ElencoSiti
    global Lista
    cnt2:=0
    Loop{
            NomeMenu2  := json(ElencoSiti, "" . NomeMenu . "[" . cnt2 . "].nome")
            NomeURL2   := json(ElencoSiti, "" . NomeMenu . "[" . cnt2 . "].url")
            Sep2       := json(ElencoSiti, "" . NomeMenu . "[" . cnt2 . "].sep")
            cnt2++
            
            if (NomeMenu2="") {
		    break 	
            } ;fine elenco
            
            if (Sep2="vuoto"){
              Menu, %NomeMenu%, Add
            }
            if (Sep2="si"){
                Menu, %NomeMenu%, Add, %NomeMenu%,TestoVuoto
                Menu, %NomeMenu%, Disable, %NomeMenu%
            }
            if (Sep2="no"){
            
            Lista.Insert(NomeMenu2, {Indirizzo:NomeURL2})
            Menu, %NomeMenu%, Add, %NomeMenu2%, ToURL
            
            
          }
        
            
            
             ;esco nel caso si impalli qualcosa
             if (cnt2 > 100) {
             break 
             }
            }
}
return

;url pagina aggiornamento
ContrWeb:
{
ToURLD("http://www.ciao.it")
}
return

;url pagina richieste nuove aggiunte
SuggWeb:
{
  ToURLD("http://www.google.it")
}
return


ToURL:
{
global Lista

IndWeb := Lista[A_ThisMenuItem].Indirizzo
;MsgBox You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
RegRead,defBrowser,HKCR,.html                               ; Get default browswer
RegRead,defBrowser,HKCR,%defBrowser%\shell\open\command     ; Get path to default browser + options
StringReplace, defBrowser, defBrowser, "`%1", %IndWeb%
Run, % defBrowser  
}
return



ToURLD(URL)
{
IndWeb := URL
RegRead,defBrowser,HKCR,.html                               ; Get default browswer
RegRead,defBrowser,HKCR,%defBrowser%\shell\open\command     ; Get path to default browser + options
StringReplace, defBrowser, defBrowser, "`%1", %IndWeb%
Run, % defBrowser  
}
return


About..:
{
global NomeProgramma
msgbox,
(LTrim
	%NomeProgramma% v1.1 creato da LoKi
	
    Questa Tray Bar vi permette un rapido accesso ai miglior siti italiani.
    Tutti i siti web vengono aggiornati in automatico.
    Non dovrete più preoccuparvi di blocchi/censure/cambi di dominio su questi siti web.
)
}
return


AvvioAutomaticoToogle:
global NomeProgramma
Menu, mOpzioni, ToggleCheck, Avvio Automatico
;default attivo la prima volta

IfExist, %A_Startup%\%NomeProgramma%.lnk
{
  ;msgbox esiste
  ;lo cancella se toogle
  Filedelete, %A_Startup%\%NomeProgramma%.lnk
  ; msgbox eliminato
  FileAppend, Imposta Start, %A_Temp%\%NomeProgramma%_d
  
   
   return
}  
IfNotExist, %A_Startup%\%NomeProgramma%.lnk 
{
;msgbox non esiste
FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%NomeProgramma%.lnk, %A_ScriptDir% 
;msgbox riaggiunto
FileAppend, Imposta Start, %A_Temp%\%NomeProgramma%_e
Filedelete, %A_Temp%\%NomeProgramma%_d
return
}

return


Connected(fl = 0x40) {
	Return, DllCall("Wininet.dll\InternetGetConnectedState", "UInt *", fl, "UInt", 0)
}
return



TestoVuoto:
return
 
RegistroAvvio:
return



Quit:
FileDelete, %A_Temp%\%NomeProgramma%_config.json
ExitApp
return




/*
	Function: JSON

	Parameters:
		js - source
		s - path to element
		v - (optional) value to overwrite

	Returns:
		Value of element (prior to change).

	License:
		- Version 2.0 <http://www.autohotkey.net/~polyethene/#json>
		- Dedicated to the public domain (CC0 1.0) <http://creativecommons.org/publicdomain/zero/1.0/>
*/
json(ByRef js, s, v = "") {
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)((?:\[\d+\])*)", q)
		Loop {
			If (!p := RegExMatch(j, "(?<!\\)(""|')([^\1]+?)(?<!\\)(?-1)\s*:\s*((\{(?:[^{}]++|(?-1))*\})|(\[(?:[^[\]]++|(?-1))*\])|"
				. "(?<!\\)(""|')[^\7]*?(?<!\\)(?-1)|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
				Return
			Else If (x2 == q2 or q2 == "*") {
				j = %x3%
				z += p + StrLen(x2) - 2
				If (q3 != "" and InStr(j, "[") == 1) {
					StringTrimRight, q3, q3, 1
					Loop, Parse, q3, ], [
					{
						z += 1 + RegExMatch(SubStr(j, 2, -1), "^(?:\s*((\[(?:[^[\]]++|(?-1))*\])|(\{(?:[^{\}]++|(?-1))*\})|[^,]*?)\s*(?:,|$)){" . SubStr(A_LoopField, 1) + 1 . "}", x)
						j = %x1%
					}
				}
				Break
			}
			Else p += StrLen(x)
		}
	}
	If v !=
	{
		vs = "
		If (RegExMatch(v, "^\s*(?:""|')*\s*([+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:""|')*\s*$", vx)
			and (vx1 + 0 or vx1 == 0 or vx1 == "true" or vx1 == "false" or vx1 == "null" or vx1 == "nul"))
			vs := "", v := vx1
		StringReplace, v, v, ", \", All
		js := SubStr(js, 1, z := RegExMatch(js, ":\s*", zx, z) + StrLen(zx) - 1) . vs . v . vs . SubStr(js, z + StrLen(x3) + 1)
	}
	Return, j == "false" ? 0 : j == "true" ? 1 : j == "null" or j == "nul"
		? "" : SubStr(j, 1, 1) == """" ? SubStr(j, 2, -1) : j
}

















