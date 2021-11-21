#!/bin/bash
DNS="no addr given"
while [ "$1" != "" ]; do
    case $1 in 
        -h|--host)
            DNS=$2
            shift
            ;;
    esac
    shift
done

PATH_HERE=$(pwd) 
STATE_DIG=$(curl \
https://${DNS}/gov/ack/update_state_digest \
-X POST \
--cacert ${PATH_HERE}/network/certificates/network_cert.pem \
--key ${PATH_HERE}/network/certificates/Member_privk.pem \
--cert ${PATH_HERE}/network/certificates/Member_cert.pem)

./ccfrelease/bin/scurl.sh \
https://${DNS}/gov/ack \
--cacert ${PATH_HERE}/network/certificates/network_cert.pem \
--signing-key ${PATH_HERE}/network/certificates/Member_privk.pem \
--signing-cert ${PATH_HERE}/network/certificates/Member_cert.pem \
--header "Content-Type: application/json" \
--data-binary ${STATE_DIG}

python3 -m ccf.proposal_generator set_js_app ./app_building_dir/dist/
PROPID=$(scurl.sh https://${DNS}/gov/proposals\
 --cacert ${PATH_HERE}/network/certificates/network_cert.pem \
--signing-key ${PATH_HERE}/network/certificates/Member_privk.pem \
--signing-cert ${PATH_HERE}/network/certificates/Member_cert.pem \
--data-binary @set_js_app_proposal.json \
-H "content-type: application/json")
PROPID=$(PROPID | jq -r '.proposal_id')

python3 -m ccf.proposal_generator transition_service_to_open
PROPID=$(scurl.sh https://${DNS}/\
gov/proposals --cacert ${PATH_HERE}/network/certificates/network_cert.pem \
--signing-key ~/network/certificates/Member_privk.pem \
--signing-cert ~/network/certificates/Member_cert.pem \
--data-binary @transition_service_to_open_proposal.json \
-H "content-type: application/json" | jq -r '.proposal_id')

scurl.sh https://${DNS}/gov/proposals\
/${PROPID}/ballots \
--cacert ~/network/certificates/network_cert.pem \
--signing-key ~/network/certificates/Member_privk.pem \
--signing-cert ~/network/certificates/Member_cert.pem \
--data-binary @transition_service_to_open_vote_for.json \
-H "content-type: application/json"
