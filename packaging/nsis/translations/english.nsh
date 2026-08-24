;;
;;  english.nsh
;;
;;  Default language strings for the Windows NSIS installer.
;;  Windows Code page: 1252
;;  Language Code: 1033
;;


; Overrides for default text in windows:

LangString WELCOME_TITLE ${LANG_ENGLISH} "retro-prpl v${RETRO_PRPL_VERSION} Installer"
LangString WELCOME_TEXT  ${LANG_ENGLISH} "Note: These plugins are designed for Pidgin ${PIDGIN_VERSION}, and will not install or function with versions of Pidgin having a different major version number.\r\n\r\nWhen you upgrade your version of Pidgin, you must uninstall or upgrade these plugins as well.\r\n\r\n"

LangString DIR_SUBTITLE ${LANG_ENGLISH} "Please locate the directory where Pidgin is installed"
LangString DIR_INNERTEXT ${LANG_ENGLISH} "Install in this Pidgin folder:"

LangString FINISH_TITLE ${LANG_ENGLISH} "retro-prpl v${RETRO_PRPL_VERSION} Install Complete"
LangString FINISH_TEXT ${LANG_ENGLISH} "You will need to restart Pidgin for these plugins to be loaded."

; during install uninstaller
LangString RETRO_PRPL_PROMPT_WIPEOUT ${LANG_ENGLISH} "The retro-prpl is about to be deleted from your Pidgin/plugins directory. Continue?"

; for windows uninstall
LangString RETRO_PRPL_UNINSTALL_DESC ${LANG_ENGLISH} "retro-prpl plugins (remove only)"
LangString un.RETRO_PRPL_UNINSTALL_ERROR_1 ${LANG_ENGLISH} "The uninstaller could not find registry entries for retro-prpl.$\rIt is likely that another user installed the plugins."
LangString un.RETRO_PRPL_UNINSTALL_ERROR_2 ${LANG_ENGLISH} "You do not have the permissions necessary to uninstall the plugins."

