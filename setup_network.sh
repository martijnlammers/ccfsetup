#!/bin/sh
sudo rm -r ./network/cchost.pid
sudo rm -r ./network/ledgers/ledger/
sudo rm -r ./network/snapshots/snapshot
sudo rm -r ./network/certificates/network_cert.pem
sudo rm -r ./network/certificates/node_cert.pem
sudo ./ccfrelease/bin/cchost --config=./network/configurations/start_node.ini

