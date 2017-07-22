 #!/bin/bash
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root if you install regular user
   please use the ./install.sh command " 1>&2
   exit 1
fi

# ...

slackpkg update

echo -e "\e[1;33m Remember to selct ok and press Enter\e[0m"


sleep 5


slackpkg install-new

echo -e "\e[1;33m Remember to selct ok and press Enter\e[0m"


sleep 5

slackpkg upgrade-all

echo -e "\e[1;33m Going to upgrade multilib \e[0m"
sleep 5


##UPGRADE MULTI-LIB
rsync -r -a -v  --delete --progress --stats rsync://bear.alienbase.nl/mirrors/people/alien/multilib/14.2  /var/cache/multilib/
cd /var/cache/multilib/14.2
upgradepkg  --reinstall --install-new *.t?z
cd /var/cache/multilib/14.2/slackware64-compat32
upgradepkg --install-new *?/*.t?z



















 
