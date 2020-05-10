PARAMETERS tnX AS Integer, tnY AS Integer, toGFX AS Object, tcFILE AS String, tnFACTOR AS Integer

IF VARTYPE(_SCREEN.SYSTEM) <> 'O'
	DO 'C:\GDI\SYSTEM_LEAN'
ENDIF

SET PROCEDURE TO THREED.PRG
SET DECIMALS TO 8

PUBLIC goImage AS XFCBITMAP
PUBLIC goGfx as XFCGRAPHICS
PUBLIC ARRAY gaGrayColor[16]

goGfx = toGFX
*!*	goGfx = _SCREEN.SYSTEM.DRAWING.GRAPHICS.FROMHWND(_SCREEN.HWnd)
*!*	tnX = 20
*!*	tnY = 30
*!*	tcFILE = 'CUBE.OBJ'

LOCAL loAMat, loTMat, loMD as Object
LOCAL lPainted as Boolean
LOCAL lnXFac as Double
LOCAL lnPrevX, lnPrevY as Integer
LOCAL lnXTheta, lnYTheta as Double
LOCAL lnScaleFudge as Double
LOCAL lcMDName, lcMessage as String

loAMat 	= NEWOBJECT('Matrix3D','Matrix3D.prg')
loTMat 	= NEWOBJECT('Matrix3D','Matrix3D.prg')
loMD	= NEWOBJECT('Model3D','Threed.prg')

loMD.oMat.Unit()

loMD.findBB()
loMD.compress()

loAMat.YRot(tnX)
loAMat.XRot(tnY)

loMD.oMat.Translate(-(loMD.nXMin+loMD.nXMax)/ 2, -(loMD.nYMin + loMD.nYMax) / 2, -(loMD.nZMin + loMD.nZMax) / 2)
loMD.oMat.Mult(loAMat)

IF tnFACTOR <> 0
	xfac = tnFACTOR
ELSE
	xfac = 100
ENDIF


loMD.oMat.Scale(xfac, -xfac, 16 * xfac / 200)
loMD.oMat.Translate(200 / 2, 200 / 2, 8)

loMD.lTransformed = .f.

loMD.Paint()
*SUSP
*_SCREEN.IMAGE1.PICTUREVAL = goImage.GetPictureVal()

*!*	lPainted = .T.
*!*	lnScaleFudge = 1

*!*	*loMD.findBB()
*!*	*loMD.compress()
*!*	xw = loMD.nxmax - loMD.nxmin
*!*	yw = loMD.nymax - loMD.nymin
*!*	zw = loMD.nzmax - loMD.nzmin
*!*	if (yw > xw)
*!*		xw = yw
*!*	endif

*!*	if (zw > xw)
*!*		xw = zw
*!*	ENDIF

*!*	f1 = 1000 / xw
*!*	f2 = 1000 / xw

*xfac = 0.7f * (f1 < f2 ? f1 : f2) * scalefudge;

*loMD.Paint()

***************************
DEFINE CLASS MODEL3D as Custom
******************************
	DIMENSION aVert[1]
	DIMENSION aTVert[1]
	DIMENSION aCon[1]
	
	nVert 			= 0
	nMaxVert 		= 0
	nNCon 			= 1
	nMaxCon 		= 0
	lTransformed	=.F.
	oMat			= null
	nXMin			= 0
	nXmax			= 0
	nYmin			= 0
	nYmax			= 0
	nZmin			= 0
	nZmax			= 0
  
  	PROC Init
  	*********
		LOCAL lcFILE AS String
		LOCAL lnXI AS Integer
		LOCAL lnX, lnY, lnZ AS Double

		* CRIANDO OBJETO MATRIX3D
		This.oMat = NEWOBJECT('MATRIX3D','MATRIX3D.PRG')

*!*			IF USED('TMPFILE')
*!*				USE IN TMPFILE
*!*			ENDIF

