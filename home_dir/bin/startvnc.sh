# set the firewall to only listen to localhost
sudo sh -c 'echo "localhost=True" > /etc/vnc/config.d/common.custom'

# start the vnc service
sudo systemctl start vncserver-x11-serviced.service
