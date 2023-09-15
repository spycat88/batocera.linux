################################################################################
#
# r8125
#
################################################################################
# Version: 9.011.01-1
R8125_VERSION = d5cd96a875d7b59448f4916c077b60c69a9c843e
R8125_SITE = $(call github,awesometic,realtek-r8125-dkms,$(R8125_VERSION))
R8125_LICENSE = GPL-2.0
R8125_LICENSE_FILES = LICENSE
R8125_MODULE_SUBDIRS = src

R8125_MODULE_MAKE_OPTS = CONFIG_R8125=m \
    USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN -Wno-error"

define R8125_MAKE_SUBDIR
    (cd $(@D)/src; ln -s . r8125)
endef

define R8125_BLACKLIST_R8169
    cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/network/r8125/blacklist-r8169.conf \
        $(TARGET_DIR)/etc/modprobe.d/
endef

R8125_PRE_CONFIGURE_HOOKS += R8125_MAKE_SUBDIR
R8125_POST_INSTALL_TARGET_HOOKS += R8125_BLACKLIST_R8169

$(eval $(kernel-module))
$(eval $(generic-package))
