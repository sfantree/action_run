set -ex
pushd $HOME
#echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie main' > /etc/apt/sources.list
#echo 'deb [check-valid-until=no] http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf
echo "APT::Get::AllowUnauthenticated true;" >> /etc/apt/apt.conf

apt-get -qq update -y
apt-get -qq -y install wget curl vim cmake make gcc g++ automake pkg-config libc6-dev libunwind-dev openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev libncurses-dev lib32c-dev lib32z1 lib32stdc++6 dpkg-dev 
apt-get -qq -y install jq iproute2 iputils-ping file xz-utils

# install jdk11
mkdir -p /usr/lib/jvm
wget -q http://mirrors.huaweicloud.com/java/jdk/11.0.2+9/jdk-11.0.2_linux-x64_bin.tar.gz
tar zxf jdk-11.0.2_linux-x64_bin.tar.gz
rm -rf /usr/lib/jvm/jdk-11.0.2 && mv jdk-11.0.2 /usr/lib/jvm
export JAVA_HOME_11_X64=/usr/lib/jvm/jdk-11.0.2
export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2

# install android sdk
export ANDROID_ROOT=/usr/local/lib/android
export ANDROID_SDK_ROOT=${ANDROID_ROOT}/sdk
export SDKMANAGER=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager

mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip -q commandlinetools-linux-9477386_latest.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools
mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest

yes | $SDKMANAGER --licenses
$SDKMANAGER --list
# $SDKMANAGER --list --proxy=socks --proxy_host=127.0.0.1 --proxy_port=1080

git clone --depth 1 https://github.com/q215613905/TVBoxOS.git
pushd TVBoxOS
chmod +x gradlew
./gradlew assemblerelease --build-cache --parallel --daemon --warning-mode all
popd #TVBoxOS
popd #$home



