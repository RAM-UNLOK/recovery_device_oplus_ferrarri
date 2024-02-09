#
# This file is part of the OrangeFox Recovery Project
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# OrangeFox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# OrangeFox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# This software is released under GPL version 3 or any later version.
# See <http://www.gnu.org/licenses/>.
#
#  Please maintain this if you use this script or any part of it
#

FDEVICE="ferrarri"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
	export ALLOW_MISSING_DEPENDENCIES=true
	export TARGET_DEVICE_ALT="RED8ACL1,RMX3301,RMX3300,ferrarri"

	#Language
	export TW_DEFAULT_LANGUAGE="en"

	# Fox-specific flags
	export OF_USE_GREEN_LED=0
	export FOX_RESET_SETTINGS=1
	export FOX_ENABLE_APP_MANAGER=0

	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1

	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_ENABLE_LPTOOLS=1

#	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021

	export OF_DEFAULT_KEYMASTER_VERSION=4.1
	export OF_FIX_DECRYPTION_ON_DATA_MEDIA=1

	#Addons
	#export FOX_DELETE_INITD_ADDON=1 # !- Causes bootloops sometimes -!
	export FOX_DELETE_AROMAFM=1

	# LZMA compression - this is needed!
	export OF_USE_LZMA_COMPRESSION=1

	#Magiskboot
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

	# OTA & MIUI
	# vanilla build
	export FOX_VANILLA_BUILD=1
	export FOX_AB_DEVICE=1
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=0

	 # dispense with the entire OTA menu
	export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1

	# OTA for custom ROMs
	export OF_NO_MIUI_PATCH_WARNING=1

	# screen settings
	export OF_SCREEN_H=2400
	export OF_STATUS_H=118
	export OF_STATUS_INDENT_LEFT=165
	export OF_STATUS_INDENT_RIGHT=65
	export OF_NO_SPLASH_CHANGE=0
	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=0

    # -- add settings for R12.1 --
	export OF_QUICK_BACKUP_LIST="/boot;/data;/persist;"
	export FOX_DELETE_AROMAFM=1
	# -- end R12.1 settings --

	# Realme specific
	export FOX_BUILD_TYPE="STABLE"
	export FOX_VERSION=R12.1_A14
	export OF_MAINTAINER="OMKAR-PARTE"
	export FOX_VARIANT=RUI-AOSP

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
 	fi
fi