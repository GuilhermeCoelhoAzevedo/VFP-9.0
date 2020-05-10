PUBLIC goGDIPlusXSamples
*!* Testing Source Control
LOCAL lcPath

lcPath = FULLPATH('')

SET PATH TO (lcPath) ADDITIVE

DO FORM samples

**goGDIPlusXSamples=NEWOBJECT("_main","gdipsamples")
**goGDIPlusXSamples.Show( IIF(_VFP.StartMode>=2,1,0) )

