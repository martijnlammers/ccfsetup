# Shell to automatically deploy template app/network
bash ~/ccfsetup/ccf_install.sh
bash ~/ccfsetup/ccf_app_setup.sh
bash ~/ccfsetup/ccf_app_config.sh
bash ~/ccfsetup/ccf_node_configs.sh
cd ~/app_building_dir/
npm install 
npm run build

cd ~/network/certificates
./../../ccfrelease/bin/keygenerator.sh \
--name Member \
--gen-enc-key
