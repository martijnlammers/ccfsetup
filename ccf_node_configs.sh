sudo apt install net-tools
cd ~
mkdir ~/network
mkdir ~/network/configurations
mkdir ~/network/certificates

PATH_HERE=$(pwd)
PUB_IP=$(curl ifconfig.co)
PRIV_IP=$(hostname -i)

cat <<EOT >> ~/network/configurations/start_node.ini

# Configuration for your enclave image and type. If you're not running SGX supported hardware
# you would need to change these to 'libjs_generic.virtual.so' and 'virtual' respectively
enclave-file = ${PATH_HERE}/ccfrelease/lib/libjs_generic.enclave.so.signed
enclave-type = release

# Standard consensus algorithm used, can also make use of btf
consensus = cft

# Node and RPC addresses <localip><port>
rpc-address = ${PRIV_IP}:443
node-address = ${PRIV_IP}:6600

# Your public address, the one you usually access your vm with. <publicip><thesame port as rpc port>
public-rpc-address = ${PUB_IP}:443

# Locations where you will generate the ledger dir, cert and pid file
ledger-dir = ${PATH_HERE}/network/legder/
node-cert-file = ${PATH_HERE}/network/certificates/node_cert.pem
node-pid-file = ${PATH_HERE}/network/cchost.pid

# Your DNS, if you have one.
san = "dNSName:partical.uksouth.cloudapp.azure.com"

[start]

#Network-cert location
network-cert-file = ${PATH_HERE}/network/certificates/network_cert.pem

# Initial registered member (Unactivated!)
# You can add more member-info fields to increase your initial members,
# you do need new certificates for each new one though
member-info = "${PATH_HERE}/network/certificates/Member_cert.pem,${PATH_HERE}/network/certificates/Member_enc_pubk.pem"

#Paths to your constitution
constitution=[${PATH_HERE}/ccfrelease/bin/actions.js,${PATH_HERE}/ccfrelease/bin/validate.js,${PATH_HERE}/ccfrelease/bin/resolve.js,${PATH_HERE}/ccfrelease/bin/apply.js]
EOT

cat <<EOT >> ~/network/configurations/join_node.ini

#Node configuration
enclave-file = ${PATH_HERE}/ccfrelease/lib/libjs_generic.enclave.so.signed
enclave-type = release
consensus = cft
rpc-address = ${PRIV_IP}:8888
node-address =${PRIV_IP}:6600
public-rpc-address = ${PUB_IP}:8888
[join]

#Thesame network certificate the previous node generates
network-cert-file = ${PATH_HERE}/network/certificates/network_cert.pem

##The address of the starting node you want to join
target-rpc-address = ${PRIV_IP}:443

EOT
cat <<EOT >> ~/network/configurations/recover_node.ini


EOT
