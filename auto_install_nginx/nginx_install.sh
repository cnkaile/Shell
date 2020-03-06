#/bin/bash
clear
printf "==================== 自动安装nginx =======================\n\n"
printf "nginx下载链接:\nhttps://nginx.org/download/ \n"
printf "安装路径:/usr/local/nginx\n\n"
printf "==========================================================\n\n"

sleep 1
nginx_down_url='https://nginx.org/download/nginx-1.16.1.tar.gz'
nginx_install_path="/usr/local/nginx"

echo `wget $nginx_down_url`
if [[ $? != 0 ]]
then
	echo 下载失败,请重试
	exit 1
fi

nginx_package_name=${nginx_down_url##*/}
if ! test -e $nginx_package_name 
then
	echo 没有找到下载文件$nginx_package_name, 请手动输入
	is_con=1
	while (( $is_con == 1 ))
	do
		read name
		nginx_name=$(ls | grep $name)
		if test -e $nginx_name
		then
			echo "查找到文件: $nginx_name"
			nginx_package_name=$nginx_name
			is_con=0
		fi
		echo "请重新输入,未查到文件"
	done

fi

./nginx_package_install.sh $nginx_package_name

if [[ $? == 0 ]] 
then
	echo 安装完成success
else
	echo 安装失败
fi







