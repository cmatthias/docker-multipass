#!/bin/sh
set -xe

MEM=4096M
CPUS=4
DISK=50G

echo "Creating and launching instance"
multipass launch --name primary -c $CPUS -m $MEM -d $DISK --cloud-init cloud-init.yml 21.10

echo "Mounting $HOME into remote instance: primary"
multipass mount ${HOME} primary:/Users/${USER}

PRIMARY_INSTANCE=$(multipass info primary | grep IPv4 | awk '{split($0,a," "); print a[2]}')

echo "Success! in your bash profile add this:"
echo "export DOCKER_HOST=tcp://$PRIMARY_INSTANCE:2375"