*!*			CREATE CURSOR TMPFILE (DS_CONT CHAR(254))
*!*			APPEND FROM (tcFILE) TYPE SDF

		SELE TMPFILE
		GO TOP
		SCAN WHILE NOT EOF()
			lcLINHA = TMPFILE.DS_CONT+" "
			
			DO CASE
				CASE LEFT(UPPER(lcLINHA),1) == 'V'
					lnX = VAL( STREXTRACT( lcLINHA,' ',' ',1 ) )
					lnY = VAL( STREXTRACT( lcLINHA,' ',' ',2 ) )
					lnZ = VAL( STREXTRACT( lcLINHA,' ',' ',3 ) )
					This.AddVert(lnX, lnY, lnZ)
				
				CASE LEFT(UPPER(lcLINHA),1) $ 'F|FO|L'
					lnStart = -1
				    lnPrev = -1
				    ln = -1
				    lnCont = 0
				    DO WHILE (.T.)
				    	lnCont = lnCont + 1
				    	lcItem = STREXTRACT( lcLINHA,' ',' ',lnCont)
				    	
				    	IF EMPTY(lcItem)
							EXIT
				    	ENDIF
				    	
				    	IF lcItem $ '0123456789'
						    ln = VAL(lcItem)
						    IF (lnPrev >= 0)
								This.AddNormal(lnPrev - 1, ln - 1)
							ENDIF
							
						    IF (lnStart < 0)
								lnStart = ln
							ENDIF
							
						    lnPrev = ln
						ELSE
							IF lcItem = '/'
								EXIT		
							ENDIF
						ENDIF
				    ENDDO
				    IF (lnStart >= 0)
						This.AddNormal(lnStart - 1, lnPrev - 1)
					ENDIF
			ENDCASE
		ENDSCAN
	ENDPROC
	
	PROC AddVert(tnX as Double, tnY as Double, tnZ as Double)
	*********************************************************
		LOCAL lnVert as Integer
		lnI = This.nVert

		IF lnI >= This.nMaxVert
			IF TYPE('This.aVert') = 'L'
				This.nMaxVert = 100
				DIMENSION This.aVert[This.nMaxVert * 3]
			ELSE
				This.nMaxVert = This.nMaxVert * 2
				DIMENSION This.aVert[This.nMaxVert * 3]
			ENDIF
		ENDIF
		
		lnI = lnI * 3
		This.aVert[lnI +1] 	= tnX
		This.aVert[lnI +2] 	= tnY
		This.aVert[lnI +3] 	= tnZ
		
		This.nVert = This.nVert + 1
		RETURN (This.nVert-1)
	ENDPROC

	PROC AddNormal(tnP1 as Integer, tnP2 as Integer)
	************************************************
		LOCAL lnI as Integer
		lnI = This.nNCon
		
		IF (tnP1 >= This.nVert) OR (tnP2 >= This.nVert)
			RETURN
		ENDIF

		IF lnI >= This.nMaxCon

			IF TYPE('This.aCon') = 'L'
				This.nMaxCon = 100
				DIMENSION This.aCon[This.nMaxCon * 3]
			ELSE
				This.nMaxCon = This.nMaxCon * 2
				DIMENSION This.aCon[This.nMaxCon * 3]
			ENDIF
		ENDIF

		LOCAL lnT AS Integer
			
		IF (tnP1 > tnP2)
			lnT = tnP1
		    tnP1 = tnP2
		    tnP2 = lnT
		ENDIF

		*con[i] = (p1 << 16) | p2	
		This.aCon[lnI] = BITOR(BITLSHIFT(tnP1, 16),tnP2)
		This.nNCon = This.nNCon + 1
		
	ENDPROC

	PROC TRANSFORMAR
	****************
	    ** Transform all the points in this model **
		IF This.lTransformed OR This.nVert <= 0
		    RETURN
		ENDIF
		
		IF TYPE('This.aTVert') = 'L' OR ALEN(This.aTVert,1) < (This.nVert * 3)
			DIMENSION This.aTVert[This.nVert * 3]
			LOCAL ARRAY laAUX1[1]
			LOCAL ARRAY laAUX2[1]
			
			ACOPY(This.aVert, laAUX1)
			ACOPY(This.aTVert, laAUX2)
			This.oMat.Transformar(@laAUX1, @laAUX2, This.nVert)
			ACOPY(laAUX1, This.aVert)
			ACOPY(laAUX2, This.aTVert)
			This.lTransformed = .T.
		ENDIF
	ENDPROC

	PROC QuickSort(tnA as Array , tnLeft as Integer, tnRight as Integer)
	**********************************************************************
	   ** Quick Sort implementation    **
		LOCAL lnLeftIndex, lnRightIndex, lnPartionElement as Integer

		lnLeftIndex = tnLeft
		lnRightIndex = tnRight
		
		IF tnRight > tnLeft
	         ** Arbitrarily establishing partition element as the midpoint of
	          * the array.
	          */
	         lnPartionElement = tnA[ ( tnLeft + tnRight ) / 2 ]

	         * loop through the array until indices cross
	         DO WHILE ( lnLeftIndex <= lnRightIndex )
	            ** find the first element that is greater than or equal to
	             * the partionElement starting from the leftIndex.
	             */
	            DO WHILE ( ( lnLeftIndex < tnRight ) AND ( tnA[lnLeftIndex] < lnPartionElement ) )
	               lnLeftIndex = lnLeftIndex + 1
				ENDDO
				
	            ** find an element that is smaller than or equal to
	             * the partionElement starting from the rightIndex.
	             */
	            DO WHILE ( ( lnRightIndex > tnLeft ) AND ( tnA[lnRightIndex] > lnPartionElement ) )
	               lnRightIndex = lnRightIndex - 1
				ENDDO
				
	            * if the indexes have not crossed, swap
	            IF( lnLeftIndex <= lnRightIndex )
					This.Swap(@tnA, lnLeftIndex, lnRightIndex)
					lnLeftIndex = lnLeftIndex + 1
					lnRightIndex = lnRightIndex - 1
				ENDIF
	            
	         ENDDO

	         ** If the right index has not reached the left side of array
	          * must now sort the left partition.
	          */
			IF( tnLeft < lnRightIndex )
				This.QuickSort( @tnA, tnLeft, lnRightIndex )
	         ** If the left index has not reached the right side of array
	          * must now sort the right partition.
	          */
			ENDIF
	         
			IF( lnLeftIndex < tnRight )
				This.QuickSort( @tnA, lnLeftIndex, tnRight )
			ENDIF
			
	      ENDIF
	     
	ENDPROC

	PROC Swap(tnA as Array, tnI as Integer, tnJ as Integer)
	*******************************************************
		LOCAL lnT as Integer
		lnT = tnA[tnI]	
		tnA[tnI] = tnA[tnJ]
		tnA[tnJ] = lnT
	ENDPROC

	PROC COMPRESS
	*************
	    ** eliminate duplicate lines */
	    * TAKE - Ver chamada do metodo quicksort
	    
	    LOCAL lnLimit as Integer
	    LOCAL ARRAY laC[1]
		LOCAL ARRAY laAUX[1]	    
		lnLimit = This.nNCon
		=ACOPY(This.aCon, laC)
		*=ACOPY(This.aCon, laAUX)
		*This.QuickSort(@laC, 1, This.nNCon-1)
		* AQUI TAKEHANA
		FOR i = 1 TO ALEN(laC,1)
			lnQTD = I
			abc = laC[I]
			IF VARTYPE(abc) = 'L'
				exit
			ENDIF
		ENDFOR
		=ASORT(laC,1,lnQTD-1)
		LOCAL lnD, lnPP1, lnXI, lnP1 as Integer
		lnD = 1
		lnPP1 = -1
		
		FOR lnXI = 1 TO lnLimit-1
			lnP1 = laC[lnXI]
 			IF lnPP1 <> lnP1
				laC[lnD] = lnP1
				lnD = lnD + 1
			ENDIF
			lnPP1 = lnP1
		ENDFOR
		
		=ACOPY(laC, This.aCon)
		
		This.nNCon = lnD
	ENDPROC
	
