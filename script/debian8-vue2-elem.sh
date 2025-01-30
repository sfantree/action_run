set -ex
pushd $HOME
echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie main' > /etc/apt/sources.list
echo 'deb [check-valid-until=no] http://archive.debian.org/debian-security/ jessie/updates main' >> /etc/apt/sources.list
echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf
echo "APT::Get::AllowUnauthenticated true;" >> /etc/apt/apt.conf
apt-get -qq update -y
apt-get -qq install wget curl vim cmake make gcc g++ automake openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev -y
wget https://nodejs.org/download/release/v6.17.1/node-v6.17.1-linux-x64.tar.gz
wget https://registry.npmmirror.com/-/binary/node/latest-v6.x/node-v6.17.1-linux-x64.tar.gz
tar zxvf node-v6.17.1-linux-x64.tar.gz
export PATH=$PATH:$HOME/node-v6.17.1-linux-x64/bin
git clone --depth 1  https://github.com/bailicangdu/vue2-elm.git
pushd vue2-elm
# npm config set registry https://mirrors.huaweicloud.com/repository/npm
# https://npmmirror.com/mirrors/node-sass
# npm config set sass_binary_site=https://mirrors.huaweicloud.com/node-sass
npm install node-sass@4.14.1 --unsafe-perm=true
npm install vue-loader@13.3.0 --save-dev --unsafe-perm=true
npm install --unsafe-perm=true
# remove 
sed -i '35,39d' build/webpack.prod.conf.js
npm run build
zip -q -r /tmp/elm.zip elm
popd
popd



