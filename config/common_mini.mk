# Inherit common CM stuff
$(call inherit-product, vendor/cm/config/common.mk)

PRODUCT_SIZE := mini

# Inherit default sounds
$(call inherit-product, vendor/cm/config/sound_config.mk)
