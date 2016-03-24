# Inherit common CM stuff
$(call inherit-product, vendor/cm/config/common.mk)

# Inherit default sounds
$(call inherit-product, vendor/cm/config/sound_config.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/cm/config/telephony.mk)
