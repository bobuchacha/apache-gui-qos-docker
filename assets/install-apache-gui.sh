#! /bin/bash
AG_PATH="/usr/local/apachegui"
AG_URL="https://excellmedia.dl.sourceforge.net/project/apachegui/1.12-Linux-Solaris-Mac/ApacheGUI-1.12.0.tar.gz"
AG_ARCHIVE=ApacheGUI-1.12.0.tar.gz

if [ ! -d $AG_PATH ] 
then
    echo Installing ApacheGUI

    mkdir $AG_PATH
    cd /usr/local/apachegui
    wget wget --show-progress -q --progress=bar:force -O $AG_ARCHIVE $AG_URL 2>&1 
    tar xvzf $AG_ARCHIVE
    rm -f $AG_ARCHIVE
fi

if [ ! -n `which java` ]; then
    echo Installing Java
    apt update && apt install -y openjdk-11-jre-headless
fi

echo Running Apache
$AG_PATH/ApacheGUI/tomcat/bin/startup.sh