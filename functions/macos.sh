# enable-sudo-touchid
# A function which adds the TouchID PAM to the sudo auth list
# This is sometimes needed to be re-run after an update.
enable_sudo_touchid() {
    sudo sed -i -e '1s;^;auth       sufficient     pam_tid.so\n;' /etc/pam.d/sudo
}

# dock_item
# A function that generated a valid plist XML string to be appended to a
# `defaults write com.apple.dock persistent-apps -array` command`
#
# Example:
# defaults write com.apple.dock persistent-apps -array \
#     "$(dock_item /Applications/iTerm.app)" \
#     "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
#     "$(dock_item /Applications/Slack.app)" \
#     "$(dock_item /Applications/Google\ Chrome.app)" \
#     "$(dock_item /System/Applications/Utilities/Screenshot.app)"
dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

# I literally always forget how to flush my DNS settings on macOS (in large part
# because it changes every damn update).
dns_flush() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}