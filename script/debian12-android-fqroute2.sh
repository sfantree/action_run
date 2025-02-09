set -ex
pushd $HOME
#echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie main' > /etc/apt/sources.list
#echo 'deb [check-valid-until=no] http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf
echo "APT::Get::AllowUnauthenticated true;" >> /etc/apt/apt.conf

apt-get -qq update -y
apt-get -qq -y install wget curl vim cmake make gcc g++ automake pkg-config libc6-dev libunwind-dev openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev libncurses-dev lib32c-dev lib32z1 lib32stdc++6 dpkg-dev 
apt-get -qq -y install jq iproute2 iputils-ping file xz-utils
# install jdk1.6
mkdir -p /usr/lib/jvm
wget https://mirrors.huaweicloud.com/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin
chmod +x jdk-6u45-linux-x64.bin
./jdk-6u45-linux-x64.bin >/dev/null
rm -rf /usr/lib/jvm/jdk1.6.0_45 && mv jdk1.6.0_45 /usr/lib/jvm
export JAVA_HOME_6_X64=/usr/lib/jvm/jdk1.6.0_45
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_45

# install ant 
wget -q https://archive.apache.org/dist/ant/binaries/apache-ant-1.8.0-bin.tar.gz
# wget -q https://mirrors.aliyun.com/apache/ant/binaries/apache-ant-1.9.16-bin.zip
tar zxf apache-ant-1.8.0-bin.tar.gz
export PATH="$HOME/apache-ant-1.8.0/bin:$PATH"

# install android sdk tool
mkdir android-sdk-linux
pushd android-sdk-linux

export ANDROID_SDK_HOME=`pwd`
export ANDROID_HOME=`pwd`
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

wget -q https://dl.google.com/android/repository/tools_r22.0.5-linux.zip
unzip -q tools_r22.0.5-linux.zip

wget -q https://dl.google.com/android/repository/platform-tools_r18.0.1-linux.zip
unzip -q platform-tools_r18.0.1-linux.zip

mkdir build-tools
pushd build-tools
wget -q https://dl.google.com/android/repository/build-tools_r18.0.1-linux.zip
unzip -q build-tools_r18.0.1-linux.zip
popd #build-tools

mkdir platforms
pushd platforms
wget -q https://dl.google.com/android/repository/android-18_r01.zip
unzip -q android-18_r01.zip
popd #platforms

android list

mkdir samples
pushd samples
wget -q https://dl.google.com/android/repository/samples-18_r01.zip
unzip -q samples-18_r01.zip 
pushd android-4.3/legacy/NotePad

android update project -p . -n $(basename $(pwd)) -s -t android-18
ant clean debug
cp bin/NotePad-debug.apk /tmp

popd NotePad
popd #samples
popd #android-sdk-linux
popd #$home



