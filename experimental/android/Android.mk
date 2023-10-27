LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := Done
LOCAL_SRC_FILES := wrapper_android.c
LOCAL_LDLIBS    := -llog  # Add this line to link against the liblog library
#LOCAL_CFLAGS    := -fdeclspec

# Path to the directory containing libGo.so

# we import log by -llog
# this is what is bringing in libGo.so (locally)
LOCAL_LDLIBS := -llog -L$(LOCAL_PATH) -lGo

include $(BUILD_SHARED_LIBRARY)

# Copy libGo.so to the output directory
include $(CLEAR_VARS)
#LOCAL_MODULE := libGo
#LOCAL_SRC_FILES := libGo.so



# Define where to find libGo.a (assuming it's in the same directory)
#$(call import-module, .)






#LOCAL_SHARED_LIBRARIES := libGo
#LOCAL_CFLAGS := -fdeclspec
#LOCAL_OBJS_DIR := ./test
#include $(BUILD_SHARED_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_OBJS_DIR := ./test
#LOCAL_MODULE := libGo
#LOCAL_SRC_FILES := libGo.so  # Adjust this path to point to libGo.so
#include $(PREBUILT_SHARED_LIBRARY)
#LOCAL_OBJS_DIR := ./test



#LOCAL_SHARED_LIBRARIES := libGo
#LOCAL_CFLAGS := -fdeclspec
#LOCAL_OBJS_DIR := ./test
#include $(BUILD_SHARED_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_OBJS_DIR := ./test
#LOCAL_MODULE := libGo
#LOCAL_SRC_FILES := libGo.so  # Adjust this path to point to libGo.so
#include $(PREBUILT_SHARED_LIBRARY)
#LOCAL_OBJS_DIR := ./test


#LOCAL_PATH := $(call my-dir)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := Done
#LOCAL_SRC_FILES := wrapper.c
#LOCAL_SHARED_LIBRARIES := libGo
#LOCAL_CFLAGS := -fdeclspec
#include $(BUILD_SHARED_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := libGo
#LOCAL_SRC_FILES := libGo.so
#include $(PREBUILT_SHARED_LIBRARY)
#
## Set the INSTALL_PATH to specify where the library should be installed
#LOCAL_MODULE_PATH := $(TARGET_OUT)/lib
#include $(BUILD_PREBUILT)
