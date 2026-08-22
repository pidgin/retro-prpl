; NSIS Script For retro-prpl
; Author Gary Kramlich
; Based on the Guifications installer by Daniel A. Atallah
; Based on the Pidgin installer by Herman Bloggs and the Pidgin-Encryption installer by Bill Tompkins
; Uses NSIS v2.0

;--------------------------------
;Include Modern UI
  !include "MUI.nsh"

!include "FileFunc.nsh"
!insertmacro GetParameters
!insertmacro GetOptions

;--------------------------------
;General
  Name "Retro PRPL ${VERSION}"

  ;Do A CRC Check
  CRCCheck On

  ;Output File Name
  OutFile "${BUILD_ROOT}\retro-prpl-${VERSION}.exe"

  ;The Default Installation Directory
  InstallDir "$PROGRAMFILES\pidgin"
  InstallDirRegKey HKLM SOFTWARE\pidgin ""

  ShowInstDetails show
  ShowUnInstDetails show
  SetCompressor /SOLID lzma

;Reserve files used in .onInit for faster start-up
!insertmacro MUI_RESERVEFILE_LANGDLL

  !define RETRO_PRPL_UNINST_EXE     "retro-prpl-uninst.exe"
  !define RETRO_PRPL_UNINSTALL_LNK  "Retro PRPL Uninstall.lnk"

;--------------------------------
; Registry keys:
  !define RETRO_PRPL_REG_KEY        "SOFTWARE\retro-prpl"
  !define RETRO_PRPL_UNINSTALL_KEY  "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\retro-prpl"

;-------------------------------
; Pidgin Plugin installer helper stuff
  !addincludedir "${SOURCE_DIR}"
  !include "pidgin-plugin.nsh"

;--------------------------------
; Modern UI Configuration
  !define MUI_ICON install.ico
  !define MUI_UNICON install.ico
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "header.bmp"
  !define MUI_ABORTWARNING

  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
  !define MUI_LANGDLL_REGISTRY_KEY ${RETRO_PRPL_REG_KEY}
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
; Pages
  ;Welcome Page
  !define MUI_WELCOMEPAGE_TITLE $(WELCOME_TITLE)
  !define MUI_WELCOMEPAGE_TEXT $(WELCOME_TEXT)
  !insertmacro MUI_PAGE_WELCOME

  ;License Page
  !define MUI_LICENSEPAGE_RADIOBUTTONS
  !insertmacro MUI_PAGE_LICENSE  "${SOURCE_ROOT}\COPYING"

  ;Directory Page
  !define MUI_DIRECTORYPAGE_TEXT_TOP $(DIR_SUBTITLE)
  !define MUI_DIRECTORYPAGE_TEXT_DESTINATION $(DIR_INNERTEXT)
  !insertmacro MUI_PAGE_DIRECTORY

  ;Installation Page
  !insertmacro MUI_PAGE_INSTFILES

  ;Finish Page
  !define MUI_FINISHPAGE_TITLE $(FINISH_TITLE)
  !define MUI_FINISHPAGE_TEXT $(FINISH_TEXT)
  !insertmacro MUI_PAGE_FINISH


;--------------------------------
; Languages
  !insertmacro MUI_LANGUAGE "English"

  ;Translations
  !include "translations\english.nsh"

