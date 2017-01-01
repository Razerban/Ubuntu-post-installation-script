#!/bin/zsh

######################################################################
# Written to be used on 64 bits computers running Ubuntu             #
# to install Spark                                                   #
# Author    :   Ahmed Abdelkafi                                      #
######################################################################
#                                                                    #
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.       #
#                                                                    #
######################################################################

echo "1. Install JDK, Python Software Properties, OpenSSH, SBT and Scala"
cd /tmp
sudo apt install default-jdk python-software-properties openssh-server -y
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt update
sudo apt install sbt -y
wget $(curl -Ls http://www.scala-lang.org/download | grep -Po '(?<=href=")[^"]*.deb') -O scala.deb
sudo dpkg -i scala.deb
sudo touch $JAVA_HOME/release

echo "2. Install Spark"
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
tar xzf spark-2.1.0-bin-hadoop2.7.tgz
mv spark-2.1.0-bin-hadoop2.7 spark
sudo mv spark /opt
cd /opt
sudo chown $(whoami):$(whoami) -R spark

echo "3. Updating zshrc for export Path"
echo '# SPARK VARIABLES START' >> ~/.zshrc
echo 'export SPARK_HOME="/opt/spark"' >> ~/.zshrc
echo 'export PATH="$SPARK_HOME/bin:$PATH"' >> ~/.zshrc
echo 'export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH"' >> ~/.zshrc
echo '# SPARK VARIABLES END' >> ~/.zshrc
echo '' >> ~/.zshrc

echo "4. Loading the ZSH profile"
source ~/.zshrc
