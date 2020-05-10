LOCAL Componentes as String
**************************
*** Define cores de caixas e o tamanho das mesmas.
FUNCTION Inicio_Programa

LPARAMETERS "toFORM"

toFORM.TXTNAScimento.Value = DATE()

FOR EACH Componentes IN toFORM.Objects
	IF Componentes.BaseClass = "Textbox"
		IF Componentes.Comment = "*"
			Componentes.backColor = RGB(254,251,129)
		ENDIF
		COMPONENTES.Width = Componentes.maxlength * FONTMETRIC(6, Componentes.fontName, Componentes.fontSize)
	ENDIF
ENDFOR		

ENDFUNC
****************************