; Uninstall the previous version if it exists
Section -SecUninstallOldPlugin
  ; Check install rights..
  Call CheckUserInstallRights
  Pop $R0

  StrCmp $R0 "HKLM" rights_hklm
  StrCmp $R0 "HKCU" rights_hkcu done

  rights_hkcu:
    ReadRegStr $R1 HKCU "${RETRO_PRPL_REG_KEY}" ""
    ReadRegStr $R2 HKCU "${RETRO_PRPL_REG_KEY}" "Version"
    ReadRegStr $R3 HKCU "${RETRO_PRPL_UNINSTALL_KEY}" "UninstallString"
    Goto try_uninstall

  rights_hklm:
    ReadRegStr $R1 HKLM "${RETRO_PRPL_REG_KEY}" ""
    ReadRegStr $R2 HKLM "${RETRO_PRPL_REG_KEY}" "Version"
    ReadRegStr $R3 HKLM "${RETRO_PRPL_UNINSTALL_KEY}" "UninstallString"

  ; If previous version exists .. remove
  try_uninstall:
    StrCmp $R1 "" done
      StrCmp $R2 "" uninstall_problem
        IfFileExists $R3 0 uninstall_problem
          ; Have uninstall string.. go ahead and uninstall.
          SetOverwrite on
          ; Need to copy uninstaller outside of the install dir
          ClearErrors
          CopyFiles /SILENT $R3 "$TEMP\${RETRO_PRPL_UNINST_EXE}"
          SetOverwrite off
          IfErrors uninstall_problem
            ; Ready to uninstall..
            ClearErrors
            ExecWait '"$TEMP\${RETRO_PRPL_UNINST_EXE}" /S _?=$R1'
            IfErrors exec_error
              Delete "$TEMP\${RETRO_PRPL_UNINST_EXE}"
              Goto done

            exec_error:
              Delete "$TEMP\${RETRO_PRPL_UNINST_EXE}"
              Goto uninstall_problem

        uninstall_problem:
          ; Just delete the plugin and uninstaller, and remove Registry key
          MessageBox MB_YESNO $(RETRO_PRPL_PROMPT_WIPEOUT) IDYES do_wipeout IDNO cancel_install
        cancel_install:
          Quit

        do_wipeout:
          StrCmp $R0 "HKLM" del_lm_reg del_cu_reg
          del_cu_reg:
            DeleteRegKey HKCU ${RETRO_PRPL_REG_KEY}
            Goto uninstall_prob_cont
          del_lm_reg:
            DeleteRegKey HKLM ${RETRO_PRPL_REG_KEY}

        uninstall_prob_cont:
          ; pixmaps
          Delete "$R1\pixmaps\pidgin\emblems\16\msn-bot.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\msn-external.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\msn-mobile.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\msn-secure.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\msn-yahoo.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\mxit-bot.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\mxit-external.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\mxit-not-authorized.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-admin.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-birthday.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-bot.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-hiptop.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-not-authorized.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\oscar-secure.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\qq-member.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\qq-mobile.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\qq-not-authorized.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\qq-video.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\yahoo-external.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\yahoo-game.png"
          Delete "$R1\pixmaps\pidgin\emblems\16\yahoo-not-authorized.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\gadu-gadu.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\msn.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\mxit.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\myspace.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\napster.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\novell.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\qq.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\toc-aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\toc-icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\16\yahoo.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\gadu-gadu.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\msn.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\mxit.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\myspace.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\napster.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\novell.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\qq.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\toc-aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\toc-icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\22\yahoo.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\gadu-gadu.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\msn.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\mxit.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\myspace.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\napster.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\novell.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\qq.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\toc-aim.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\toc-icq.png"
          Delete "$R1\pixmaps\pidgin\protocols\48\yahoo.png"

          ; plugins
          Delete "$R1\plugins\libaim.dll"
          Delete "$R1\plugins\libgg.dll"
          Delete "$R1\plugins\libicq.dll"
          Delete "$R1\plugins\libmsn.dll"
          Delete "$R1\plugins\libmxit.dll"
          Delete "$R1\plugins\libmyspace.dll"
          Delete "$R1\plugins\libnapster.dll"
          Delete "$R1\plugins\libnovell.dll"
          Delete "$R1\plugins\libqq.dll"
          Delete "$R1\plugins\libtoc.dll"
          Delete "$R1\plugins\libyahoo.dll"
          Delete "$R1\plugins\libyahoojp.dll"

          Delete "$R3"

  done:
SectionEnd

