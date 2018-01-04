#!/bin/bash

set -o errexit

args=''

#check distribution
distribution=$(lsb_release -sc)

if [ "$distribution" = "trusty" ] || [ "$distribution" = "xenial" ]
then
   args+="--skip-tags not-for-$distribution"
else
   echo "Only trusty & xenial are currently supported. Exiting."
   exit -1
fi

##get level
cislevel=$1
if [ "$cislevel" != "level1" ]
then
   echo "Only CIS Level1 is currently supported. Exiting."
   exit -1
else
   args+=" --skip-tags level2"
fi

#TODO: worstation/server - 2.2.4 && 3.7


install_dependencies () {

sudo apt-get update
sudo apt-get -y install python-pip git python-dev
sudo -H pip install --upgrade pip setuptools
sudo -H pip install ansible markupsafe

local_co=""
if [ -z "$IP" ]; then
  IP="127.0.0.1"
  local_co="-c local"
  sudo apt-get install -y aptitude
fi

}

install_playbook () {
mkdir -p ansible/roles-ubuntu/roles
cd ansible/roles-ubuntu
if [ ! -e "roles/cis" ]; then
  git clone https://github.com/bentzys/cis-ubuntu-ansible.git roles/cis
fi

if [ ! -e "playbook.yml" ]; then
  cat >> playbook.yml << 'EOF'
---
- hosts: all
  roles:
    - cis
EOF
fi

hash_vars=`md5sum roles/cis/vars/main.yml | awk '{ print $1 }'`
if [ "$hash_vars" == "ebc1b1c57552ba806018f7231b33f30d" ]; then
  cp roles/cis/tests/desktop_defaults.yml roles/cis/vars/main.yml
fi
}

run_playbook () {
ansible-playbook -b -u $USER $local_co -i "$IP," playbook.yml $args
}

cd /tmp
install_dependencies
install_playbook
run_playbook | tee /tmp/cis.log


#yes | sudo -H pip remove ansible markupsafe
#sudo apt-get remove -y python-pip git python-dev
#sudo apt-get -y autoremove

