DO SYSTEM 

IF TYPE('_screen.imgTABLE') <> 'O'
	_SCREEN.AddObject('imgTABLE','IMAGE')
	_SCREEN.imgTABLE.Visible = .T.
	_SCREEN.imgTABLE.Height = _SCREEN.Height
	_SCREEN.imgTABLE.Width  = _SCREEN.Width
ENDIF


LOCAL loIMAGE AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loSQ1 AS XFCBRUSH
LOCAL loSQ2 AS XFCBRUSH
LOCAL lcCSC as String
LOCAL lnCont as Number
LOCAL lnSSM as Number

loIMAGE = _SCREEN.SYSTEM.Drawing.Bitmap.New(_SCREEN.imgTABLE.Width,_SCREEN.imgTABLE.Height)
loGFX = _SCREEN.SYSTEM.Drawing.Graphics.FromImage(loIMAGE)

&& Cores do Tabuleiro
loSQ1 = _SCREEN.SYSTEM.Drawing.Brushes.PapayaWhip
loSQ2 = _SCREEN.SYSTEM.Drawing.Brushes.Sienna

&& Cores das Peças
* Peças "Brancas" = LightSteelBlue
* Peças "Pretas"  = DarkSlateGray

&&Medida de cada Quadrado
IF _SCREEN.imgTABLE.Height < _SCREEN.imgTABLE.Width
	lnSSM = _SCREEN.imgTABLE.Height/8
ELSE
	lnSSM = _SCREEN.imgTABLE.Width/8
ENDIF

&& Código que define qual será a cor do fundo baseado no valor do contador e no número da linha
* INT(lnCont/8) = Define qual o número da linha
* A cor é definida a partir de uma igualdade e, por isso, seu resultado varia de acordo com cada lado da igualdade.
* O primeiro lado é influenciado pelo contador.
* O segundo lado é influenciado também pelo contador, mas de forma mais simples, pela linha atual (formada por 8).
lcCSC = "IIF(MOD(lnCont,2)=MOD(INT(lnCont/8),2),loSQ1,loSQ2)"

&& Código que gera cada quadrado com respectivas cores e posição.
* A cor é definida pelo código acima.
* Para descobrir o X e o Y, são realizadas duas contas;
* O X é definido pelo número do quadrado em relação à linha (Definido pelo resto da divisão entre o contador e 8;
	*Sendo este o número de quadrados em cada linha)
* O Y é definido pelo número da linha (Definido pelo valor inteiro da divisão entre o contador e 8)
* Contudo, os valores de X e Y só são realmente achados quando se multiplica os valores obtidos até agora
* (que, no caso, indicariam qual o quadrado e número da linha) pelo tamanho de cada quadrado (lnSSM)
FOR lnCont=0 TO 63
	loGFX.FillRectangle(&lcCSC,(MOD(lnCont,8)*lnSSM),(INT(lnCont/8)*lnSSM),lnSSM,lnSSM)
ENDFOR

***********************
_SCREEN.imgTABLE.PictureVal = loIMAGE.GetPictureVal()