*    static Color gr[];

	PROC PAINT
	**********
    ** Paint this model to a graphics context.  It uses the matrix associated
	* with this model to map from model space to screen space.
	* The next version of the browser should have double buffering,
	* which will make this *much* nicer */
		IF TYPE('This.aVert') = 'L' OR This.nVert <= 0
			RETURN
		ENDIF
		
		This.Transformar()
		
		LOCAL lnXI as Integer
		LOCAL lnGrey as Integer

		IF VARTYPE(gaGrayColor) = 'L'
		    FOR lnXI = 1 TO 16
				lnGrey = INT(170*(1-(((lnXI-1)/15)^1)))
				gaGrayColor[lnXI] = RGB(lnGrey, lnGrey, lnGrey)
		    ENDFOR
		ENDIF

		LOCAL lnLG, lnLim as Integer
		LOCAL ARRAY laC[1]
		LOCAL ARRAY laV[1]
		
		lnLG = 0
		lnLim = This.nNCon
		=ACOPY(This.aCon, laC)
		=ACOPY(This.aTVert, laV)

		IF lnLim <=0 OR This.nVert <= 0
			RETURN
		ENDIF

		LOCAL lnT, lnP1, lnP2 as Integer
		LOCAL loPen as XFCPEN

		loPen = _Screen.System.Drawing.Pen.Color.Gray
		
		FOR lnXI = 1 TO lnLim-1
			lnT = laC[lnXI]
			lnP1 = BITAND(BITRSHIFT(lnT, 16),0xFFFF)*3
			lnP2 = BITAND(lnT, 0xFFFF) * 3
			lnGrey = laV[lnP1+1] + laV[lnP2+1]
