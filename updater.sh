#!/bin/bash

declare -A EXTENSIONS
EXTENSIONS["xbrowsersync"]+="lcbjdhceifofjlpecfpeimnnphbcjgnc"
EXTENSIONS["ublockOrigin"]+="cjpalhdlnbpafiamejdnhcphjbkeiagm"
EXTENSIONS["stylus"]+="clngdbkpkpeebahjckkjfobafhncgmne"
EXTENSIONS["vimium"]+="dbepggeogbaibhgnhhndojpepiihcmeb"
EXTENSIONS["redditRes"]+="kbmfpngjjgdllneeigpgjifpgocmfgmb"
EXTENSIONS["clearUrls"]+="lckanjgmijmafbedllaakclkaicjfmnk" 
EXTENSIONS["cookieAutodelete"]+="fhcgjolkccmbidfldomjliifgaodjagh"
EXTENSIONS["idcBoutCookies"]+="fihnjjcciajhdojfnbdddfaoknhalnja"
EXTENSIONS["violentMonkey"]+="jinjaccalgkegednnccohejagnlnfdag"


EXTENSION_DIR="$HOME/Documents/chromium-extensions"
if [ ! -d "$EXTENSION_DIR" ]; then
    mkdir -p "$EXTENSION_DIR"
fi

CURRENT_VERSION="$EXTENSION_DIR/current-version"
if [ ! -d "$CURRENT_VERSION" ]; then
    mkdir "$CURRENT_VERSION"
fi

TO_UPDATE="$EXTENSION_DIR/to-update"
if [ ! -d "$TO_UPDATE" ]; then
    mkdir "$TO_UPDATE"
fi

TEMP="$EXTENSION_DIR/temp"
if [ ! -d "$TEMP" ]; then
    mkdir "$TEMP"
fi


DL_URL_A="https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion="
#DL_VERSION
DL_URL_B="&x=id%3D"
#DL_EXTENSION_ID
DL_URL_C="%26installsource%3Dondemand%26uc"

VERSION=$(chromium --product-version)
# Grab only first 4 characters of version
VERSION=${VERSION::4}

# Download latest extensions into temp folder
for extension in "${!EXTENSIONS[@]}"; do
    DL_URL=$DL_URL_A$VERSION$DL_URL_B${EXTENSIONS[${extension}]}$DL_URL_C
    curl -sL "$DL_URL" -o $TEMP/$extension.crx
done

# Move extensions into to-update folder, if they are different than current version
for extension in "${!EXTENSIONS[@]}"; do
    if [ ! -f $CURRENT_VERSION/$extension.crx ]; then
        # First run, you installed your extensions and they are the latest version
        # Or if you added a new extension to the script
        cp $TEMP/$extension.crx $TO_UPDATE/
        mv $TEMP/$extension.crx $CURRENT_VERSION/
    else
        # Extension already exists, if different, just use newer version 
        if ! diff $TEMP/$extension.crx $CURRENT_VERSION/$extension.crx &>/dev/null; then
            cp $TEMP/$extension.crx $TO_UPDATE/
            mv $TEMP/$extension.crx $CURRENT_VERSION/
        else
            rm -f $TEMP/$extension.crx
        fi
    fi
done

rmdir $TEMP

echo -e "\n[+] Done fetching latest extensions!\n"
