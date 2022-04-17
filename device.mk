#
# Copyright (C) 2020 ComicoTeam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Api
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_TARGET_VNDK_VERSION := 30

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Update engine
PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# ANT+
PRODUCT_PACKAGES += \
    AntHalService

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS670KS.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS670KS.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes_ZS670KS.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_volumes_ZS670KS.xml

# Bluetooth
PRODUCT_PACKAGES += \
    BluetoothQti

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl.recovery \
    bootctrl.kona.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

# ZenParts
PRODUCT_PACKAGES += \
    ZenParts

# Charger images
PRODUCT_PACKAGES += \
    animation.txt \
    font_charger.png

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    gralloc.kona \
    memtrack.kona \
    libion \
    libtinyxml2 \
    libtinyalsa \
    libqdMetaData \
    libdisplayconfig.vendor

# FM
PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    libhidltransport \
    libhwbinder

PRODUCT_BOOT_JARS += android.hidl.manager-V1.0-java

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/fts_ts.idc:system/usr/idc/fts_ts.idc \
    $(LOCAL_PATH)/keychars/fts_ts.kcm:system/usr/keychars/fts_ts.kcm \
    $(LOCAL_PATH)/keylayout/fts_ts.kl:system/usr/keylayout/fts_ts.kl \
    $(LOCAL_PATH)/keylayout/Generic_zf7.kl:system/usr/keylayout/Generic_zf7.kl \
    $(LOCAL_PATH)/keylayout/goodixfp.kl:system/usr/keylayout/goodixfp.kl \
    $(LOCAL_PATH)/keylayout/i-rocks_Bluetooth_Keyboard.kl:system/usr/keylayout/i-rocks_Bluetooth_Keyboard.kl

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    librs_jni

# Netutils
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0 \
    libandroid_net

# Prebuilt
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/asus/I002D/prebuilt/product,product) \
    $(call find-copy-subdir-files,*,device/asus/I002D/prebuilt/system,system) \
    $(call find-copy-subdir-files,*,device/asus/I002D/prebuilt/system_ext,system_ext)

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Systemhelper
PRODUCT_PACKAGES += \
    vendor.qti.hardware.systemhelper@1.0

# Telephony
PRODUCT_PACKAGES += \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    tcmiface \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_PACKAGES += \
    vndk_package

PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Vibrator
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/excluded-input-devices.xml:system/etc/excluded-input-devices.xml

# Wifi
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libnl \
    TetheringOverlay \
    WifiOverlay

PRODUCT_BOOT_JARS += \
    WfdCommon

# Additional tools
PRODUCT_PACKAGES += \
    dump.exfat \
    fsck.exfat \
    exfatlabel \
    mkfs.exfat \
    tune.exfat \
    e2fsck \
    fsck.exfat \
    lsof \
    mke2fs \
    mkfs.exfat \
    openvpn \
    tune2fs \
    mkfs.ntfs \
    mount.ntfs \
    fsck.ntfs \
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor \
    vim \
    vncflinger \
    vncpasswd \
    SystemWebView

# Inherit from vendor blobs
$(call inherit-product, vendor/asus/I002D/I002D-vendor.mk)