*			?lnGrey
*			WAIT WINDOW lnGrey
			lnGrey = FLOOR(lnGrey/28)
			IF lnGrey < 0
				lnGrey = 0
			ENDIF
			IF lnGrey > 16
				lnGrey = 16
			ENDIF
			IF lnGrey <> lnLG
				*lnLG = lnGrey
				*lnCOR = gaGrayColor[lnGrey]
				lnCOR = 0
*				??lnGrey
*				loPen = _Screen.System.Drawing.Pen.Color.FromRgb(GetRed(lnCOR), GetGreen(lnCOR), GetBlue(lnCOR))
				loPen = _Screen.System.Drawing.Pen.New(_Screen.System.Drawing.Pen.Color.FromRgb(GetRed(lnCOR), GetGreen(lnCOR), GetBlue(lnCOR)),1)
*				loPen = _Screen.system.Drawing.Pen.New(_screen.system.Drawing.Brushes.Black)
			ELSE
				loPen = _Screen.system.Drawing.Pen.New(_screen.system.Drawing.Brushes.Black,1)
			ENDIF

		
			*MESSAGEBOX('P1 '+TRANSFORM(lnP1)+' P2 '+TRANSFORM(lnP2))
			lnVAR = 200 && DESENHAR OBJETO MAIS PARA O CENTRO

 			*MESSAGEBOX( TRANSFORM(lnVAR+laV[lnP1+1]) + ' - ' + TRANSFORM(lnVAR+laV[lnP1+2]) + ' - ' +;
			TRANSFORM(lnVAR+laV[lnP2+1]) + ' - ' + TRANSFORM(lnVAR+laV[lnP2+2]) )
			
			goGfx.DrawLine(loPen, lnVAR+laV[lnP1+1], lnVAR+laV[lnP1+2], lnVAR+laV[lnP2+1], lnVAR+laV[lnP2+2])
			*goGfx.DrawLine(loPen, 10, 10, 50, 50)
		ENDFOR
		
*		_Screen.Image1.PictureVal = goImage.GetPictureValfromHBitmap()
    ENDPROC

	PROC FindBB
	************
    ** Find the bounding box of this model */
		IF This.nVert <= 0
			RETURN
		ENDIF
		
		LOCAL ARRAY laV[1]
		LOCAL lnXMin, lnYMin, lnZMin as Double		
		LOCAL lnXMax, lnYMax, lnZMax as Double		
		
		=ACOPY(This.aVert, laV)
		lnXMin = laV[1]
		lnXMax = laV[1]
		lnYMin = laV[2]
		lnYMax = laV[2]
		lnZMin = laV[3]
		lnZMax = laV[3]

		LOCAL lnXI as Integer
		LOCAL lnX, lnY, lnZ as Double
		
		FOR lnXI = (This.nVert * 3 - 3) TO 1 STEP -3
		    lnX = laV[lnXI]
		    IF (lnX < lnXMin)
				lnXMin = lnX
			ENDIF
			
			IF (lnX > lnXMax)
				lnXMax = lnX
			ENDIF
			
			lnY = laV[lnXI + 1]
		    IF (lnY < lnYMin)
				lnYMin = lnY
			ENDIF
			
		    IF (lnY > lnYMax)
				lnYMax = lnY
			ENDIF
			
		    lnZ = laV[lnXI + 2]
		    IF (lnZ < lnZMin)
				lnZMin = lnZ
			ENDIF
			
		    IF (lnZ > lnZMax)
				lnZMax = lnZ
			ENDIF
		ENDFOR

		This.nXMax = lnXMax
		This.nXMin = lnXMin
		This.nYMax = lnYMax
		This.nYMin = lnYMin
		This.nZMax = lnZMax
		This.nZMin = lnZMin
	ENDPROC
	
ENDDEFINE

FUNCTION GetRed(tnColor) 
   RETURN BITAND(tnColor, 0x000000FF) 
ENDFUNC 

FUNCTION GetGreen(tnColor) 
   RETURN BITRSHIFT(BITAND(tnColor, 0x0000FF00), 8) 
ENDFUNC 

FUNCTION GetBlue(tnColor) 
   RETURN BITRSHIFT(BITAND(tnColor, 0x00FF0000), 16) 
ENDFUNC