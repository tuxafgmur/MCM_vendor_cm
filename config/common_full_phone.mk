# Inherit common CM stuff
$(call inherit-product, vendor/cm/config/common_full.mk)

# Inherit default sounds
$(call inherit-product, vendor/cm/config/sound_config.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/dictionaries

$(call inherit-product, vendor/cm/config/telephony.mk)
