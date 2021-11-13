#Declare what version of CCF you want to use
ccfversion=1.0.13
while [ "$1" != "" ]; do
    case $1 in 
        -v|--version)
            ccfversion=$2
            shift
            ;;
    esac
    shift
done

export CCF_VERSION=$ccfversion
##Package.json
cat <<EOT >> ~/app_building_dir/tsconfig.json
{
  "private": true,
  "scripts": {
    "build": "del-cli -f dist/ && rollup --config && cp app.json dist/"
  },
  "type": "module",
  "dependencies": {
    "@microsoft/ccf-app": "~${CCF_VERSION}",
    "js-base64": "^3.5.2",
    "jsrsasign": "^10.0.4",
    "jsrsasign-util": "^1.0.2",
    "jwt-decode": "^3.0.0",
    "lodash-es": "^4.17.15",
    "protobufjs": "^6.10.1"
  },
  "devDependencies": {
    "@rollup/plugin-commonjs": "^17.1.0",
    "@rollup/plugin-node-resolve": "^11.2.0",
    "@rollup/plugin-typescript": "^8.2.0",
    "@types/jsrsasign": "^8.0.7",
    "@types/lodash-es": "^4.17.3",
    "del-cli": "^3.0.1",
    "http-server": "^0.13.0",
    "rollup": "^2.41.0",
    "tslib": "^2.0.1",
    "typescript": "4.2.4"
  }
}
EOT



#Typescript to Javascript conversion options
cat <<EOT >> ~/app_building_dir/tsconfig.json
{
  "compilerOptions": {
    "lib": [
      "ES2020"
    ],
    "target": "ES2020",
    "module": "ES2020",
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "noImplicitAny": false,
    "removeComments": true,
    "preserveConstEnums": true,
    "sourceMap": false
  },
  "include": [
    "src/**/*"
  ]
}
EOT

##Rollup config, for removing duplicate modules.
cat <<EOT >> ~/app_building_dir/rollup.config.js
import { nodeResolve } from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import typescript from "@rollup/plugin-typescript";

export default {
  input: "src/endpoints/all.ts",
  output: {
    dir: "dist/src",
    format: "es",
    preserveModules: true,
    preserveModulesRoot: "src",
  },
  plugins: [nodeResolve(), typescript(), commonjs()],
};
EOT
