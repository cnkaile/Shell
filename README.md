# Shell

**测试环境 Ubuntu Server 16.04.1 LTS 64位**

-  1、 [从菜鸟教程中翻录的Shell基础知识。](https://www.runoob.com/linux/linux-shell.html)
-  2、 [自动安装tomcat8](https://github.com/cnkaile/Shell/tree/master/auto_install_tomcat8.5.51)

tomcat版本：apache-tomcat-8.5.51.tar.gz

tomcat安装路径：/usr/local/tomcat/

tomcat下载链接：http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz

-  3、 [自动安装Java JDK](https://github.com/cnkaile/Shell/tree/master/auto_install_javaJDK)

由于从Orcle下载 Java JDK需要登录，所以这里不是使用在线下载方式。
您有两种选择方式：
1. 手动下载Java JDK （需要tar.gz文件，因为我用此方式解压）放在shell同级目录，启动 java_jdk_install.sh进行对应操作或者启动 java_package_install.sh [您的安装包名称] 进行安装。
2. 如果您有Java JDK下载链接，可以直接下载，可以使用此链接进行安装。shell通过 wget 方式进行下载安装，同样要 tar.gz文件。

-  4、 [自动安装nginx](https://github.com/cnkaile/Shell/tree/master/auto_install_nginx)

nginx下载网站：https://nginx.org/download/

Shell中使用的nginx版本：[nginx-1.16.1.tar.gz](https://nginx.org/download/nginx-1.16.1.tar.gz)

nginx安装路径: /usr/local/nginx

如果需要其他版本nginx，可更改 nginx_install.sh 中的 nginx_down_url 变量的值。本shell只支持tar.gz文件
<hr>

***安装nginx时需要使用 make 进行编译和安装，所以需要先安装一下包：openssl libssl-dev libpcre3 libpcre3-dev zlib1g-dev***

如果您的系统也是Debian系列（即支持 apt-get 命令），可以在shell中选择安装。如果您的系统不支持 apt-get 命令并且系统中缺少以上Linux库，则需要先安装对应的库，安装完成后才能正常进行 make 编译安装。

Shell中安装库命令

```shell
        echo `dpkg -l | grep zlib`                      #这里我查了一下，但是没有进行判断下面重复安装了下，反正没影响
        echo `sudo apt-get install openssl libssl-dev`
        echo `sudo apt-get install libpcre3 libpcre3-dev`
        echo `sudo apt-get install zlib1g-dev`
```

***参考***

如果您的Linux是 Redhat 系列，建议使用yum命令安装：

```shell
          yum install gcc-c++                   #make需要使用gcc编译器，一般Linux上都存在，不用单独安装
          yum install -y pcre pcre-devel        #安装PCRE-DEVEL
          yum install -y pcre pcre-devel        #安装zlib
          yum install -y openssl openssl-devel  #安装OpenSSl
```

<hr>
