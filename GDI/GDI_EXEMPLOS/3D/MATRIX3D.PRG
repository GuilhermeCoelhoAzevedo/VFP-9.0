Define class Matrix3D as Custom
*******************************
** A fairly conventional 3D matrix object that can transform sets of
** 3D points and perform a variety of manipulations on the transform
** Rewrite for VFP9 by Thiago Takehana
** Start Time 21/05/2009 23:33:00

	* Definindo atributos da classe
    XX = 0.00
    XY = 0.00
    XZ = 0.00
    XO = 0.00
    YX = 0.00
    YY = 0.00
    YZ = 0.00
    YO = 0.00
    ZX = 0.00
    ZY = 0.00
    ZZ = 0.00
    ZO = 0.00

	PROC Init
	*********
	** Create a new unit matrix **
		This.XX = 1
		This.YY = 1
		This.ZZ = 1
	ENDPROC
	
	PROC Scale(tnXF AS Double, tnYF AS Double, tnZF AS Double)
	********************
	** Scale by f in all dimensions / Scale along each axis independently **
		LOCAL lnXF, lnYF, lnZF AS Double

*		SET STEP ON 
		
		IF PCOUNT() = 1
			* Apenas 1 parâmetro então aplica para todos	
			STORE tnXF TO lnXF, lnYF, lnZF
		ELSE
			* Aplica cada parâmetro para cada coordenada
			lnXF = tnXF
			lnYF = tnYF
			lnZF = tnZF
		ENDIF
		
	    This.XX = This.XX * lnXF
	    This.XY = This.XY * lnXF
	    This.XZ = This.XZ * lnXF
	    This.XO = This.XO * lnXF
	    This.YX = This.YX * lnYF
	    This.YY = This.YY * lnYF
	    This.YZ = This.YZ * lnYF
	    This.YO = This.YO * lnYF
	    This.ZX = This.ZX * lnZF
	    This.ZY = This.ZY * lnZF
	    This.ZZ = This.ZZ * lnZF
	    This.ZO = This.ZO * lnZF
	ENDPROC
	
	PROC Translate(tnX as Double, tnY as Double, tnZ as Double)
	***********************************************************
	** Translate the origin **
		This.XO = This.XO + tnX
		This.YO = This.YO + tnY
		This.ZO = This.ZO + tnZ
	ENDPROC
	
	PROC YROT(tnTheta as Double)
	*********
	** Rotate theta degrees about the y axis **
		LOCAL lnTheta as Double
		LOCAL lnCos, lnSin as Double
		
		lnTheta = tnTheta * ( PI() / 180 )
		lnCos = COS(lnTheta)
		lnSin = SIN(lnTheta)
		
		LOCAL lnNXX, lnNXY, lnNXZ, lnNXO as Double		 
		lnNXX = ( This.XX * lnCos + This.ZX * lnSin )
		lnNXY = ( This.XY * lnCos + This.ZY * lnSin )
		lnNXZ = ( This.XZ * lnCos + This.ZZ * lnSin )
		lnNXO = ( This.XO * lnCos + This.ZO * lnSin )

		LOCAL lnNZX, lnNZY, lnNZZ, lnNZO as Double		 
		lnNZX = ( This.ZX * lnCos - This.XX * lnSin )
		lnNZY = ( This.ZY * lnCos - This.XY * lnSin )
		lnNZZ = ( This.ZZ * lnCos - This.XZ * lnSin )
		lnNZO = ( This.ZO * lnCos - This.XO * lnSin )

		This.XX = lnNXX
		This.XY = lnNXY
		This.XZ = lnNXZ
		This.XO = lnNXO
		This.ZX = lnNZX
		This.ZY = lnNZY
		This.ZZ = lnNZZ
		This.ZO = lnNZO
		
	ENDPROC
	
	PROC XROT(tnTheta as Double)
	****************************
	** Rotate theta degrees about the x axis **
		LOCAL lnTheta as Double
		LOCAL lnCos, lnSin as Double
		
		lnTheta = tnTheta * ( PI() / 180 )
		lnCos = COS(lnTheta)
		lnSin = SIN(lnTheta)

		LOCAL lnNYX, lnNYY, lnNYZ, lnNYO as Double		 
		lnNYX = ( This.YX * lnCos + This.ZX * lnSin )
		lnNYY = ( This.YY * lnCos + This.ZY * lnSin )
		lnNYZ = ( This.YZ * lnCos + This.ZZ * lnSin )
		lnNYO = ( This.YO * lnCos + This.ZO * lnSin )

		LOCAL lnNZX, lnNZY, lnNZZ, lnNZO as Double		 
		lnNZX = ( This.ZX * lnCos - This.YX * lnSin )
		lnNZY = ( This.ZY * lnCos - This.YY * lnSin )
		lnNZZ = ( This.ZZ * lnCos - This.YZ * lnSin )
		lnNZO = ( This.ZO * lnCos - This.YO * lnSin )

		This.YX = lnNYX
		This.YY = lnNYY
		This.YZ = lnNYZ
		This.YO = lnNYO
		This.ZX = lnNZX
		This.ZY = lnNZY
		This.ZZ = lnNZZ
		This.ZO = lnNZO
		
	ENDPROC
	
	PROC ZROT(tnTheta as Double)
	****************************
	** Rotate theta degrees about the z axis **
		LOCAL lnTheta as Double
		LOCAL lnCos, lnSin as Double
		
		lnTheta = tnTheta * ( PI() / 180 )
		lnCos = COS(lnTheta)
		lnSin = SIN(lnTheta)

		LOCAL lnNYX, lnNYY, lnNYZ, lnNYO as Double		 
		lnNYX = ( This.YX * lnCos + This.XX * lnSin )
		lnNYY = ( This.YY * lnCos + This.XY * lnSin )
		lnNYZ = ( This.YZ * lnCos + This.XZ * lnSin )
		lnNYO = ( This.YO * lnCos + This.XO * lnSin )

		LOCAL lnNXX, lnNXY, lnNXZ, lnNXO as Double		 
		lnNXX = ( This.XX * lnCos - This.YX * lnSin )
		lnNXY = ( This.XY * lnCos - This.YY * lnSin )
		lnNXZ = ( This.XZ * lnCos - This.YZ * lnSin )
		lnNXO = ( This.XO * lnCos - This.YO * lnSin )

		This.YX = lnNYX
		This.YY = lnNYY
		This.YZ = lnNYZ
		This.YO = lnNYO
		This.XX = lnNXX
		This.XY = lnNXY
		This.XZ = lnNXZ
		This.XO = lnNXO
	
	ENDPROC

	PROC Mult(toMtz as Object)
	**************************
	** Multiply this matrix by a second: M = M*R **
		LOCAL lnXX, lnXY, lnXZ, lnXO AS Double
		LOCAL lnYX, lnYY, lnYZ, lnYO AS Double
		LOCAL lnZX, lnZY, lnZZ, lnZO AS Double
		
		lnXX = This.XX * toMtz.XX + This.YX * toMtz.XY + This.ZX * toMtz.XZ
		lnXY = This.XY * toMtz.XX + This.YY * toMtz.XY + This.ZY * toMtz.XZ
		lnXZ = This.XZ * toMtz.XX + This.YZ * toMtz.XY + This.ZZ * toMtz.XZ
		lnXO = This.XO * toMtz.XX + This.YO * toMtz.XY + This.ZO * toMtz.XZ + toMtz.XO
		    
		lnYX = This.XX * toMtz.YX + This.YX * toMtz.YY + This.ZX * toMtz.YZ
		lnYY = This.XY * toMtz.YX + This.YY * toMtz.YY + This.ZY * toMtz.YZ
		lnYZ = This.XZ * toMtz.YX + This.YZ * toMtz.YY + This.ZZ * toMtz.YZ
		lnYO = This.XO * toMtz.YX + This.YO * toMtz.YY + This.ZO * toMtz.YZ + toMtz.YO

		lnZX = This.XX * toMtz.ZX + This.YX * toMtz.ZY + This.ZX * toMtz.ZZ
		lnZY = This.XY * toMtz.ZX + This.YY * toMtz.ZY + This.ZY * toMtz.ZZ
		lnZZ = This.XZ * toMtz.ZX + This.YZ * toMtz.ZY + This.ZZ * toMtz.ZZ
		lnZO = This.XO * toMtz.ZX + This.YO * toMtz.ZY + This.ZO * toMtz.ZZ + toMtz.ZO

		This.XX = lnXX
		This.XY = lnXY
		This.XZ = lnXZ
		This.XO = lnXO

		This.YX = lnYX
		This.YY = lnYY
		This.YZ = lnYZ
		This.YO = lnYO

		This.ZX = lnZX
		This.ZY = lnZY
		This.ZZ = lnZZ
		This.ZO = lnZO
	
	ENDPROC	
	
	PROC Unit
	*********
	** Reinitialize to the unit matrix **
		
		This.XX = 1
		This.XY = 0
		This.XZ = 0
		This.XO = 0
	
		This.YX = 0
		This.YY = 1
		This.YZ = 0
		This.YO = 0
	
		This.ZX = 0
		This.ZY = 0
		This.ZZ = 1
		This.ZO = 0
		
	ENDPROC
	
	PROC Transformar(taV as Array, taTV as Array, tnVert as Integer)
	****************
    ** Transform nvert points from v into tv.  v contains the input
    ** coordinates in floating point.  Three successive entries in
	** the array constitute a point.  tv ends up holding the transformed
	** points as integers; three successive entries per point **

		LOCAL lnXX, lnXY, lnXZ, lnXO AS Double
		LOCAL lnYX, lnYY, lnYZ, lnYO AS Double
		LOCAL lnZX, lnZY, lnZZ, lnZO AS Double
		
		lnXX = This.XX
		lnXY = This.XY
		lnXZ = This.XZ
		lnXO = This.XO
		
		lnYX = This.YX
		lnYY = This.YY
		lnYZ = This.YZ
		lnYO = This.YO
		
		lnZX = This.ZX
		lnZY = This.ZY
		lnZZ = This.ZZ
		lnZO = This.ZO
		
		LOCAL lnXI AS Integer
		LOCAL lnX, lnY, lnZ AS Double
		
		FOR lnXI = (tnVert * 3 - 3) TO 0 STEP -3
		    lnX = taV[lnXI + 1]
		    lnY = taV[lnXI + 2]
		    lnZ = taV[lnXI + 3]
		    taTV[lnXI + 1] = int(lnX * lnXX + lnY * lnXY + lnZ * lnXZ + lnXO)
		    taTV[lnXI + 2] = int(lnX * lnYX + lnY * lnYY + lnZ * lnYZ + lnYO)
		    taTV[lnXI + 3] = int(lnX * lnZX + lnY * lnZY + lnZ * lnZZ + lnZO)
		ENDFOR
	ENDPROC
	
	PROC ToString
	*************
		LOCAL lcRETORNO AS String
		lcRETOR = "[" 	+ This.XO + "," + This.XX + "," + This.XY + "," + This.XZ + ";" + ;
						+ This.YO + "," + This.YX + "," + This.YY + "," + This.YZ + ";" + ;
						+ This.ZO + "," + This.ZX + "," + This.ZY + "," + This.ZZ + "]"
		RETURN ( lcRETORNO )
	ENDPROC
EndDefine