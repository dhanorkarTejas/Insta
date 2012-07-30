#!/bin/sh
#* AppleUserTemplate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Default Apple User Template preferences.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about editing existing users?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

HOMEPAGE="http://YOURINTRANET.com"

#+ // fix for PKG
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ Loop ${TARGET_DIR}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${TARGET_DIR}/System/Library/User\ Template`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  #+ com.apple.dock.plist (basic settings only).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" autohide -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" launchanim -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" mineffect -string "scale"
  #+ com.apple.ATS.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.ATS" ATSAutoActivation -string ATSAutoActivationDisable
  #+ com.apple.Console.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" ApplePersistenceIgnoreState YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" NSQuitAlwaysKeepsWindows -int 0
  #+ com.apple.CrashReporter.plist (hide from scared end users. maybe switch to basic mode...offers them the choice to delete prefs after second crash).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.CrashReporter" DialogType Server
 fi
done

exit 0