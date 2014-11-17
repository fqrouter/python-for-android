LOCAL_PATH:=$(call my-dir)

include $(CLEAR_VARS)

# This is the target being built.
LOCAL_MODULE := python_launcher
LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE

# All of the source files that we will compile.
LOCAL_SRC_FILES := python_launcher.c

LOCAL_SHARED_LIBRARIES := libdl

include $(BUILD_EXECUTABLE)
