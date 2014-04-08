#!/bin/bash

# Postflight script to install Maya and Mudbox 2014 and point it to a licence server

# Author  : r.purves@arts.ac.uk
# Version : 1.0 - 8-4-2014 - Initial Version

# This assumes all the installers supplied by Autodesk have been installed to the root directory

# Set up variables here

SERVERADDRESS="x.x.x.x"
MAYA-SERIAL="xxx-xxxxxxxx"
MUDBOX-SERIAL="xxx-xxxxxxxx"

# Install the Maya 2014 metapackage

installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Maya2014.mpkg -target /

# Install the adlmgr package

installer -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/AdLM_standalone.mpkg -target /

# Install all the optional installs in case any didn't work the first time.

installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/ADC_docs8.0.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/AutodeskBackburner2014.mpkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/AutodeskDirectConnect8.0.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/Composite2014.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/MatchMover2014.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/Maya_quicktime_components.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/autodesk.backburner.monitor-2014.0_439_i386.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/autodesk.dlcommon.libraries_2014.2-2043.i386.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/autodesk.webentry-1.0-603.i386.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/backburner-2014.0_1635_i386.pkg -target /
installer -verboseR -pkg /Install\ Maya\ 2014.app/Contents/Resources/Maya/Additional\ Items/mentalrayForMaya2014.0.pkg -target /

# That should be it for Maya, let's install Mudbox 2014.

installer -verboseR -pkg /Install\ Mudbox\ 2014.app/Contents/Resources/Mudbox/Mudbox2014.mpkg -target /

# Now install mentalray satellite and the Suite Exclusives

installer -verboseR -pkg /Install\ mentalraysatellite\ 3.11.1.app/Contents/Resources/mrsat/mrsat3.11.1.mpkg -target /
installer -verboseR -pkg /Install\ Suite\ Exclusives\ 2014.app/Contents/Resources/Turtle/MayaTurtlePlugIn2014.0.pkg -target /

# Create the Maya2014.lic and Mudbox2014.lic files in /private/var/flexlm
# These point to the licence server at 194.80.31.12

mkdir /private/var/flexlm
touch /private/var/flexlm/Maya2014.lic
touch /private/var/flexlm/Mudbox2014.lic

echo "SERVER $SERVERADDRESS 0" > /private/var/flexlm/Maya2014.lic
echo "USE_SERVER" >> /private/var/flexlm/Maya2014.lic
echo "SERVER $SERVERADDRESS 0" > /private/var/flexlm/Mudbox2014.lic
echo "USE_SERVER" >> /private/var/flexlm/Mudbox2014.lic

chmod 744 /private/var/flexlm/Maya2014.lic
chmod 744 /private/var/flexlm/Mudbox2014.lic

# Create the License.env file in /Applications/Autodesk/maya2014/

touch /Applications/Autodesk/maya2014/License.env

echo "MAYA_LICENSE=unlimited" > /Applications/Autodesk/maya2014/License.env
echo "MAYA_LICENSE_METHOD=network" >> /Applications/Autodesk/maya2014/License.env

chmod 744 /Applications/Autodesk/maya2014/License.env

# Generate Mudbox licence file in /Applications/Autodesk/Mudbox2014/

touch /Applications/Autodesk/Mudbox2014/License.env

echo "MUDBOX_LICENSE=unlimited" > /Applications/Autodesk/Mudbox2014/License.env
echo "MUDBOX_LICENSE_METHOD=network" >> /Applications/Autodesk/Mudbox2014/License.env

# Install the Maya 2014 serial number.

adlmreg -i N 657F1 793F1 2014.0.0.F $MAYA-SERIAL /Library/Application\ Support/Autodesk/Adlm/PIT/2014/MayaConfig.pit

# Install the Mudbox 2014 serial number

adlmreg -i N 498F1 793F1 2014.0.0.F $MUDBOX-SERIAL /Library/Application\ Support/Autodesk/Adlm/PIT/2014/MudboxConfig.pit

# Disable intro screens

/usr/bin/defaults write /Library/Preferences/com.autodesk.MC3Framework MC3Enabled -int 0

# Clean up on aisle three!

rm -rf /Install\ Maya\ 2014.app/
rm -rf /Install\ Mudbox\ 2014.app/
rm -rf /Install\ mentalraysatellite\ 3.11.1.app/
rm -rf /Install\ Suite\ Exclusives\ 2014.app/