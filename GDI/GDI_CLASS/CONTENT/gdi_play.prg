* Carregando classe GDI++
DO SYSTEM 

IF TYPE('_screen.IMG1') <> 'O'
	_SCREEN.AddObject('IMG1','IMAGE')
	_SCREEN.IMG1.Visible = .t.
	_SCREEN.IMG1.Height = _SCREEN.Width
	_SCREEN.IMG1.Width = _SCREEN.Height
ENDIF


LOCAL loIMAGE AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loBRUSH AS XFCBRUSH

loIMAGE = _SCREEN.SYSTEM.Drawing.Bitmap.New(500, 500)
loGFX = _SCREEN.SYSTEM.Drawing.Graphics.FromImage(loIMAGE)

* Criando pincel
loBRUSH = _SCREEN.SYSTEM.Drawing.Brushes.Gold

* Criando Estrela
***********************
&& PROPORÇÃO DA ESTRELA
LOCAL lnPROP as Number
lnPROP = 1
&&

	* Definindo Pontos
LOCAL ARRAY laP[10,2]

&&PARA MUDAR POSIÇÃO DA ESTRELA (LEFT,TOP)
	laP[1,1] = 150
	laP[1,2] = 10
&&	

&& PADRÃO DA ESTRELA	(NÃO MUDAR)
	laP[2,1] = (-41 * lnPROP)		+ laP[1,1]
	laP[2,2] = (82  * lnPROP)		+ laP[1,2]
	laP[3,1] = (-132* lnPROP)		+ laP[1,1]
	laP[3,2] = (95  * lnPROP)		+ laP[1,2]
	laP[4,1] = (-66 * lnPROP)   	+ laP[1,1]
	laP[4,2] = (158	* lnPROP)		+ laP[1,2]
	laP[5,1] = (-81	* lnPROP)		+ laP[1,1]
	laP[5,2] = (249	* lnPROP)		+ laP[1,2]
	laP[6,1] = laP[1,1]
	laP[6,2] = (207	* lnPROP)		+ laP[1,2]
	laP[7,1] = laP[1,1] 	+ (laP[1,1]-laP[5,1])
	laP[7,2] = laP[5,2]
	laP[8,1] = laP[1,1] 	+ (laP[1,1]-laP[4,1])
	laP[8,2] = laP[4,2]
	laP[9,1] = laP[1,1] 	+ (laP[1,1]-laP[3,1])
	laP[9,2] = laP[3,2]
	laP[10,1]= laP[1,1] 	+ (laP[1,1]-laP[2,1])
	laP[10,2]= laP[2,2]
	
	&& 1 - 6
	&& 2 - 10
	&& 3 - 9
	&& 4 - 8
	&& 5 - 7
	
 	loGFX.FillPolygon(loBRUSH, @laP)
***********************
_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureVal()

*!*	RETURN(loIMAGE.GetPictureVal())