yum update vsf* 
yum install vsftpd 
service vsftpd start
useradd root
passwd root
su - root
mkdir Softwares
ifconfig
yum install mysql mysql-server
chkconfig  mysqld on
mysql_install_db
service mysqld start
mysqladmin -u root password 'your password'  
mysql> grant all privileges on toledonews.* to 'root'@'%' identified by '';
iptables -A INPUT -j ACCEPT -p TCP -s 0.0.0.0/0 --dport 3306
