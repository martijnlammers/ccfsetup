#!/bin/sh
PATH_HERE=$(pwd)
sudo rm -r ${PATH_HERE}/network/cchost.pid
sudo rm -r ${PATH_HERE}/network/ledgers/ledger/
sudo rm -r ${PATH_HERE}/network/snapshots/snapshot
sudo rm -r ${PATH_HERE}/network/certificates/network_cert.pem
sudo rm -r ${PATH_HERE}/network/certificates/node_cert.pem
sudo ${PATH_HERE}/ccfrelease/bin/cchost --config=${PATH_HERE}/network/configurations/start_node.ini

