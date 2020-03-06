#!/bin/bash
nginx_install_path="/usr/local/nginx"
echo "安装路径:$nginx_install_path"
sleep 1
nginx_package_name=$1
echo "安装包:$nginx_package_name"

if [[ ! $nginx_package_name =~ .*\.tar\.gz ]] 
then
	echo 安装文件必须为tar.gz压缩文件
	exit 1
fi

if ! test -e $nginx_package_name
then
	echo "文件$nginx_package_name 不存在"
	exit 1
fi

nginx_install_temp_dir=${nginx_package_name%%.t*}
if test -d ./$nginx_install_temp_dir
then
	echo "清理临时安装文件夹"
	sudo rm -rf ./$nginx_install_temp_dir/*
else
	mkdir $nginx_install_temp_dir
fi

echo "解压安装包..."
sleep 1
tar -zxvf ./$nginx_package_name -C ./$nginx_install_temp_dir --strip-components 1

echo "检查安装目录"
if test -d $nginx_install_path 
then 
	echo "清理安装目录..."
	sudo rm -rf $nginx_install_path/*
else
	echo "创建安装目录..."
	sudo mkdir $nginx_install_path 
fi

echo "安装nginx需要有一下3个包，如果您的Linux中含有这些，可以输入N跳过"
echo "1. openssl libssl-dev"
echo "2. libpcre3 libpcre3-dev"
echo "3. zlib1g-dev"
echo -e "输入N跳过安装（这是使用的是Debian系列的apt-get安装方式,其他Linux发行版请自行安装）："
read skip

case $skip in 
N|n)
	;;
*)
	echo `dpkg -l | grep zlib`
	echo `sudo apt-get install openssl libssl-dev`
	echo `sudo apt-get install libpcre3 libpcre3-dev`
	echo `sudo apt-get install zlib1g-dev`
	;;
esac
#配置
make_nginx(){
sudo ./configure --prefix=/usr/local/nginx
echo "配置完成, 1s后开始编译"
sleep 1
sudo make
echo "编译完成, 1s后开始安装"
sleep 1
sudo make install
echo "安装完成,删除临时目录"
}
cd ./$nginx_install_temp_dir
make_nginx
cd ../
echo 文件名$0

sudo rm -rf ./$nginx_install_temp_dir
echo "启动nginx"
sudo bash -c "$nginx_install_path/sbin/nginx"
if [[ $? == 0 ]] 
then
	echo "启动完成"
	sleep 1
else
	echo "启动失败,请手动检查"
	sleep 1
	exit 1
fi
