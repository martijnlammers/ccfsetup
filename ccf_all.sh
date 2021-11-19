# Shell to automatically deploy template app/network
# Important to note that you still need to reconfigure some settings as thing like 
# your DNS cannot be configured generically.
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
