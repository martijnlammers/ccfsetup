#!/bin/bash
DNS="no addr"
PATH_HERE=$(pwd)
while [ "$1" != "" ]; do
    case $1 in 
        -h|--host)
            DNS=$2
            shift
            ;;
    esac
    shift
done


sudo apt install net-tools
cd ${PATH_HERE}
mkdir ${PATH_HERE}/network
mkdir ${PATH_HERE}/network/configurations
mkdir ${PATH_HERE}/network/certificates
mkdir ${PATH_HERE}/network/ledgers
mkdir ${PATH_HERE}/network/snapshots

PUB_IP=$(curl ifconfig.co)
PRIV_IP=$(hostname -i)


cat <<EOT >> ${PATH_HERE}/network/configurations/start_node.ini

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
ledger-dir = ${PATH_HERE}/network/ledgers/ledger
snapshot-dir = ${PATH_HERE}/network/snapshots/snapshot
node-cert-file = ${PATH_HERE}/network/certificates/node_cert.pem
node-pid-file = ${PATH_HERE}/network/cchost.pid

# Your DNS, if you have one.
san = ${DNS}

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

cat <<EOT >> ${PATH_HERE}/network/configurations/join_node.ini

#Node configuration
enclave-file = ${PATH_HERE}/ccfrelease/lib/libjs_generic.enclave.so.signed
enclave-type = release
consensus = cft
rpc-address = ${PRIV_IP}:8000
node-address =${PRIV_IP}:6700
ledger-dir = ${PATH_HERE}/network/ledgers/ledger1
snapshot-dir = ${PATH_HERE}/network/snapshots/snapshots1
node-cert-file = ${PATH_HERE}/network/certificates/node_cert1.pem
public-rpc-address = ${PUB_IP}:8000
san = ${DNS}
[join]

#Thesame network certificate the previous node generates
network-cert-file = ${PATH_HERE}/network/certificates/network_cert.pem

##The address of the starting node you want to join
target-rpc-address = ${PRIV_IP}:443

EOT
cat <<EOT >> ${PATH_HERE}/network/configurations/recover_node.ini
enclave-file = ${PATH_HERE}/ccfrelease/lib/libjs_generic.enclave.so.signed
enclave-type = release
consensus = cft
rpc-address = ${PRIV_IP}:443
node-address = ${PRIV_IP}:6600
public-rpc-address = ${PUB_IP}:443
ledger-dir = ${PATH_HERE}/network/ledgers/ledger
snapshot-dir = ${PATH_HERE}/network/snapshots/snapshots0
node-cert-file = ${PATH_HERE}/network/certificates/node_cert0.pem
node-pid-file = ${PATH_HERE}/network/cchost.pid
san = ${DNS}

[recover]
network-cert-file = ${PATH_HERE}/network/certificates/network_cert0.pem


EOT
