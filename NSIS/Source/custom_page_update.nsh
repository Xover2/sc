; ========================================================
; This file was generated by NSISDialogDesigner 1.1.1.0
; http://coolsoft.altervista.org/nsisdialogdesigner
; ========================================================

; handle variables
Var hCtl_custom_page_update
Var hCtl_custom_page_update_BitmapFriss
Var hCtl_custom_page_update_BitmapFriss_hImage
Var hCtl_custom_page_update_Label1
Var hCtl_custom_page_update_Label2
Var hCtl_custom_page_update_Label3
Var hCtl_custom_page_update_LabelTelepitettVerzio
Var hCtl_custom_page_update_LabelFrissVerzio
Var hCtl_custom_page_update_TextBoxUpdatePath
Var hCtl_custom_page_update_Font1
Var hCtl_custom_page_update_Font2
Var hCtl_custom_page_update_Font3


; dialog create function
Function fnc_custom_page_update_Create
  
  ; custom font definitions
  CreateFont $hCtl_custom_page_update_Font1 "Microsoft Sans Serif" "9" "700"
  CreateFont $hCtl_custom_page_update_Font2 "Microsoft Sans Serif" "8.25" "700"
  CreateFont $hCtl_custom_page_update_Font3 "DejaVu Sans Condensed" "9" "700"
  
  ; === custom_page_update (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $hCtl_custom_page_update
  ${If} $hCtl_custom_page_update == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "Programfriss�t�s" "A friss�t�s r�szleteit az al�bbiakban olvashatja."
  
  ; === BitmapFriss (type: Bitmap) ===
  ${NSD_CreateBitmap} 0u 0u 105u 130u ""
  Pop $hCtl_custom_page_update_BitmapFriss
  File "/oname=$PLUGINSDIR\update.bmp" "PICTURES\update.bmp"
  ${NSD_SetImage} $hCtl_custom_page_update_BitmapFriss "$PLUGINSDIR\update.bmp" $hCtl_custom_page_update_BitmapFriss_hImage
  
  ; === Label1 (type: Label) ===
  ${NSD_CreateLabel} 117u 7u 164u 13u "�rz�kelt telep�t�si k�nyvt�r:"
  Pop $hCtl_custom_page_update_Label1
  SendMessage $hCtl_custom_page_update_Label1 ${WM_SETFONT} $hCtl_custom_page_update_Font1 0
  
  ; === Label2 (type: Label) ===
  ${NSD_CreateLabel} 117u 51u 105u 13u "Jelenlegi programverzi�:"
  Pop $hCtl_custom_page_update_Label2
  SendMessage $hCtl_custom_page_update_Label2 ${WM_SETFONT} $hCtl_custom_page_update_Font2 0
  
  ; === Label3 (type: Label) ===
  ${NSD_CreateLabel} 117u 70u 105u 13u "Friss�t�s ut�ni verzi�:"
  Pop $hCtl_custom_page_update_Label3
  SendMessage $hCtl_custom_page_update_Label3 ${WM_SETFONT} $hCtl_custom_page_update_Font2 0
  
  ; === LabelTelepitettVerzio (type: Label) ===
  ${NSD_CreateLabel} 226u 51u 66u 13u "$InstalledVersion"
  Pop $hCtl_custom_page_update_LabelTelepitettVerzio
  SendMessage $hCtl_custom_page_update_LabelTelepitettVerzio ${WM_SETFONT} $hCtl_custom_page_update_Font3 0
  SetCtlColors $hCtl_custom_page_update_LabelTelepitettVerzio 0x000000 0xF0F0F0
  
  ; === LabelFrissVerzio (type: Label) ===
  ${NSD_CreateLabel} 226u 70u 66u 13u "${VERSION}"
  Pop $hCtl_custom_page_update_LabelFrissVerzio
  SendMessage $hCtl_custom_page_update_LabelFrissVerzio ${WM_SETFONT} $hCtl_custom_page_update_Font3 0
  SetCtlColors $hCtl_custom_page_update_LabelFrissVerzio 0xCD5C5C 0xF0F0F0
  
  ; === TextBoxUpdatePath (type: Text) ===
  ${NSD_CreateText} 117u 23u 175u 11u "$INSTDIR"
  Pop $hCtl_custom_page_update_TextBoxUpdatePath
  SetCtlColors $hCtl_custom_page_update_TextBoxUpdatePath 0x000000 0xF0F0F0
  SendMessage $hCtl_custom_page_update_TextBoxUpdatePath ${EM_SETREADONLY} 1 0
  
FunctionEnd


; dialog show function
Function fnc_custom_page_update_Show
  ${If} $IsUpdate = 1
      ; A tov�bb gomb �tnevez�se te�ep�t�sre
      GetDlgItem $0 $HWNDPARENT 1
      SendMessage $0 ${WM_SETTEXT} 0 "STR: Telep�t�s"
      
      Call fnc_custom_page_update_Create
      nsDialogs::Show $hCtl_custom_page_update
  ${EndIf}
FunctionEnd

Function UpdatePageLeave
  ${If} $regINSTDIR == ""
    MessageBox MB_OK|MB_ICONSTOP "HIBA: A friss�t�st nem lehet telep�teni, mert a program vagy nincs feltelep�tve erre a sz�m�t�g�pre vagy hib�san lett feltelep�tve."
    Abort
  ${Else}
    Push $InstalledVersion ;telep�tett program verzi�sz�ma
    Push ${VERSION}  ;friss�t�s verzi�sz�ma
    Call CompareVersions
    Pop $R0  
    
    ${if} $R0 != 1
      MessageBox MB_OK|MB_ICONSTOP "HIBA: A friss�t�st nem lehet telep�teni, mert a telep�tett program verzi�sz�ma nagyobb mint a friss�t�s verzi�sz�ma."
      Abort
    ${Else}
      ${if} $InstalledVersion == ${VERSION}
        MessageBox MB_YESNO|MB_ICONEXCLAMATION "A telep�tett program verzi�sz�ma �s a friss�t�s verzi�sz�ma megegyezik. $\r$\n$\r$\nBiztosan szeretn� telep�teni ezt a friss�t�st?" IDYES install
        Abort
        install:
      ${EndIf}
    ${EndIf}
  ${EndIf}
FunctionEnd