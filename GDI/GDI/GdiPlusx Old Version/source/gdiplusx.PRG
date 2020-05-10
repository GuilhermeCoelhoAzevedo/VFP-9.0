_screen.AddProperty("System",NEWOBJECT("xfcSystem",(JUSTPATH(SYS(16))+"\system.vcx")))
_screen.AddProperty("Graphics",_SCREEN.System.Drawing.Graphics.FromHwnd(_SCREEN.HWnd))