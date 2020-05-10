IF TYPE('_screen.imgO') <> 'O'
	_SCREEN.AddObject('imgO','IMAGE')
	_SCREEN.imgO.Visible = .T.
	_SCREEN.imgO.Left   = 480
	_SCREEN.imgO.Height = 264
	_SCREEN.imgO.Width  = 312
ENDIF

IF TYPE('_screen.img15') <> 'O'
	FOR ADDIMG=0 TO 15
		objname = 'img'+ALLTRIM(STR(ADDIMG))
		_SCREEN.AddObject(objname,'IMAGE')
		objprop = "_SCREEN."+objname+".Visible"
		&objprop = .T.
		objprop = "_SCREEN."+objname+".Height"
		&objprop = 66
		objprop = "_SCREEN."+objname+".Width"
		&objprop = 78
		objprop = "_SCREEN."+objname+".Left"
		&objprop = MOD(ADDIMG,4)*78
		objprop = "_SCREEN."+objname+".Top"
		&objprop = INT(ADDIMG/4)*66
	ENDFOR
ENDIF

LOCAL lnIMGW, lnIMGH, lnCONT AS Integer
STORE 0 TO lnIMGW, lnIMGH

* LIMPA TODOS OS PICTURES DAS IMAGENS
FOR EACH loIMG IN _SCREEN.Controls
	IF UPPER(loIMG.CLASS) = 'IMAGE'
		loIMG.PICTURE = ''
	ENDIF
ENDFOR

CLEAR RESOURCES

IF FILE('C:\GDI\SYSTEM.APP')
	DO C:\GDI\SYSTEM
ELSE
	DO LOCFILE('SYSTEM.APP')
ENDIF

* CRIA OBJETOS PARA TRATAMENTO DE IMAGEM
LOCAL loGDICLASS, loGDI AS Object
LOCAL loIMAGEM AS XFCBITMAP
LOCAL loGFX AS XFCGRAPHICS
LOCAL lcTEMPFILE, lcFULLPATH, lcIMAGEM AS String

lcTEMPFILE = GETENV("TEMP") + '\'
loGDICLASS = _SCREEN.SYSTEM	
lcFULLPATH = GETPICT()

IF EMPTY(lcFULLPATH)
	RETURN
ENDIF

_SCREEN.imgO.Picture = lcTEMPFILE + 'PRINCIPAL.JPG'

loGDI = loGDICLASS.Drawing.Bitmap.New(lcFULLPATH)
loIMAGEM = loGDICLASS.Drawing.Bitmap.New(312, 264, loGDICLASS.Drawing.Imaging.PixelFormat.Format32bppARGB)
loIMAGEM.SetResolution(loGDI.HorizontalResolution, loGDI.VerticalResolution)
loGFX = loGDICLASS.Drawing.Graphics.FromImage(loIMAGEM)
loGFX.SmoothingMode = loGDICLASS.Drawing.Drawing2D.SmoothingMode.HighQuality
loGFX.InterpolationMode = loGDICLASS.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic

* CRIA IMAGEM PRINCIPAL
loGFX.DrawImage(loGDI, 0, 0, 312, 264)
loIMAGEM.Save(lcTEMPFILE + 'PRINCIPAL.JPG', loGDICLASS.Drawing.Imaging.ImageFormat.JPEG)

loGDI = loGDICLASS.Drawing.Bitmap.New(lcTEMPFILE + 'PRINCIPAL.JPG')

lnIMGW 		= 78
lnIMGH		= 66

* DEFINE IMAGEM FINAL
loIMAGEM = loGDICLASS.Drawing.Bitmap.New(lnIMGW, lnIMGH, loGDICLASS.Drawing.Imaging.PixelFormat.Format32bppARGB)
loIMAGEM.SetResolution(loGDI.HorizontalResolution, loGDI.VerticalResolution)

FOR lnCONT = 0 TO 15
	loGFX = loGDICLASS.Drawing.Graphics.FromImage(loIMAGEM)
	loGFX.SmoothingMode = loGDICLASS.Drawing.Drawing2D.SmoothingMode.HighQuality
	loGFX.InterpolationMode = loGDICLASS.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
	loGFX.DrawImage(loGDI, MOD(lnCont, 4)*lnIMGW, INT(lnCont/4)*lnIMGH, lnIMGW, lnIMGH)
	loIMAGEM.Save(lcTEMPFILE + ALLTRIM(STR(lnCONT))+'.JPG', loGDICLASS.Drawing.Imaging.ImageFormat.JPEG)
ENDFOR

FOR EACH loIMG IN _SCREEN.Objects
	IF loIMG.NAME == 'imgO'
		LOOP
	ENDIF
	IF UPPER(loIMG.CLASS) <> 'IMAGE'
		LOOP
	ENDIF
	IF RIGHT(loIMG.NAME,1) = '16'
		LOOP
	ENDIF
		loIMG.PICTURE = lcTEMPFILE + ALLTRIM(RIGHT(loIMG.NAME,1)) + '.JPG'
ENDFOR

_SCREEN.imgO.Picture = lcFULLPATH