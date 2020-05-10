CD C:\EXERCICIOS\GDI
DO SYSTEM_LEAN

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
loBRUSH_Red		= _SCREEN.SYSTEM.Drawing.Brushes.Red
loBRUSH_Blue	= _SCREEN.SYSTEM.Drawing.Brushes.Blue
loBRUSH_White	= _SCREEN.SYSTEM.DRAWING.BRUSHES.WHITE
loBRUSH_Black	= _SCREEN.SYSTEM.DRAWING.BRUSHES.BLACK

* Escolhendo fonte						 Nome fonte, Tamanho da Fonte
loFONT_CS20 = _SCREEN.SYSTEM.Drawing.Font.New('Comic Sans MS',20)
loFONT_AR15 = _SCREEN.SYSTEM.Drawing.Font.New('Arial',15)

* CRIANDO ESPAÇO PARA DESENHO
loIMAGE = _SCREEN.SYStem.Drawing.Bitmap.New(700,500)
loGFX = _SCREEN.SYStem.Drawing.Graphics.FromImage(loIMAGE)

*!*	* CRIANDO CANETA
loPEN = _SCREEN.SYSTEM.Drawing.Pen.New(_SCREEN.SYStem.Drawing.Brushes.red)

* COLORINDO
loGFX.Clear(_SCREEN.SYSTEM.Drawing.Color.RED)

*DESENHANDO
loGFX.Fillrectangle(loBRUSH_WHITE, 240, 0, 40, 500)
loGFX.Fillrectangle(loBRUSH_WHITE, 0, 220, 700, 40)
loGFX.fillrectangle(loBRUSH_BLUE, 250, 0, 20, 500)
loGFX.FILlrectangle(loBRUSH_BLUE, 0, 230, 700, 20)
loGFX.DRAWSTRing('Noruega', loFONT_CS20 ,loBRUSH_BLACK, 0, 460) 
_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureval()