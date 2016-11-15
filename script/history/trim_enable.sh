sudo cp /system/library/extensions/ioahcifamily.kext/contents/plugins/ioahciblockstorage.kext/contents/macos/ioahciblockstorage /system/library/extensions/ioahcifamily.kext/contents/plugins/ioahciblockstorage.kext/contents/macos/ioahciblockstorage.original

# for mountain lion 10.8.3 - 10.8.4
sudo perl -pi -e 's|(\x52\x6f\x74\x61\x74\x69\x6f\x6e\x61\x6c\x00{1,20})[^\x00]{9}(\x00{1,20}\x54)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /system/library/extensions/ioahcifamily.kext/contents/plugins/ioahciblockstorage.kext/contents/macos/ioahciblockstorage

# for Mountain Lion 10.8.1-10.8.2 and Lion 10.7.5
#sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x4D)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage

# for Mountain Lion 10.8.0 and Lion 10.7.4 BELOW
#sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00{1,20})[^\x00]{9}(\x00{1,20}\x51)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage

sudo touch /System/Library/Extensions/

# now reboot!
