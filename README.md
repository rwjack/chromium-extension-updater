# chromium-extension-updater
Downloads latest versions of your ungoogled-chromium extensions.

Designed for [ungoogled-chromium](https://github.com/Eloston/ungoogled-chromium).

## Configuration:

Set Names IDs for your extensions inside the script:

Eg.

`EXTENSIONS["extensionName"]+="abcabcEXTENSIONIDabcabc"`

The extension name can be whatever you like, it is just the filename for writing the extension on disk.

The extension ID can be obtained from the last part of the URL, by visiting the google store page of your desired extension.

## Tips:

Extensions that have newer versions than the currently installed ones will be placed in the `to-update` folder.

FYI: Developer mode needs to be enabled in order for extensions to be installed in ungoogled-chromium.
This option can be enabled in the top right corner of the extensions page. From there you can just drag-and-drop your `.crx` file into chromium.

Once you are done installing new extensions from the `to-update` folder, just delete it. Currently installed versions are kept in the `current-version` folder, 
and are used as a reference for the script, as to what to place inside the `to-update` folder.
