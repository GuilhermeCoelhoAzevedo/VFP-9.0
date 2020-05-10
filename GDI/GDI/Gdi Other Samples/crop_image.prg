* FROM: http://weblogs.foxite.com/vfpimaging/archive/2008/05/11/6074.aspx

LOCAL lcSource, lnWidth, lnHeight
lcSource = GETPICT()
IF EMPTY(lcSource)
   RETURN
ENDIF

DO LOCFILE("System.App")

WITH _SCREEN.System.Drawing
 
* Load Image to GdiplusX
LOCAL loBmp AS xfcBitmap
loBmp = .Bitmap.FromFile(lcSource)
lnWidth = loBmp.Width
lnHeight = loBmp.Height

* Crop Image
LOCAL loCropped AS xfcBitmap

* Crop Top-Left
LOCAL loRect as xfcRectangle
loRect = .Rectangle.New(0, 0, lnWidth / 2, lnHeight /2)
loCropped = loBmp.Clone(loRect)
loCropped.Save("c:\Crop-TopLeft.png", .Imaging.ImageFormat.Png)
RUN /N explorer.EXE c:\Crop-TopLeft.png
 
* Crop Bottom-Right
* Now, the Rectangle region will be created inside the Clone function
loCropped = loBmp.Clone(.Rectangle.New(lnWidth / 2, lnHeight /2, lnWidth /2, lnHeight /2))
loCropped.Save("c:\Crop-BottomRight.png", .Imaging.ImageFormat.Png)
RUN /N explorer.EXE c:\Crop-bottomright.png
 
* Crop Center
loCropped = loBmp.Clone(.Rectangle.New(lnWidth / 4, lnHeight /4, lnWidth /2, lnHeight /2))
loCropped.Save("c:\Crop-Center.png", .Imaging.ImageFormat.Png)
RUN /N explorer.EXE c:\Crop-Center.png
 
ENDWITH
RETURN