Section "Install"
  Call CheckUserInstallRights
  Pop $R0

  StrCmp $R0 "NONE" instrights_none
  StrCmp $R0 "HKLM" instrights_hklm instrights_hkcu

  instrights_hklm:
    ; Write the version registry keys:
    WriteRegStr HKLM ${RETRO_PRPL_REG_KEY} "" "$INSTDIR"
    WriteRegStr HKLM ${RETRO_PRPL_REG_KEY} "Version" "${VERSION}"

    ; Write the uninstall keys for Windows
    WriteRegStr HKLM ${RETRO_PRPL_UNINSTALL_KEY} "DisplayName" "$(RETRO_PRPL_UNINSTALL_DESC)"
    WriteRegStr HKLM ${RETRO_PRPL_UNINSTALL_KEY} "UninstallString" "$INSTDIR\${RETRO_PRPL_UNINST_EXE}"
    SetShellVarContext "all"
    Goto install_files

  instrights_hkcu:
    ; Write the version registry keys:
    WriteRegStr HKCU ${RETRO_PRPL_REG_KEY} "" "$INSTDIR"
    WriteRegStr HKCU ${RETRO_PRPL_REG_KEY} "Version" "${RETRO_PRPL_VERSION}"

    ; Write the uninstall keys for Windows
    WriteRegStr HKCU ${RETRO_PRPL_UNINSTALL_KEY} "DisplayName" "$(RETRO_PRPL_UNINSTALL_DESC)"
    WriteRegStr HKCU ${RETRO_PRPL_UNINSTALL_KEY} "UninstallString" "$INSTDIR\${RETRO_PRPL_UNINST_EXE}"
    Goto install_files

  instrights_none:
    ; No registry keys for us...

  install_files:
    ; plugins
    SetOutPath "$INSTDIR\plugins"
    SetCompress Auto
    SetOverwrite on
    File "${BUILD_ROOT}\gg\*.dll"
    File "${BUILD_ROOT}\msn\*.dll"
    File "${BUILD_ROOT}\mxit\*.dll"
    File "${BUILD_ROOT}\myspace\*.dll"
    File "${BUILD_ROOT}\napster\*.dll"
    File "${BUILD_ROOT}\novell\*.dll"
    File "${BUILD_ROOT}\oscar\*.dll"
    File "${BUILD_ROOT}\qq\*.dll"
    File "${BUILD_ROOT}\toc\*.dll"
    File "${BUILD_ROOT}\yahoo\*.dll"

    ; pixmaps
    SetOutPath "$INSTDIR\pixmaps\pidgin\emblems\16"
    File "${SOURCE_ROOT}\msn\pixmaps\emblems\16\*.png"
    File "${SOURCE_ROOT}\mxit\pixmaps\emblems\16\*.png"
    File "${SOURCE_ROOT}\oscar\pixmaps\emblems\16\*.png"
    File "${SOURCE_ROOT}\qq\pixmaps\emblems\16\*.png"
    File "${SOURCE_ROOT}\yahoo\pixmaps\emblems\16\*.png"

    SetOutPath "$INSTDIR\pixmaps\pidgin\protocols\16"
    File "${SOURCE_ROOT}\gg\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\msn\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\mxit\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\myspace\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\napster\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\novell\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\oscar\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\qq\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\toc\pixmaps\protocols\16\*.png"
    File "${SOURCE_ROOT}\yahoo\pixmaps\protocols\16\*.png"

    SetOutPath "$INSTDIR\pixmaps\pidgin\protocols\22"
    File "${SOURCE_ROOT}\gg\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\msn\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\mxit\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\myspace\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\napster\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\novell\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\oscar\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\qq\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\toc\pixmaps\protocols\22\*.png"
    File "${SOURCE_ROOT}\yahoo\pixmaps\protocols\22\*.png"

    SetOutPath "$INSTDIR\pixmaps\pidgin\protocols\48"
    File "${SOURCE_ROOT}\gg\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\msn\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\mxit\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\myspace\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\napster\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\novell\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\oscar\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\qq\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\toc\pixmaps\protocols\48\*.png"
    File "${SOURCE_ROOT}\yahoo\pixmaps\protocols\48\*.png"

    ; translations - if there is a way to automate this, i can't find it
    ;!insertmacro INSTALL_GMO "bn"

    StrCmp $R0 "NONE" done
    CreateShortCut "$SMPROGRAMS\Pidgin\${RETRO_PRPL_UNINSTALL_LNK}" "$INSTDIR\${RETRO_PRPL_UNINST_EXE}"
    WriteUninstaller "$INSTDIR\${RETRO_PRPL_UNINST_EXE}"
    SetOverWrite off

  done:
