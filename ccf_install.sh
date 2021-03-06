#Setup the path to your working directory
#PATH_HERE=$(dirname "$(realpath -s "$0")")
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

#Declare what version of CCF you want to use
CCF_VERSION=${ccfversion}

#Get CCF
wget https://github.com/microsoft/CCF/releases/download/ccf-${CCF_VERSION}/ccf_${CCF_VERSION}_amd64.deb

##Install OpenEnclave
#Setup APT repositories
echo 'deb [arch=amd64] https://download.01.org/intel-sgx/sgx_repo/ubuntu focal main' | sudo tee /etc/apt/sources.list.d/intel-sgx.list
wget -qO - https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | sudo apt-key add -

echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-10 main" | sudo tee /etc/apt/sources.list.d/llvm-toolchain-focal-10.list
wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" | sudo tee /etc/apt/sources.list.d/msprod.list
wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo apt update
sudo apt -y install clang-10 libssl-dev gdb libsgx-enclave-common libsgx-quote-ex libprotobuf17 libsgx-dcap-ql libsgx-dcap-ql-dev az-dcap-client open-enclave

##Install the CCF
sudo apt-get update 
sudo apt install ./ccf_${CCF_VERSION}_amd64.deb 
sudo apt install python3.8-venv
sudo apt install python3-pip
sudo pip3 install ccf
sudo apt install jq

##Get repo 
git clone https://github.com/microsoft/CCF.git

##Copy and rename directories
sudo cp -r /opt/ccf/ ./ccfrelease/
sudo mv ./CCF ./ccfrepository

#Check if it installed properly
sudo /opt/ccf/bin/cchost --version

#Cleanup
sudo rm -r ccf_1.0.13_amd64*


