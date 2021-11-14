cat <<EOT >> ~/start.ini

# Configuration for your enclave image and type. If you're not running SGX supported hardware
# you would need to change these to 'libjs_generic.enclave.so.signed' and 'virtual' respectively
enclave-file = ./libjs_generic.enclave.so.signed
enclave-type = release

# Standard consensus algorithm used, can also make use of btf
consensus = cft

# Node and RPC addresses <localip><port>
rpc-address = 10.0.0.18:443
node-address = 10.0.0.18:6600

# Your public address, the one you usually access your vm with. <publicip><thesame port as rpc port>
public-rpc-address = 20.108.20.207:443

# Locations where you will generate the ledger dir, cert and pid file
ledger-dir = ./legder/
node-cert-file = ./certificates/node_cert.pem
node-pid-file = ./cchost.pid

# Your DNS, if you have one.
san = "dNSName:partical.uksouth.cloudapp.azure.com"

[start]

#Network-cert location
network-cert-file = ./certificates/network_cert.pem

# Initial registered member (Unactivated!)
# You can add more member-info fields to increase your initial members,
# you do need new certificates for each new one though
member-info = "./certificates/Martijn_cert.pem,./certificates/Martijn_enc_pubk.pem"

#Paths to your constitution
constitution=[/home/mar/partical/constitution/actions.js,/home/mar/partical/constitution/validate.js,/home/mar//partical/constitution/resolve.js,/home/mar//partical/constitution/apply.js]
EOT
