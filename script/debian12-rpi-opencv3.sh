set -ex
pushd $HOME
apt-get update -qy
apt-get install wget curl vim cmake make gcc g++ automake openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev -qy
git clone --depth 1 https://github.com/rvagg/rpi-newer-crosstools.git
export PATH=$PATH:$(pwd)/rpi-newer-crosstools/x64-gcc-10.3.0-glibc-2.28/arm-rpi-linux-gnueabihf/bin
wget https://github.com/opencv/opencv/archive/refs/tags/3.4.16.zip
unzip 3.4.16.zip
pushd opencv-3.4.16
pushd platforms/linux
sed -i 's/arm-linux-gnueabi/arm-rpi-linux-gnueabihf/g' arm-gnueabi.toolchain.cmake
popd
mkdir -p platforms/linux/build
pushd platforms/linux/build
cmake -DCMAKE_TOOLCHAIN_FILE=../arm-gnueabi.toolchain.cmake -DCMAKE_C_COMPILER=arm-rpi-linux-gnueabihf-gcc -DCMAKE_CXX_COMPILER=arm-rpi-linux-gnueabihf-g++  ../../..  || true
cmake -DCMAKE_TOOLCHAIN_FILE=../arm-gnueabi.toolchain.cmake -DCMAKE_C_COMPILER=arm-rpi-linux-gnueabihf-gcc -DCMAKE_CXX_COMPILER=arm-rpi-linux-gnueabihf-g++  ../../..  || true
make -j`nproc`
DESTDIR=`pwd`/_install make install
zip -q -r /tmp/rpi-opencv3.zip _install
popd
popd
