LOCAL ARRAY gaGrayColor[16]

CLEAR
lnESPACO = 0
FOR lnXI = 1 TO 16
	lnESPACO = lnESPACO + 2
	lnGrey = INT(170*(1-(((lnXI-1)/15)^2)))
	gaGrayColor[lnXI] = RGB(lnGrey, lnGrey, lnGrey)
*	_SCREEN.AddObject('SHAPE'+TRANSFORM(lnXI),'SHAPE')
	loOBJ = EVALUATE('_SCREEN.SHAPE'+TRANSFORM(lnXI))
	loOBJ.VISIBLE = .T.
	loOBJ.WIDTH = 50
	loOBJ.HEIGHT = 50
	loOBJ.LEFT = lnXI*50+lnESPACO
	loOBJ.BACKCOLOR = gaGrayColor[lnXI]
	?gaGrayColor[lnXI]
ENDFOR
