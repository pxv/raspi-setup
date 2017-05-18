#!/bin/bash

# Run this when the pi has been connected to USB and has booted

# handle there being a previous raspberrypi.local in known hosts
ssh-keygen -R raspberrypi.local

keyfile=""
keyfile1=personal_rsa.pub
if [ -f ~/.ssh/$keyfile1 ]
then
  echo "Adding $keyfile1..."
  scp ~/.ssh/$keyfile1 pi@raspberrypi.local:~/
  keyfile=$keyfile1
fi

keyfile2=raspi-iot_rsa.pub
if [ -f ~/.ssh/$keyfile2 ]
then
  echo "Adding $keyfile2..."
  scp ~/.ssh/$keyfile2 pi@raspberrypi.local:~/
  keyfile=$keyfile2
fi

echo "Setting up .ssh directory..."
cmdstring="rm -rf ~/.ssh;"
cmdstring="${cmdstring} mkdir ~/.ssh;chmod 700 ~/.ssh;"
cmdstring="${cmdstring} cat *.pub > ~/.ssh/authorized_keys;"
cmdstring="${cmdstring} chmod 700 ~/.ssh/authorized_keys;"
cmdstring="${cmdstring} rm ~/$keyfile1 ~/$keyfile2 2> /dev/null"

ssh pi@raspberrypi.local $cmdstring

# save the last private key that was found
privatekey=$(echo $keyfile | cut -f 1 -d '.')

echo "Changing pi's password from the default..."
ssh -i ~/.ssh/$privatekey pi@raspberrypi.local "passwd"


echo "Setting vnc geometry in ~/.vnc/config"

cmdstring="mkdir ~/.vnc;echo '-geometry 1027x768' > ~/.vnc/config"
ssh -i ~/.ssh/$privatekey pi@raspberrypi.local $cmdstring
