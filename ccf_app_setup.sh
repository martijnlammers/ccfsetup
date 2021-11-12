#Hello world :)
cd ~

#Install necessities
sudo apt install nodejs
sudo apt install npm

#Create app structure
mkdir ./app_building_dir


#Sample app.json file
#Find more explanation here: https://microsoft.github.io/CCF/ccf-1.0.13/build_apps/js_app_bundle.html
touch ./app_building_dir/app.json
echo'"{"'>> ./app_building_dir/app.json
echo'  "endpoints": {' >> ./app_building_dir/app.json
echo'    "/sample": {'>> ./app_building_dir/app.json
echo'      "post": {'>> ./app_building_dir/app.json
echo'        "js_module": "endpoints/sample.js",'>> ./app_building_dir/app.json
echo'        "js_function": "outputrequest",'>> ./app_building_dir/app.json
echo'        "forwarding_required": "never",'>> ./app_building_dir/app.json
echo'        "authn_policies": [],'>> ./app_building_dir/app.json
echo'        "mode": "readwrite",'>> ./app_building_dir/app.json
echo'        "openapi": {'>> ./app_building_dir/app.json
echo'        }'>> ./app_building_dir/app.json
echo'      }'>> ./app_building_dir/app.json
echo'    }'>> ./app_building_dir/app.json
echo'  }'>> ./app_building_dir/app.json
echo'}'>> ./app_building_dir/app.json

mkdir ./app_building_dir/src
mkdir ./app_building_dir/src/endpoints

touch ./app_building_dir/src/endpoints/all.ts
echo'// Add all other used endpoints here.'>> ./app_building_dir/src/endpoints/all.ts
echo'export * from "./sample";'>> ./app_building_dir/src/endpoints/all.ts

#Create sample endpoint only console logging the request body.
touch ./app_building_dir/src/endpoints/sample.ts
echo"import * as ccfapp from 'ccf-app';">> ./app_building_dir/src/endpoints/sample.ts
echo'export function abc(request: ccfapp.Request): ccfapp.Response {'>> ./app_building_dir/src/endpoints/sample.ts
echo'    // access request details'>> ./app_building_dir/src/endpoints/sample.ts
echo'    const data = request.body.json();'>> ./app_building_dir/src/endpoints/sample.ts
echo'    // process request'>> ./app_building_dir/src/endpoints/sample.ts
echo'    console.log("received body:");'>> ./app_building_dir/src/endpoints/sample.ts
echo'    console.log(data);'>> ./app_building_dir/src/endpoints/sample.ts
echo''>> ./app_building_dir/src/endpoints/sample.ts
echo'    // return response'>> ./app_building_dir/src/endpoints/sample.ts
echo'    return {'>> ./app_building_dir/src/endpoints/sample.ts
echo'        body: {"response":"Hello world!"},'>> ./app_building_dir/src/endpoints/sample.ts
echo'        statusCode: 200'>> ./app_building_dir/src/endpoints/sample.ts
echo'    }'>> ./app_building_dir/src/endpoints/sample.ts
echo'}'>> ./app_building_dir/src/endpoints/sample.ts




