#!/bin/bash
jdk_down_url=$1

echo -e "\n开始下载\n"
#echo `wget $jdk_down_url`
if [[ $? == 0 ]] 
then	
	echo -e "下载完成\n"
else
	echo "下载失败"
	exit 1
fi

#jdk_down_file_name=${jdk_down_url##*/}
jdk_down_file_name="jdk-8u231-linux-x64"
if [[ ! $jdk_down_file_name =~ .*\.tar\.gz ]] 
then 
	echo "下载文件不是tar.gz压缩方式,或者文件名不是以tar.gz结尾"
	echo -n "手动输入下载JDK文件(请确保是以tar.gz方式压缩,ctrl+c退出): "
	is_con=1
	while (( $is_con == 1 )) ; do
	read down_file_name
	file_name=$(ls | grep $down_file_name)
	if ! test -e $file_name ; then
		echo "没有查找到文件,请重试"
	else
		echo "查找到文件: $file_name"
		modify_file_name="$file_name.tar.gz"
		mv ./$file_name ./$modify_file_name
		echo 修改后的文件名：$modify_file_name
		echo -n 1s后开始安装...
		
		sleep 1
		./java_package_install.sh $modify_file_name
		if [[ $? != 0 ]] ; then 
			echo "安装失败"
			exit 1
		fi
	fi
	done
fi

