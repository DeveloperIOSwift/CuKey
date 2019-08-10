ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CuKey
CuKey_FILES = $(wildcard *.mm)
CuKey_INSTALL_PATH = /Library/PreferenceBundles
CuKey_FRAMEWORKS = UIKit MessageUI CoreGraphics AudioToolbox AVFoundation
CuKey_PRIVATE_FRAMEWORKS = Preferences
CuKey_EXTRA_FRAMEWORKS += CepheiPrefs
CuKey_LIBRARIES = colorpicker
CuKey_CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CuKey.plist$(ECHO_END)
