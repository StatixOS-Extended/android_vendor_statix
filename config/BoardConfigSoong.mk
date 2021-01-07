SOONG_CONFIG_NAMESPACES += statixGlobalVars
SOONG_CONFIG_statixGlobalVars += \
    needs_camera_boottime \
    additional_gralloc_10_usage_bits \
    bootloader_message_offset \
    target_health_charging_control_charging_path \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_process_sdk_version_override \
    target_surfaceflinger_udfps_lib \
    uses_oplus_camera \
    uses_nothing_camera

SOONG_CONFIG_NAMESPACES += statixQcomVars
SOONG_CONFIG_statixQcomVars += \
    should_wait_for_qsee \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd \
    uses_qti_camera_device

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_statixQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_statixQcomVars_should_wait_for_qsee := $(TARGET_KEYMASTER_WAIT_FOR_QSEE)
SOONG_CONFIG_statixQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_statixQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)
SOONG_CONFIG_statixQcomVars_uses_qti_camera_device := $(TARGET_USES_QTI_CAMERA_DEVICE)

# Set default values
BOOTLOADER_MESSAGE_OFFSET ?= 0
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib

# Soong value variables
SOONG_CONFIG_statixGlobalVars_needs_camera_boottime := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)
SOONG_CONFIG_statixGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_statixGlobalVars_bootloader_message_offset := $(BOOTLOADER_MESSAGE_OFFSET)
SOONG_CONFIG_statixGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_statixGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_statixGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
SOONG_CONFIG_statixGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_statixGlobalVars_uses_oplus_camera := $(TARGET_USES_OPLUS_CAMERA)
SOONG_CONFIG_statixGlobalVars_uses_nothing_camera := $(TARGET_USES_NOTHING_CAMERA)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_statixGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_statixQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_statixQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

ifneq ($(TARGET_USE_QTI_BT_STACK),true)
PRODUCT_SOONG_NAMESPACES += packages/apps/Bluetooth
endif #TARGET_USE_QTI_BT_STACK

# Gestures
define add-gesturevar-if-exist
$(eval vn := $(shell echo $(1) | tr '[:upper:]' '[:lower:]'))
$(if $($(1)), \
  $(eval SOONG_CONFIG_statixGestureVars += $(vn)) \
  $(eval SOONG_CONFIG_statixGestureVars_$(vn) := $(patsubst "%",%,$($(1)))) \
)
endef

SOONG_CONFIG_NAMESPACES += statixGestureVars
SOONG_CONFIG_statixGestureVars :=
GESTURE_SOONG_VARS := \
    TARGET_GESTURES_NODE \
    TARGET_TAP_TO_WAKE_NODE \
    TARGET_TAP_TO_WAKE_EVENT_NODE \
    TARGET_DRAW_V_NODE \
    TARGET_DRAW_INVERSE_V_NODE \
    TARGET_DRAW_O_NODE \
    TARGET_DRAW_M_NODE \
    TARGET_DRAW_W_NODE \
    TARGET_DRAW_ARROW_LEFT_NODE \
    TARGET_DRAW_ARROW_RIGHT_NODE \
    TARGET_ONE_FINGER_SWIPE_UP_NODE \
    TARGET_ONE_FINGER_SWIPE_RIGHT_NODE \
    TARGET_ONE_FINGER_SWIPE_DOWN_NODE \
    TARGET_ONE_FINGER_SWIPE_LEFT_NODE \
    TARGET_TWO_FINGER_SWIPE_NODE \
    TARGET_DRAW_S_NODE \
    TARGET_SINGLE_TAP_TO_WAKE_NODE

$(foreach v,$(GESTURE_SOONG_VARS),$(eval $(call add-gesturevar-if-exist,$(v))))
