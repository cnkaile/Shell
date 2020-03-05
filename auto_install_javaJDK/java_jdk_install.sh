#!/bin/bash
clear
printf "**************************** JAVA JDK Install ***************************\n"
echo -e "由于Oracle JDK 下载需要登录，无法自动下载,因此在安装前需要先下载安装包,放到此目录下\n,或者选择url安装,输入您的JDK下载地址。"
printf "*************************************************************************\n\n"

printf "请认真读，输入N退出,其他键继续:"
read k
if [[ $k == "N" ]] ; then
	exit 2
fi

printf "\t 输入 1 : 自己下载安装包(tar.gz), 放到运行目录下\n"
printf "\t 输入 2 : 输入JDK下载链接进行安装,需要 tar.gz 压缩包\n"

is_continue=1
while (( $is_continue == 1 ))
do
printf "请输入安装方式:"
read install_type
case $install_type in
	1)
		echo -n 输入安装包名称:
		read jdk_name
		./java_package_install.sh $jdk_name
		if [[ $? == 0 ]] ; then
		is_continue=2
		fi
		;;
	2)
		echo -n 输入JDK下载链接:
		read jdk_down_url
		./java_url_install.sh $jdk_down_url
		if [[ $? == 0 ]] ; then
		is_continue=2
		fi
		;;
	*)
		echo 输入错误
		;;
esac
done
