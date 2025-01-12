set -ex
pushd $HOME
echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie main' > /etc/apt/sources.list
echo 'deb [check-valid-until=no] http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie-updates main' >> /etc/apt/sources.list
echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf
echo "APT::Get::AllowUnauthenticated true;" >> /etc/apt/apt.conf
apt-get update -y
apt-get install vim cmake make gcc g++ automake openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev -y
wget http://download.qt.io/archive/qt/4.8/4.8.4/qt-everywhere-opensource-src-4.8.4.tar.gz
tar zxf qt-everywhere-opensource-src-4.8.4.tar.gz
git clone --depth 1 https://github.com/raspberrypi/tools.git
export PATH=$PATH:$HOME/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
pushd qt-everywhere-opensource-src-4.8.4
sed -i 's/arm-none-linux-gnueabi-/arm-linux-gnueabihf-/g' mkspecs/qws/linux-arm-gnueabi-g++/qmake.conf
./configure -prefix `pwd`/arm-qt4 -opensource -confirm-license -release -shared -embedded arm -xplatform qws/linux-arm-gnueabi-g++ -fast -optimized-qmake -no-pch -qt-libjpeg -qt-zlib -qt-libpng -qt-freetype -little-endian -host-little-endian -no-qt3support -no-libtiff -no-libmng -no-opengl -no-mmx -no-sse -no-sse2 -no-3dnow -no-openssl -no-webkit -no-qvfb -no-phonon -no-nis -no-cups -no-glib -nomake tools -nomake docs -qt-sql-sqlite -plugin-sql-sqlite
make -j 
make install
zip -q -r /tmp/arm-qt4.zip arm-qt4
popd
popd
