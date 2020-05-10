DO SYSTEM

LOCAL loORIGINAL 	AS XFCBITMAP
LOCAL loQUADRO 	 	AS XFCBITMAP
LOCAL loMARCA	 	AS XFCBITMAP
LOCAL loGFX 	 	AS XFCGRAPHICS
LOCAL loENCODEPAR 	AS XFCENCODER
LOCAL loENCODE 		AS XFCENCODER
LOCAL loCLRMATRIX 	AS XFCCOLORMATRIX
LOCAL loATTR 		AS XFCIMAGEATTRIBUTES
LOCAL loRECT 		AS XFCRECTANGLE
LOCAL lcMARCATAM	AS String

* CARREGA IMAGEM ORIGINAL
loORIGINAL 		= _SCREEN.SYSTEM.Drawing.Bitmap.FromFile(GETPICT())

* CARREGA IMAGEM DE MARCA D'AGUA
loMARCA 		= _SCREEN.SYSTEM.Drawing.Bitmap.FromFile(GETPICT())

* CRIA QUADRO PARA DESENHAR IMAGEM
loQUADRO 		= _SCREEN.SYSTEM.Drawing.Bitmap.New(loORIGINAL.Width, loORIGINAL.Height)

* CRIA OBJETO PARA DESENHAR NO QUADRO BRANCO
loGFX 			= _SCREEN.SYSTEM.Drawing.Graphics.FromImage(loQUADRO)

* DESENHA IMAGEM ORIGNAL
loGFX.DrawImage(loORIGINAL, 0, 0, loORIGINAL.Width, loORIGINAL.Height)

* \ TRANSPARENCIA / *

LOCAL lnTRANSPRATIO AS Number
lnTRANSPRATIO 	= 0.50 && 100%/ 1 = 100%/ 0.75 = 75%/ Transpar�ncia da imagem.

* CRIAR UM , QUE TER� A INFORMA��O DAS TRANSFORMA��ES.
* A POSI��O (4,4) DA MATRIZ � RESPONS�VEL PELA OPACIDADE.
loCLRMATRIX = _screen.system.Drawing.imaging.colormatrix.new( ; 
   1, 0, 0, 0 , 0, ; 
   0, 1, 0, 0 , 0, ; 
   0, 0, 1, 0 , 0, ;
   0, 0, 0, lnTRANSPRATIO, 0, ; 
   0, 0, 0, 0 , 0)

* CRIAR UMA IMAGEM DO OBJETO ATRIBUTOS PARA CRIAR OS EFEITOS COM BASE EM NOSSA CLRMATRIX.
loATTR 			= _screen.system.Drawing.imaging.imageattributes.new() 
loATTR.setcolormatrix(loclrmatrix)

* PRECISAMOS CRIAR UM RET�NGULO QUE CONTER� AS COORDENADAS E TAMANHO DO LOGOTIPO TRANSFORMADO.
loRECT 			= _screen.system.Drawing.rectangle.new()
loRECT.x 		= loORIGINAL.Width  - (loMARCA.width)
loRECT.y 		= loORIGINAL.height - (loMARCA.height)
loRECT.width 	= loMARCA.width
loRECT.height 	= loMARCA.Height

* DESENHAR A IMAGEM TRANSFORMADA USANDO O RET�NGULO E IMGATTRIBUTES / CLRMATRIX.
loGFX.drawimage(loMARCA, loRECT, loMARCA.getbounds(), _screen.system.Drawing.graphicsunit.pixel, loATTR) 

loENCODEPAR 	= _SCREEN.System.Drawing.Imaging.EncoderParameters.New(1)
loENCODE 		= _SCREEN.System.Drawing.Imaging.EncoderParameter.New(_SCREEN.System.Drawing.Imaging.Encoder.Quality, 80)
loENCODEPAR.Param.Add(loENCODE)


loQUADRO.Save(PUTFILE('','','JPG'), _SCREEN.SYSTEM.Drawing.Imaging.ImageFormat.JPEG, loENCODEPAR)


