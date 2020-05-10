DO SYSTEM
LOCAL loBMP AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loPEN AS XFCPENs

IF TYPE('_screen.img1') <> 'O'
	_SCREEN.AddObject('IMG1','IMAGE')
	_SCREEN.IMG1.Visible = .t.
	_SCREEN.IMG1.Height = 500
	_SCREEN.IMG1.Width = 500
ENDIF

LOCAL loIMAGE AS XFCIMAGE
LOCAL loGFX AS XFCGRAPHICS
LOCAL loBRUSH AS XFCBRUSH
LOCAL loFONT AS XFCFONT
LOCAL loALIGN AS XFCSTRINGFORMAT
LOCAL loRECTF AS XFCRECTANGLEF


* CRIANDO UM OBJETO IMAGE

loIMAGE = _SCREEN.SYSTEM.Drawing.Bitmap.New(800,800)

* CRIANDO UM OBJETO PARA MANIPULAR A IMAGEM

loGFX = _SCREEN.SYSTEM.Drawing.Graphics.FromImage(loIMAGE)

* COLORINDO 

loGFX.Clear(_SCREEN.SYSTEM.Drawing.Color.DarkOrange)

* CRIANDO PINCEL

loBRUSH = _SCREEN.SYSTEM.Drawing.Brushes.DarkGray


LOCAL lnX,lnY,I

lnX = 0
lnY = 100


* CRIANDO LINHAS DE CONTORNO DO TABULEIRO

* No controle de repeti��o abaixo � feito um loop de 1 a 8 onde s�o utilizadas duas variaveis referenciando
* as posi��es X E Y (lnX e lnY) onde ser�o feitos os desenhos das linhas do tabuleiro. Nas duas linhas de c�digo
* que seguem uma dessas variaveis � multiplicada pela variavel do controle de repeti��o de modo inverso em cada linha para 
* assim tra�ar linhas verticais e horizontais  (1� caso : lnX ,lnY*I, 2� caso lnY*I,lnX).


FOR I = 1 TO 8 
    LOGFX.FillRectangle(loBRUSH,lnX ,lnY*I,900,2)
    LOGFX.FillRectangle(loBRUSH,lnY*I,lnX,2,900)
ENDFOR  

loBRUSH = _SCREEN.SYSTEM.Drawing.Brushes.Black


* CRIANDO OS QUADRADOS DIFERENCIAIS DO TABULEIRO.

* DUAS ESTRUTURAS DE REPETI��O 'FOR' DE 0 A 8 COM O INTUITO DE PREENCHER LINHAS E COLUNAS UTILIZANDO O MESMO C�DIGO
* NA LINHA DE C�DIGO A SEGUIR � FEITO O DESENHO DOS QUADRADOS MULTIPLICANDO AS VARIAVEIS LNY POR 100 E LNX POR 200, CASO O MOD 2
* DA VARIAVEL LNY N�O SEJA IGUAL A ZERO � ADICIONADO O VALOR DE 100 A ESTA CONTA COM O INTUITO DE ALTERNAR A POSI��O DE X ENTRE AS LINHAS E 
* PRODUZIR O EFEITO XADREZ ADEQUADO.

* OBS: A VARIAVEL LNY � MULTIPLICADA POR 100 POIS ESTA � A DIMENS�O DE CADA QUADRADO, CASO QUISESEMOS ALTERNAR ENTRE LINHAS
* MULTIPLICARIAMOS ESTA VARIAVEL POR 200, COMO � O CASO DA VARIAVEL LNX ONDE � NECESS�RIO 'PULAR' UM QUADRADO PARA TERMOS O EFEITO
* ALTERNADO DE XADREZ.

FOR lnX = 0 TO 8 
	FOR lnY = 0 TO 8
	    LOGFX.FillRectangle(loBRUSH,IIF(MOD(lnY,2)=0,lnX * 200,(lnX * 200) + 100), lnY * 100,100,100)
	ENDFOR
ENDFOR 


* VERS�O EXTENDIDA

*!*	FOR lnY = 0 TO 8 STEP 2 

*!*		FOR lnX = 0 TO 8
*!*		    LOGFX.FillRectangle(loBRUSH,lnX * 200,lnY * 100,100,100)
*!*		*_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureVal()
*!*		ENDFOR
*!*		
*!*		*FOR 
*!*		
*!*	ENDFOR 


*!*	FOR lnY = 1 TO 8 STEP 2 

*!*		FOR lnX = 1 TO 8 STEP 2 
*!*		    LOGFX.FillRectangle(loBRUSH,lnX * 100,lnY * 100,100,100)
*!*		*_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureVal()
*!*		ENDFOR
*!*		
*!*		*FOR 
*!*		
*!*	ENDFOR 


_SCREEN.IMG1.PictureVal = loIMAGE.GetPictureVal()


