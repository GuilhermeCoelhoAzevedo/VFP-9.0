CD C:\GDI
DO SYSTEM_LEAN

LOCAL loIMAGE AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loBRUSH AS XFCBRUSH
LOCAL loFONT AS XFCFONT
LOCAL loPEN AS XFCPEN	

IF TYPE('_screen.img1') <> 'O'
	_SCREEN.AddObject('IMG1','IMAGE')
	_SCREEN.IMG1.Visible = .t.
	_SCREEN.IMG1.Height = 800
	_SCREEN.IMG1.Width = 800
ENDIF

DO SYSTEM

* Criando pincel						Cor do pincel
loBRUSH_Black	= _SCREEN.SYSTEM.DRAWING.BRUSHES.BLACK
loBRUSH_Brown	= _SCREEN.SYSTEM.DRAWING.BRUSHES.BROWN

* Escolhendo fonte						 Nome fonte, Tamanho da Fonte
loFONT_CS20 = _SCREEN.SYSTEM.Drawing.Font.New('Comic Sans MS',20)
loFONT_AR15 = _SCREEN.SYSTEM.Drawing.Font.New('Arial',15)

* CRIANDO ESPAÇO PARA DESENHO
loIMAGE = _SCREEN.SYStem.Drawing.Bitmap.New(800,800)
loGFX = _SCREEN.SYStem.Drawing.Graphics.FromImage(loIMAGE)

*!*	* CRIANDO CANETA
loPEN = _SCREEN.SYSTEM.Drawing.Pen.New(_SCREEN.SYStem.Drawing.Brushes.black)

* COLORINDO
loGFX.Clear(_SCREEN.SYSTEM.Drawing.Color.DARKORANGE)

*Colorindo os campos
*Ambos os controles de repetição estão interligados identificando a linha e a coluna a serrem
*modificadas.
FOR X = 0 TO 800 STEP 200 
	FOR Y = 100 TO 800 STEP 200
		loGFX.Fillrectangle(loBRUSH_Brown, X, Y, 100, 100)
		loGFX.Fillrectangle(loBRUSH_Brown, Y, X, 100, 100)
	ENDFOR
ENDFOR

*Criando as linhas(CONTORNO)
FOR X = 100 TO 800 STEP 100
	loGFX.Drawrectangle(loPEN, X, 0, 1, 800)
	loGFX.DrawRectangle(loPEN, 0, X , 800, 1) 
ENDFOR

_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureval()