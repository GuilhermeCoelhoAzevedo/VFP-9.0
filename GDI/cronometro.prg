CD G:\USUARIOS\Coelho\PWI\Exercicios\GDI
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
loBRUSH_DEEPBLUE = _SCREEN.SYSTEM.Drawing.Brushes.DEEPSKYBLUE
loBRUSH_Blue	 = _SCREEN.SYSTEM.Drawing.Brushes.Blue
loBRUSH_Black	 = _SCREEN.SYSTEM.DRAWING.BRUSHES.BLACK

* Escolhendo fonte						 Nome fonte, Tamanho da Fonte
loFONT_CS20 = _SCREEN.SYSTEM.Drawing.Font.New('Comic Sans MS',20)
loFONT_AR15 = _SCREEN.SYSTEM.Drawing.Font.New('Arial',15)

* CRIANDO ESPA�O PARA DESENHO
loIMAGE = _SCREEN.SYStem.Drawing.Bitmap.New(700,500)
loGFX = _SCREEN.SYStem.Drawing.Graphics.FromImage(loIMAGE)

*!*	* CRIANDO CANETA
loPEN_BLACK = _SCREEN.SYSTEM.Drawing.Pen.New(_SCREEN.SYStem.Drawing.Brushes.Black)

* COLORINDO
loGFX.Clear(_SCREEN.SYSTEM.Drawing.Color.White)

*Preenchendo circulo

loGFX.Drawarc(loPEN_Black, 65, 65, 250, 250, 360, 360)
loGFX.Drawstring('0', loFONT_CS20, loBRUSH_BLUE, 178, 65) 
loGFX.Drawstring('15', loFONT_CS20, loBRUSH_BLUE, 278, 170)  
loGFX.Drawstring('30', loFONT_CS20, loBRUSH_BLUE, 168, 280)  
loGFX.Drawstring('45', loFONT_CS20, loBRUSH_BLUE, 62, 170)  
_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureval()

&&Pincel, X, Y, Width, Height, �ngulo de comeco, Qtd �ngulo para somar
FOR X = 1 TO 360
	loGFX.FillPie(loBRUSH_DEEPBLUE, 100, 100, 180, 180, 270, X)	
	_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureval()
ENDFOR