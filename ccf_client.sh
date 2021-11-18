mkdir ~/client
sudo apt install node-typescript
cat <<EOT >> ~/client/sample.ts
//File system access is necessary to read the certificates.
import fs = require('fs');
import https = require('https');


//Request option schema. Can be expanded with more options.
interface RequestOptions {
    hostname: string,
    port: number,
    path: string,
    method: string,
    ca?: Buffer,
    key?: Buffer,
    cert?: Buffer
    header: object,
}

const options: RequestOptions = {
    hostname: 'particaldemo1.uksouth.cloudapp.azure.com',
    port: 443,
    path: '/app/sample',
    method: 'POST',
    ca: fs.readFileSync('./certs/network_cert.pem'),
    // key?: Buffer,
    // cert?: Buffer,
    header: {
        'Content-Type': 'application/json'
    }
}

const data: Buffer = JSON.parse('{"someField":"someValue"}');



function send_https_req(options: RequestOptions, json: Buffer): Promise<string> {
    function promiseHandler(thenFunc: (value: string) => void, catchFunc: (error_name: Error) => void) {
        const request = https.request(options, (response) => {
            response.setEncoding('utf8');
            response.on('data', (resdata) => {

                //Process the response
                thenFunc(resdata);
            });
        });

        // Write data to request body
        request.write(json);
        request.end();
    }

    const p: Promise<string> = new Promise(promiseHandler);
    return p;
}


//You can make a custom function out of this. It has to be async to easily use the promise in the function.
async function output_response(options: RequestOptions, json: Buffer) {

    //Sending requests isn't guarrenteed, hence the promise/trycatch
    try {
        const response = await send_https_req(options, json);
        console.log(response);

    } catch(error){
        console.log(error);
    }  
}

output_response(options, data);

EOT
