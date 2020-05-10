*LPARAMETERS tcSourceFile, tcDestFile


 tcSourcefile = GETPICT()
 tcDestFile = FORCEEXT(tcSourceFile, "Bmp")

DO LOCFILE("System.App")

LOCAL loBmp AS xfcBitmap
LOCAL loGfx AS xfcGraphics
LOCAL loBorderClr AS xfcColor
LOCAL loRect AS xfcRectangle
LOCAL loAttr AS xfcImageAttributes
LOCAL loColorMap AS xfcColorMap
LOCAL loDestBmp as xfcBitmap
 
WITH _SCREEN.SYSTEM.Drawing
	loColorMap = .Imaging.ColorMap.New()
	loAttr = .Imaging.ImageAttributes.New()
	loBmp = .Bitmap.FromFile(tcSourceFile)
	loGfx = .Graphics.FromImage(loBmp)

	loDestBmp = .Bitmap.New(loBmp.Width, loBmp.Height, .Imaging.PixelFormat.Format24bppRGB)
	loDestGfx = .Graphics.FromImage(loDestBmp)

	* Clear the new bitmap
	loDestGfx.Clear(.Color.White)

	* By Craig Boyd - For enhancing the smoothless and quality
	loDestGfx.SmoothingMode     = .Drawing2D.SmoothingMode.HighQuality 
	loDestGfx.InterpolationMode = .Drawing2D.InterpolationMode.HighQualityBicubic
	loDestGfx.PixelOffsetMode   = .Drawing2D.PixelOffsetMode.HighQuality

	loRect = loBmp.GetBounds()

	* Get the top left pixel color, presuming this color is the BackGround color to become transparent
	* For our BMP case, this will become PURE WHITE - RGB(255,255,255)
	* that becomes transparent when used in VFP objects
	loBorderClr = loBmp.GetPixel(0,0)

	* Convert original Whites RGB(255,255,255) to OFF WHITE - RGB(254,254,254)
	* this way, the whites will remain without the need of a mask
	loColorMap.OldColor = .Color.White
	loColorMap.NewColor = .Color.FromARGB(255,254,254,254)

	loAttr.SetRemapTable(loColorMap)
	loDestGfx.DrawImage(loBmp, loRect, loRect, .GraphicsUnit.Pixel, loAttr)

	* Next step, convert the borders to pure White, RGB(255,255,255) that will become transparent in buttons
	loColorMap.OldColor = loBorderClr
	loColorMap.NewColor = .Color.White
	loAttr.SetRemapTable(loColorMap)

	loDestGfx.DrawImage(loDestBmp, loRect, loRect, .GraphicsUnit.Pixel, loAttr)

	loDestBmp.Save(tcDestFile, .Imaging.ImageFormat.Bmp)
ENDWITH
