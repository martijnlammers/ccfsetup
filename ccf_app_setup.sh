#!/bin/bash
cd ~
PATH_HERE=$(pwd)
#Install necessities
sudo apt install nodejs
sudo apt install npm


#Create app structure
mkdir ${PATH_HERE}/app_building_dir
cd ${PATH_HERE}/app_building_dir
sudo npm install typescript
cd ${PATH_HERE}

#Sample app.json file
#Find more explanation here: https://microsoft.github.io/CCF/ccf-1.0.13/build_apps/js_app_bundle.html
sudo rm -r ${PATH_HERE}/app_building_dir/app.json
cat <<EOT >> ${PATH_HERE}/app_building_dir/app.json
{
  "endpoints": {
    "/sample": {
      "post": {
        "js_module": "endpoints/sample.js",
        "js_function": "outputrequest",
        "forwarding_required": "never",
        "authn_policies": [],
        "mode": "readwrite",
        "openapi": {
        }
      }
    }
  }
}
EOT
mkdir ${PATH_HERE}/app_building_dir/src
mkdir ${PATH_HERE}/app_building_dir/src/endpoints
sudo rm -r ${PATH_HERE}/app_building_dir/src/endpoints/all.ts
cat <<EOT >> ${PATH_HERE}/app_building_dir/src/endpoints/all.ts
// Add all other used endpoints here.
export * from "./sample";
EOT
#Create sample endpoint only console logging the request body.
cat <<EOT >> ${PATH_HERE}/app_building_dir/src/endpoints/sample.ts
import * as ccf from '@microsoft/ccf-app';
export function outputrequest(request: ccf.Request): ccf.Response {
    // access request details
    const data = request.body.json();
    // process request
    console.log("received body:");
    console.log(data);

    // return response
    return {
        body: {"response":"Hello world!"},
        statusCode: 200
    }
}
EOT












