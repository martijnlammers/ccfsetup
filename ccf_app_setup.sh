#Hello world :)
cd ~

#Install necessities
sudo apt install nodejs
sudo apt install npm


#Create app structure
mkdir ~/app_building_dir
cd ~/app_building_dir
sudo npm install typescript
cd ~

#Sample app.json file
#Find more explanation here: https://microsoft.github.io/CCF/ccf-1.0.13/build_apps/js_app_bundle.html
cat <<EOT >> ~/app_building_dir/app.json
{
  "endpoints": {'
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
mkdir ~/app_building_dir/src
mkdir ~/app_building_dir/src/endpoints

cat <<EOT >> ~/app_building_dir/src/endpoints/all.ts
// Add all other used endpoints here.
export * from "./sample";
EOT
#Create sample endpoint only console logging the request body.
cat <<EOT >> ~/app_building_dir/src/endpoints/sample.ts
import * as ccfapp from 'ccf-app';
export function abc(request: ccfapp.Request): ccfapp.Response {
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












