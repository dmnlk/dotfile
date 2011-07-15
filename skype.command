#!/bin/sh

expect -c "
set timeout 5
spawn su Account
expect \"Password:\"
send \"password\r\"
expect \"bash-3.2$\"
send \"/Applications/Skype.app/Contents/MacOS/Skype\r\"
interact
"