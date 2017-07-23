# WineWoW-SlackBuild
~~~
This program will be install in /usr/local/lib
and /usr/local/lib64
you must edit your /etc/ld.so.conf
/lib64
/usr/lib
/usr/lib64
/usr/local/lib
/usr/local/lib64
/usr/x86_64-slackware-linux/lib64
/usr/lib64/seamonkey
/usr/lib/seamonkey
~~~
must add this to your /etc/slackpkg/blacklist

befor install multilib

~~~
# This one will blacklist all SBo packages:
[0-9]+_SBo
[0-9]+alien
[0-9]+compat32
~~~
more info on this build

https://wiki.winehq.org/Building_Wine#Shared_WoW64

this is Experimental and up to you to learn Slackware multilib
get it here
my multi lib script 

build 32 and 64 bit wine 
I use it for many 64 bit games and 32 bit games.

You must have a full alien bob multi lib set up.

you must run winecfg after you install it.
Play onlinux will make 32 and 64 bit virtual drives for it.

when making the 64 bit windows install drive it will say 32 

untill you install the 64 bit program.

this will git pull the wine repo save it to your Slackbuild 

/tmp/SBo/ program-name-version
 
if you want to do as I do  

git clone https://github.com/Drakeo/WineWoW-SlackBuild.git

cd WineWoW-SlackBuild

git clone git clone git://source.winehq.org/git/wine.git 

cd wine

git checkout wine-x.x.x your version. 

cd WineWoW-SlackBuild

now edit your  wineWOW64.SlackBuild.sh


VERSION=${VERSION:-2.13} to another version VERSION=${VERSION:-x.x.x}

for building all in edit the GTAG=wine-2.13 to the version you want to checkout. 

################ WARNING ############

I build the Nvidia  driver and the ati driver per Pat's instructions.

Not the SlackBuild way.  If you do to.

you will need to uninstall those drivers and rebuild them so they can link to multilib.

anytime mesa or the xorg is updated you must uninstall it first.


there are 3 scripts the example script I used since slackware 12.0 to keep my system up

then added multilib at 13.0 .

after runing the AlienBob-Multib as root . you will need a reboot.

have fun. 



