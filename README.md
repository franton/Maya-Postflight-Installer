Maya Postflight Installer
-------------------------

This is meant as postflight install script. What i've ended up doing is the following:

1) Create a pkg installer that places Autodesk's Maya, Mudbox and related installers on the root directory.
2) Customise the script in this repo with your licence server address
3) Customise your serial numbers into this script
4) Package the script in the postflight for deployment.

This should be tested extensively before wrapping it all into the install pkg to make sure all the tricky licencing stuff is working ok.

Pay special attention to lines 80 and 84 where the actual licencing occurs. There are sections that look like this:

"adlmreg -i N 657F1 793F1 ..."

The 65xxx is the Autodesk product code for the software. The 79xxx is the Autodesk suite code. Make sure these are correct or the licencing will fail!

The information to make this script possible came from:
http://nerdlogger.com/2013/08/15/installing-autodesk-entertainment-creation-suite-ultimate-maya-2014-for-osx-from-command-line/