SectionEnd

Section Uninstall
  Call un.CheckUserInstallRights
  Pop $R0
  StrCmp $R0 "NONE" no_rights
  StrCmp $R0 "HKCU" try_hkcu try_hklm

  try_hkcu:
    ReadRegStr $R0 HKCU "${RETRO_PRPL_REG_KEY}" ""
    StrCmp $R0 $INSTDIR 0 cant_uninstall
      ; HKCU install path matches our INSTDIR.. so uninstall
      DeleteRegKey HKCU "${RETRO_PRPL_REG_KEY}"
      DeleteRegKey HKCU "${RETRO_PRPL_UNINSTALL_KEY}"
      Goto cont_uninstall

  try_hklm:
    ReadRegStr $R0 HKLM "${RETRO_PRPL_REG_KEY}" ""
    StrCmp $R0 $INSTDIR 0 try_hkcu
      ; HKLM install path matches our INSTDIR.. so uninstall
      DeleteRegKey HKLM "${RETRO_PRPL_REG_KEY}"
      DeleteRegKey HKLM "${RETRO_PRPL_UNINSTALL_KEY}"
      ; Sets start menu and desktop scope to all users..
      SetShellVarContext "all"

  cont_uninstall:
    ; pixmaps
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\msn-bot.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\msn-external.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\msn-mobile.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\msn-secure.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\msn-yahoo.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\mxit-bot.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\mxit-external.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\mxit-not-authorized.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-admin.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-birthday.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-bot.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-hiptop.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-not-authorized.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\oscar-secure.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\qq-member.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\qq-mobile.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\qq-not-authorized.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\qq-video.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\yahoo-external.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\yahoo-game.png"
    Delete "$INSTDIR\pixmaps\pidgin\emblems\16\yahoo-not-authorized.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\gadu-gadu.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\msn.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\mxit.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\myspace.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\napster.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\novell.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\qq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\toc-aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\toc-icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\16\yahoo.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\gadu-gadu.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\msn.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\mxit.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\myspace.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\napster.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\novell.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\qq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\toc-aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\toc-icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\22\yahoo.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\gadu-gadu.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\msn.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\mxit.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\myspace.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\napster.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\novell.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\qq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\toc-aim.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\toc-icq.png"
    Delete "$INSTDIR\pixmaps\pidgin\protocols\48\yahoo.png"

    ; plugin
    Delete "$INSTDIR\plugins\libaim.dll"
    Delete "$INSTDIR\plugins\libgg.dll"
    Delete "$INSTDIR\plugins\libicq.dll"
    Delete "$INSTDIR\plugins\libmsn.dll"
    Delete "$INSTDIR\plugins\libmxit.dll"
    Delete "$INSTDIR\plugins\libmyspace.dll"
    Delete "$INSTDIR\plugins\libnapster.dll"
    Delete "$INSTDIR\plugins\libnovell.dll"
    Delete "$INSTDIR\plugins\libqq.dll"
    Delete "$INSTDIR\plugins\libtoc.dll"
    Delete "$INSTDIR\plugins\libyahoo.dll"
    Delete "$INSTDIR\plugins\libyahoojp.dll"

    ; translations
    ; loop through locale dirs and try to delete any retro-prpl translations
    ClearErrors
    FindFirst $R1 $R2 "$INSTDIR\locale\*"
    IfErrors doneFindingTranslations

    processCurrentTranslationDir:
      ;Ignore "." and ".."
      StrCmp $R2 "." readNextTranslationDir
      StrCmp $R2 ".." readNextTranslationDir
      IfFileExists "$INSTDIR\locale\$R2\LC_MESSAGES\retro-prpl.mo" +1 readNextTranslationDir
      Delete "$INSTDIR\locale\$R2\LC_MESSAGES\retro-prpl.mo"
      RMDir  "$INSTDIR\locale\$R2\LC_MESSAGES"
      RMDir  "$INSTDIR\locale\$R2"
      ClearErrors
    readNextTranslationDir:
      FindNext $R1 $R2
    IfErrors doneFindingTranslations processCurrentTranslationDir

    doneFindingTranslations:
    FindClose $R1
    RMDir  "$INSTDIR\locale"

    ; uninstaller
    Delete "$INSTDIR\${RETRO_PRPL_UNINST_EXE}"
    ; uninstaller shortcut
    Delete "$SMPROGRAMS\Pidgin\${RETRO_PRPL_UNINSTALL_LNK}"

    ; try to delete the Pidgin directories, in case it has already uninstalled
    RMDir "$INSTDIR\plugins"
    RMDir "$INSTDIR"
    RMDir "$SMPROGRAMS\Pidgin"

    Goto done

  cant_uninstall:
    MessageBox MB_OK $(un.RETRO_PRPL_UNINSTALL_ERROR_1) IDOK
    Quit

  no_rights:
    MessageBox MB_OK $(un.RETRO_PRPL_UNINSTALL_ERROR_2) IDOK
    Quit

  done:
