# ms9132-drm-linux

This repository holds the source for kernel modules required to operate
USB video adapters using [Macro Silicon MS9132](http://en.macrosilicon.com/info.asp?base_id=2&third_id=72)
chip such as generic USB 3.0 to HDMI adapters. As the time of writing,
files are extracted from [MS91xx_Linux_Drm_SourceCode_V3.0.1.3.zip](http://www.macrosilicon.com:9080/download/USBDisplay/Linux/SourceCode/MS91xx_Linux_Drm_SourceCode_V3.0.1.3.zip).

## Notes

Although this is listed as MS91xx driver on their website, the code seems to
only check for MS9132 USB id, though it does check for MS912x chips. Try
[the unofficial driver](https://github.com/rhgndf/ms912x) reverse-engineered
from Windows if you are looking for MS912x driver or this does not work.
