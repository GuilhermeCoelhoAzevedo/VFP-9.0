CD G:\USUARIOS\Coelho\PWI\Exercicios\GDI
DO SYSTEM_LEAN

LOCAL BOCA as Number
LOCAL OLHOESQ as Number
LOCAL OLHODIR AS Number
LOCAL loIMAGE AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loBRUSH AS XFCBRUSH
LOCAL loFONT AS XFCFONT
LOCAL loPEN AS XFCPEN

IF TYPE('_screen.img1') <> 'O'
	_SCREEN.AddObject('IMG1','IMAGE')
	_SCREEN.IMG1.Visible = .t.
	_SCREEN.IMG1.Height = 700
	_SCREEN.IMG1.Width = 500
ENDIF

DO SYSTEM

* Criando pincel						Cor do pincel
loBRUSH_SALMON	= _SCREEN.SYSTEM.Drawing.Brushes.SALMON
loBRUSH_White	= _SCREEN.SYSTEM.DRAWING.BRUSHES.WHITE
loBRUSH_Black	= _SCREEN.SYSTEM.DRAWING.BRUSHES.BLACK
loBRUSH_Green	= _SCREEN.SYSTEM.DRAWING.BRUSHES.GREEN

* Escolhendo fonte						 Nome fonte, Tamanho da Fonte
loFONT_CS20 = _SCREEN.SYSTEM.Drawing.Font.New('Comic Sans MS',20)
loFONT_AR15 = _SCREEN.SYSTEM.Drawing.Font.New('Arial',15)

* CRIANDO ESPA�O PARA DESENHO
loIMAGE = _SCREEN.SYStem.Drawing.Bitmap.New(700,500)
loGFX = _SCREEN.SYStem.Drawing.Graphics.FromImage(loIMAGE)

*!*	* CRIANDO CANETA
loPEN_BLACK = _SCREEN.SYSTEM.Drawing.Pen.New(_SCREEN.SYStem.Drawing.Brushes.Black)
loPEN_RED = _SCREEN.SYSTEM.Drawing.Pen.New(_SCREEN.SYStem.Drawing.Brushes.Red)

* COLORINDO
loGFX.Clear(_SCREEN.SYSTEM.Drawing.Color.White)

*Desenhando
loGFX.Fillrectangle(loBRUSH_Black, 0, 400, 700, 100)

OLHOESQ = 25
OLHODIR = 40
BOCA = 14

FOR X = 0 TO 700 STEP 10
	loGFX.fillellipse(loBRUSH_SALMON, X, 350, 50, 50)
	loGFX.Fillellipse(loBRUSH_green, OLHOESQ, 363, 5, 5)
	loGFX.Fillellipse(loBRUSH_green, OLHODIR, 363, 5, 5)
	loGFX.Drawarc(loPEN_RED, BOCA, 345, 40, 40, 60, 60) 		
	_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureval()
	loGFX.FillEllipse(loBRUSH_White, X, 350, 50, 50)
	OLHOESQ = OLHOESQ + 10
	OLHODIR = OLHODIR + 10
	BOCA = BOCA + 10
ENDFOR

*!*	LOCAL loTIMER AS Timer
*!*	loTIMER = CREATEOBJECT('TIMER')
*!*	loTIMER.Interval = 100	
*!*	loTIMER.
*!*	loGFX.Fillrectangle(loBRUSH_White, 350, 300, 30, 100)
*!*	loGFX.Fillrectangle(loBRUSH_Black, 350, 250, 30, 100)


