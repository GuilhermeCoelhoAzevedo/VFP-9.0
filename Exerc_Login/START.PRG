SET DATE BRITISH
SET CENTURY ON
SET DECIMALS TO 8
_SCREEN.Caption = 'Olimpo'

DO form frmlogin to lnLOGIN

IF lnLOGIN<=0
	* n�o fez login
	RETURN
ENDIF

* exibir menu do sistema
DO form menu_opcoes
READ events

RETURN


