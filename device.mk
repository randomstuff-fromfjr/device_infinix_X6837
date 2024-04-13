#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=$(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=$(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script \
    checkpoint_gc

# Allow userspace reboots
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# Dalvik configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Boot Control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service
    bootctrl.default 

# Charger
PRODUCT_PACKAGES += \
    libsuspend

# Dex
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI
    
# FastbootD
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint (Permissions)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    libhidltransport

# Light
PRODUCT_PACKAGES += \
    android.hardware.lights-service.X6837

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    com.android.nfc_extras \
    Tag \
    SecureElement

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6789 \
    init.aee.rc \
    init.cgroup.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.modem.rc \
    init.mt6789.rc \
    init.mt6789.usb.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.sensor_2_0.rc \
    init_connectivity.rc \
    multi_init.rc 

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# VNDK
PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_EXTRA_VNDK_VERSIONS := 33

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Inherit the proprietary files
$(call inherit-product, vendor/infinix/X6837/X6837-vendor.mk)
