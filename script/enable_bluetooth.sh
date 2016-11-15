#!/bin/bash
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 1
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist
