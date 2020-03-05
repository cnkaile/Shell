#!/bin/bash
jdk_package_name=$1
echo $jdk_package_name
if [[ ! $jdk_package_name =~ ^.*\.tar\.gz$ ]] 
then
	echo "JDK安装包必须是tar.gz压缩方式"
	exit 1
fi

if ! test -e "./$jdk_package_name"
then
	echo "文件 $jdk_package_name 不存在"
	exit 1
fi

java_jdk_install_path="/usr/local/java"
java_jdk_temp_dir=${jdk_package_name%%.*}
echo 临时目录$java_jdk_temp_dir

if ! test -d "$java_jdk_temp_dir"
then
	mkdir $java_jdk_temp_dir
	echo 创建临时文件夹
else 
	rm -rf ./$java_jdk_temp_dir/*
	echo 清空临时文件夹:$?
	exit 1
fi

tar -zxvf ./$jdk_package_name -C "./$java_jdk_temp_dir" --strip-components 1
if [[ $? != 0 ]] 
then
	echo 解压失败
	exit 1
fi

if ! test -d "$java_jdk_install_path"
then
	sudo mkdir $java_jdk_install_path
	echo 创建Java JDK 安装目录
else
	sudo rm -rf $java_jdk_install_path/*
	if [[ $? != 0 ]] 
	then
		echo 清空安装路径失败
		exit 1
	fi
	echo 清空安装路径
fi

sudo mv "./$java_jdk_temp_dir" "$java_jdk_install_path"
if [[ $? != 0 ]] 
then
	echo 复制失败
	exit 1
fi

echo 配置Java环境变量

sudo bash -c "echo export JAVA_HOME=$java_jdk_install_path/$java_jdk_temp_dir >> /etc/profile"
sudo bash -c "echo export PATH='$'JAVA_HOME/bin:'$'PATH >> /etc/profile"
sudo bash -c "echo export CLASSPATH=.:'$'JAVA_HOME/lib/dt.jar:'$'JAVA_HOME/lib/tools.jar >> /etc/profile"
#echo $(source /etc/profile)
sudo bash -c "source /etc/profile"
