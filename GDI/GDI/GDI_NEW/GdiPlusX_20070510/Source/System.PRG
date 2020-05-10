IF VARTYPE(_SCREEN.System) <> "O"
	ADDPROPERTY(_SCREEN,"System",NEWOBJECT("xfcSystem",JUSTPATH(SYS(16))+"\system.vcx"))
ENDIF

IF VARTYPE(_SCREEN.Graphics) <> "O"
	ADDPROPERTY(_SCREEN,"Graphics",_SCREEN.System.Drawing.Graphics.FromHwnd(_SCREEN.HWnd))
ENDIF