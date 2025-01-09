set -ex

pushd $HOME
# 换源
#rm -rf /etc/yum.repos.d/*.repo
#https://mirrors.tencent.com/repo/centos6_base.repo
#curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.tencent.com/repo/centos6_base.repo
#curl -o /etc/yum.repos.d/epel.repo http://mirrors.tencent.com/repo/epel-6.repo

mv /etc/yum.repos.d /etc/yum.repos.d-old
pushd /etc
git clone https://github.com/serverok/centos6-repo.git yum.repos.d
popd

yum update -y
yum groupinstall -y "Development Tools"
yum install -y automake autoconf bison gcc make ncurses zlib texinfo flex cmake zlib-devel openssl-devel git unzip ncurses-devel tree wget

wget -q https://gitee.com/sfantree/oss3/raw/c54aa3b2dae1d5143fe19f4ab3b9c8bb5f5f4aff/arm_tools/buildroot/buildroot-2012.08.tar.gz
tar zxf buildroot-2012.08.tar.gz
wget -q https://gitee.com/sfantree/oss3/raw/c54aa3b2dae1d5143fe19f4ab3b9c8bb5f5f4aff/arm_tools/buildroot/buildroot201208_arm920t.config
pushd buildroot-2012.08
cp ../buildroot201208_arm920t.config .config
make -j
tree arm920t
zip -q -r /tmp/arm920t.zip arm920t
popd
popd
