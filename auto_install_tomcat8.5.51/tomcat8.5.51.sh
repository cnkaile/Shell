#!/bin/bash
clear
tomcat_down_url=http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz
tomcat_base_path=/usr/local/tomcat
printf "\n\n"
printf "========================================= Tomcat 自动安装系统 ===================================================\n"
printf "\n\n"
printf "自动安装Tomcat 8.5.51, 下载tar.gz包地址: \n\t %s \n" $tomcat_down_url
printf "安装Tomcat路径: %s. \n" $tomcat_base_path
printf "\n\n"
printf "=================================================================================================================\n\n"
echo -e "        2S后开始下载Tomcat8\n\n"
sleep 1


#下载tomcat
echo 下载开始
echo `wget $tomcat_down_url`
if test $? == 0 ; 
then
	echo "下载完成"
else
	echo $$
	exit 1
	#echo `kill -9 $$`
fi

#查找tomcat包名称
tomcat_package_file_name=${tomcat_down_url##*/}
#查看文件是否存在
if ! test -e "$tomcat_package_file_name" ; then
	#文件不存在
	echo 下载url结尾的文件不存在
	tomcat_package_file_name=$(ls | grep "^apache-tomcat-.*\.tar\.gz$")
	if [ ! -e "$tomcat_package_file_name" ] ; then
		echo 没有查找到Tomcat包文件,无法解压
		exit 1	
	fi
	echo 查找到文件:$tomcat_package_file_name
fi

echo 开始解压: $tomcat_package_file_name
tomcat_temp_dir="tomcat_base"
if test -d "./$tomcat_temp_dir" ; then
	rm -rf "./$tomcat_temp_dir/*"
else
	mkdir "./$tomcat_temp_dir"
fi
tar -zxvf $tomcat_package_file_name -C "./$tomcat_temp_dir" --strip-components 1 
if test $? != 0 ; then
	echo 解压失败
	exit 1
fi

if ! test -d "$tomcat_base_path" ; then
	sudo mkdir "$tomcat_base_path"
fi
tomcat_dir_base_name="tomcat8_"
tomcat_port=8080

sudo mv "./$tomcat_temp_dir" "$tomcat_base_path/${tomcat_dir_base_name}${tomcat_port}"

