ARCHS = armv7 arm64 arm64e
SDK = iPhoneOS12.1.2
FINALPACKAGE = 1
THEOS_DEVICE_IP = 10.0.0.10

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CuKey
CuKey_FILES = Tweak.xm

CuKey_FRAMEWORKS = UIKit CoreGraphics AVFoundation AudioToolbox
CuKey_EXTRA_FRAMEWORKS += Cephei
CuKey += -Wl,-segalign,4000
CuKey_CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error
CuKey_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += cukey
include $(THEOS_MAKE_PATH)/aggregate.mk
