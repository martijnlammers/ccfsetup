#!/bin/bash
# Shell to automatically deploy template app/network
# Important to note that you still need to reconfigure some settings as thing like 
# your DNS arent being configured generically
PATH_HERE=$(pwd)
bash ${PATH_HERE}/ccfsetup/ccf_install.sh
bash ${PATH_HERE}/ccfsetup/ccf_app_setup.sh
bash ${PATH_HERE}/ccfsetup/ccf_app_config.sh
bash ${PATH_HERE}/ccfsetup/ccf_node_configs.sh
cd ${PATH_HERE}/app_building_dir/
npm install 
npm run build

cd ${PATH_HERE}/network/certificates
${PATH_HERE}/ccfrelease/bin/keygenerator.sh \
--name Member \
--gen-enc-key