SectionEnd

Function .onInit
  ${GetParameters} $R0
  ClearErrors
  ${GetOptions} $R0 "/L=" $R0
  IfErrors +3
  StrCpy $LANGUAGE $R0
  Goto skip_lang

  ; Select Language
    ; Display Language selection dialog
    !insertmacro MUI_LANGDLL_DISPLAY
    skip_lang:

FunctionEnd

Function un.onInit
  ; Get stored language preference
  !insertmacro MUI_UNGETLANGUAGE
FunctionEnd


; Check that the selected installation dir contains pidgin.exe
Function .onVerifyInstDir
  IfFileExists $INSTDIR\pidgin.exe +2
    Abort
FunctionEnd

Function CheckUserInstallRights
  ClearErrors
  UserInfo::GetName
  IfErrors Win9x
  Pop $0
  UserInfo::GetAccountType
  Pop $1

  StrCmp $1 "Admin" 0 +3
    StrCpy $1 "HKLM"
    Goto done
  StrCmp $1 "Power" 0 +3
    StrCpy $1 "HKLM"
    Goto done
  StrCmp $1 "User" 0 +3
    StrCpy $1 "HKCU"
    Goto done
  StrCmp $1 "Guest" 0 +3
    StrCpy $1 "NONE"
    Goto done

  ; Unknown error
  StrCpy $1 "NONE"
  Goto done

  Win9x:
    StrCpy $1 "HKLM"

  done:
  Push $1
FunctionEnd

; This is necessary because the uninstaller doesn't have access to installer functions
; (it is identical to CheckUserInstallRights)
Function un.CheckUserInstallRights
  ClearErrors
  UserInfo::GetName
  IfErrors Win9x
  Pop $0
  UserInfo::GetAccountType
  Pop $1

  StrCmp $1 "Admin" 0 +3
    StrCpy $1 "HKLM"
    Goto done
  StrCmp $1 "Power" 0 +3
    StrCpy $1 "HKLM"
    Goto done
  StrCmp $1 "User" 0 +3
    StrCpy $1 "HKCU"
    Goto done
  StrCmp $1 "Guest" 0 +3
    StrCpy $1 "NONE"
    Goto done

  ; Unknown error
  StrCpy $1 "NONE"
  Goto done

  Win9x:
    StrCpy $1 "HKLM"

  done:
  Push $1
FunctionEnd
