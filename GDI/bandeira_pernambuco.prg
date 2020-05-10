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
	_SCREEN.IMG1.Height = 800
	_SCREEN.IMG1.Width = 600
ENDIF

DO SYSTEM

*Criando pincel
loBRUSH_RED = _SCREEN.SYSTEM.Drawing.Brushes.Red
loBRUSH_WHITE = _SCREEN.SYSTEM.Drawing.Brushes.White
loBRUSH_Yellow = _SCREEN.System.Drawing.Brushes.Yellow

*Escolhendo fonte
loFONT_CS20 = _SCREEN.SYSTEM.Drawing.Font.New('Comic Sans MS', 20)

*Criando espaço para desenho
loIMAGE = _SCREEN.System.Drawing.Bitmap.New(900,600)
loGFX = _SCREEN.System.Drawing.Graphics.FromImage(loIMAGE)

*Criando caneta
loPEN_RED = _SCREEN.System.Drawing.Pen.New(_SCREEN.SYSTEM.Drawing.Brushes.Red)
loPEN_GREEN = _SCREEN.System.Drawing.Pen.New(_SCREEN.System.Drawing.Brushes.Green)
loPEN_YELLOW = _SCREEN.System.Drawing.Pen.New(_SCREEN.System.Drawing.Brushes.Yellow)
*Colorindo
loGFX.Clear(_SCREEN.System.Drawing.Color.PURPLE)
*Desenhando
loGFX.Fillrectangle(loBRUSH_WHITE,0 , 350, 1000, 270)
loGFX.Fillrectangle(loBRUSH_RED,285 , 420, 140, 30)
loGFX.Fillrectangle(loBRUSH_RED,340 , 370, 30, 160)
loGFX.DrawArc(loPEN_GREEN , 110, 263, 500, 170, 180, 180)
loGFX.DrawArc(loPEN_YELLOW , 90, 250, 550, 190, 180, 180)
loGFX.DrawArc(loPEN_RED , 70, 240, 600, 210, 180, 180)
loGFX.FillEllipse(loBRUSH_Yellow, 330, 290, 50, 50)
loGFX.DrawString('Pernambuco',loFONT_CS20, loBRUSH_RED, 0, 550)
_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureVal()