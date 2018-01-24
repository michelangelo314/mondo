#!/usr/bin/env bash

set -x 

buildDeps='ca-certificates cmake curl g++ libmicrohttpd-dev libssl-dev make'
apt-get update 
apt-get --no-install-recommends -y install $buildDeps 
rm -rf /var/lib/apt/lists/* 

echo "vm.nr_hugepages=128" >> /etc/sysctl.conf
sysctl --system

echo "*   soft    memlock 262144" >> /etc/security/limits.conf
echo "*   hard    memlock 262144" >> /etc/security/limits.conf
echo "session required pam_limits.so" >> /etc/pam.d/common-session
    
mkdir -p /usr/local/src/xmr-stak-cpu/build 
cd /usr/local/src/xmr-stak-cpu/ 
curl -sL https://github.com/fireice-uk/xmr-stak-cpu/archive/$XMR_STAK_CPU_VERSION.tar.gz | tar -xz --strip-components=1 
sed -i 's/constexpr double fDevDonationLevel.*/constexpr double fDevDonationLevel = 0.0;/' donate-level.h 
cd build 
cmake .. 
make -j$(nproc) 
cp bin/xmr-stak-cpu /usr/local/bin/ 

rm -r /usr/local/src/xmr-stak-cpu 
apt-get -qq --auto-remove purge $buildDep
