DO 'C:\GDI\SYSTEM.APP'

WITH _Screen.System.Drawing
* Get an image file
LOCAL loBmp as xfcBitmap
loBmp = .Bitmap.FromFile(GETPICT())
* Create a Gfx object that will allow us to make the transformation
LOCAL loGfx as xfcGraphics
loGfx = .Graphics.FromImage(loBmp)
LOCAL lnWidth, lnHeight
lnWidth = loBmp.Width 
lnHeight = loBmp.Height 
 
* Create GraphicsPath object.
LOCAL loClipPath as xfcGraphicsPath
loClipPath = .Drawing2D.GraphicsPath.New()
 
* An Ellipse shape
loClipPath.AddEllipse(0, 0, lnWidth, lnHeight)
 
 
* Set clipping region to path.
* CombineMode enumeration
* http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.combinemode.aspx
* CombineMode.Xor - Two clipping regions are combined by taking only the areas 
* enclosed by one or the other region, but not both. 
loGfx.SetClip(loClipPath, _Screen.System.Drawing.Drawing2D.CombineMode.Xor)
* Fill rectangle to demonstrate clipping region.
loGfx.FillRectangle( .Brushes.White, 0, 0, loBmp.Width, loBmp.Height)
* Save the image to the disk and show
loBmp.Save("Clipped.png", _Screen.system.Drawing.Imaging.ImageFormat.Png)
RUN /n Explorer.Exe Clipped.png
ENDWITH

RETURN

WITH _Screen.System.Drawing
* Get an image file
LOCAL loBmp as xfcBitmap
loBmp = .Bitmap.FromFile(GETPICT())
* Create a Gfx object that will allow us to make the transformation
LOCAL loGfx as xfcGraphics
loGfx = .Graphics.FromImage(loBmp)
LOCAL lnWidth, lnHeight
lnWidth = loBmp.Width 
lnHeight = loBmp.Height 
 
* Create GraphicsPath object.
LOCAL loClipPath as xfcGraphicsPath
loClipPath = .Drawing2D.GraphicsPath.New()
 
 
* A Doughnut slice shape
loClipPath.AddEllipse(0, 0, lnWidth, lnHeight * 2)
loClipPath.AddEllipse(lnWidth / 4, lnHeight / 2, lnWidth/2, lnHeight * 4)
 
 
* Set clipping region to path.
* CombineMode enumeration
* http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.combinemode.aspx
* CombineMode.Xor - Two clipping regions are combined by taking only the areas 
* enclosed by one or the other region, but not both. 
loGfx.SetClip(loClipPath, ;
_Screen.System.Drawing.Drawing2D.CombineMode.Xor)
* Fill rectangle to demonstrate clipping region.
loGfx.FillRectangle( .Brushes.White, 0, 0, loBmp.Width, loBmp.Height)
* Save the image to the disk and show
loBmp.Save("Clipped2.Jpg", "image/jpeg")
RUN /n Explorer.Exe Clipped2.Jpg
ENDWITH

WITH _Screen.System.Drawing
* Get an image file
LOCAL loBmp as xfcBitmap
loBmp = .Bitmap.FromFile(GETPICT())
* Create a Gfx object that will allow us to make the transformation
LOCAL loGfx as xfcGraphics
loGfx = .Graphics.FromImage(loBmp)
LOCAL lnWidth, lnHeight
lnWidth = loBmp.Width 
lnHeight = loBmp.Height 
 
* Create GraphicsPath object.
LOCAL loClipPath as xfcGraphicsPath
loClipPath = .Drawing2D.GraphicsPath.New()
 
 
 
* Source for the star drawing
* http://www.java2s.com/Code/VB/2D/GraphicsPathDrawwithFillModeWinding.htm
LOCAL lnRadius, lnPi, lnRadian72, n, lnEdges
lnRadius = lnHeight / 2
lnPi = 3.141592
lnEdges = 5
lnRadian72 = (lnPi * 4.0 ) / lnEdges
LOCAL laPoints(lnEdges)
FOR n = 1 TO lnEdges
laPoints(n) = .Point.New(;
+ lnRadius * SIN( n * lnRadian72 ) + lnRadius , ;
- lnRadius * COS( n * lnRadian72 ) + lnRadius )
ENDFOR
loClipPath.AddPolygon(@laPoints)
* Set the Clip Mode to Winding
* ClipMode enumeration
*http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.fillmode.aspx
loClipPath.FillMode = _Screen.System.Drawing.Drawing2D.FillMode.Winding 
 
* Set clipping region to path.
* CombineMode enumeration
* http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.combinemode.aspx
* CombineMode.Xor - Two clipping regions are combined by taking only the areas 
* enclosed by one or the other region, but not both. 
loGfx.SetClip(loClipPath, ;
_Screen.System.Drawing.Drawing2D.CombineMode.Xor)
* Fill rectangle to demonstrate clipping region.
loGfx.FillRectangle( .Brushes.White, 0, 0, loBmp.Width, loBmp.Height)
* Save the image to the disk and show
loBmp.Save("Clipped3.Jpg", "image/jpeg")
RUN /n Explorer.Exe Clipped3.Jpg
ENDWITH
