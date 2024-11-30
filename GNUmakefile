ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
  ifeq ($(GNUSTEP_MAKEFILES),)
    $(warning )
    $(warning Unable to obtain GNUSTEP_MAKEFILES setting from gnustep-config!)
    $(warning Perhaps gnustep-make is not properly installed,)
    $(warning so gnustep-config is not in your PATH.)
    $(warning )
    $(warning Your PATH is currently $(PATH))
    $(warning )
  endif
endif
ifeq ($(GNUSTEP_MAKEFILES),)
 $(error You need to set GNUSTEP_MAKEFILES before compiling!)
endif

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = Translate

Translate_HEADERS += \
	TranFace.h \
	TranModule.h \
	Speech.h

Translate_OBJC_FILES += \
	main.m \
	TranFace.m \
	TranModule.m \
	Speech.m

Translate_APPLICATION_ICON = Translate.tif
Translate_RESOURCE_FILES = Translate.tif

include $(GNUSTEP_MAKEFILES)/application.make


