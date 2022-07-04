FROM: redhat/ubi8
RUN: sudo yum install wget unzip -y
     wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
     sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
     yum update -y
     sudo yum install mysql-server
     sudo systemctl start mysqld
RUN: mysql -u root
     CREATE DATABASE sonarqube_db;
     CREATE USER 'sonarqube_user'@'localhost' IDENTIFIED BY 'password';
     GRANT ALL PRIVILEGES ON sonarqube_db.* TO 'sonarqube_user'@'localhost' IDENTIFIED BY 'password';
     FLUSH PRIVILEGES;
     exit
RUN: wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.7.6.zip
     unzip sonarqube-6.7.6.zip
     mv sonarqube-6.7.6 /opt/sonarqube
RUN: useradd sonarqube
     passwd sonarqube
     chown -R sonarqube:sonarqube /opt/sonarqube
RUN: vi /opt/sonarqube/bin/linux-x86-64/sonar.sh
     RUN_AS_USER=sonarqube
CMD: ['/opt/sonarqube/bin/linux-x86-64/sonar.sh start']
