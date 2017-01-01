#!/bin/zsh

######################################################################
# Written to be used on 64 bits computers running Ubuntu             #
# to install Hadoop 2.7.3                                            #
# Author    :   Ahmed Abdelkafi                                      #
######################################################################
#                                                                    #
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.       #
#                                                                    #
######################################################################

echo "1. Install JDK, Python Software Properties, OpenSSH"
sudo apt install default-jdk python-software-properties openssh-server -y

echo "2. Start ssh server"
sudo service ssh restart

echo "3. Add localhost to known hosts"
mkdir ~/.ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh-add

echo "4. Install Hadoop"
cd /tmp
wget http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
tar xzf hadoop-2.7.3.tar.gz
mv hadoop-2.7.3 hadoop
sudo mv hadoop /opt
cd /opt
sudo chown $(whoami):$(whoami) -R hadoop

echo "5. Updating zshrc with paths and aliases"
echo '# HADOOP VARIABLES START' >> ~/.zshrc
echo 'export HADOOP_INSTALL=/opt/hadoop' >> ~/.zshrc
echo 'export PATH=$PATH:$HADOOP_INSTALL/bin' >> ~/.zshrc
echo 'export PATH=$PATH:$HADOOP_INSTALL/sbin' >> ~/.zshrc
echo 'export HADOOP_MAPRED_HOME=$HADOOP_INSTALL' >> ~/.zshrc
echo 'export HADOOP_COMMON_HOME=$HADOOP_INSTALL' >> ~/.zshrc
echo 'export HADOOP_HDFS_HOME=$HADOOP_INSTALL' >> ~/.zshrc
echo 'export YARN_HOME=$HADOOP_INSTALL' >> ~/.zshrc
echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native' >> ~/.zshrc
echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"' >> ~/.zshrc
echo '' >> ~/.zshrc
echo '# HADOOP ALIASES START' >> ~/.zshrc
echo 'alias hstart="start-dfs.sh && start-yarn.sh"' >> ~/.zshrc
echo 'alias hstop="stop-dfs.sh && stop-yarn.sh"' >> ~/.zshrc
echo 'alias hrestart="hstop && hstart"' >> ~/.zshrc
echo '# HADOOP ALIASES END' >> ~/.zshrc
echo '' >> ~/.zshrc

cd /opt/hadoop/etc/hadoop
mkdir -p /opt/hadoop/app/{tmp,hdfs/{namenode,datanode}}

echo "6. Updating hadoop configuration files"
sed -i '/export JAVA_HOME=${JAVA_HOME}/c\export JAVA_HOME=$(dirname $(dirname $(readlink -e /usr/bin/javac)))' /opt/hadoop/etc/hadoop/hadoop-env.sh

cat > core-site.xml << EOL
<configuration>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/hadoop/app/tmp</value>
    </property>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:54310</value>
    </property>
</configuration>
EOL

cp mapred-site.xml.template mapred-site.xml
cat > mapred-site.xml << EOL
<configuration>
    <property>
        <name>mapred.job.tracker</name>
        <value>localhost:54311</value>
    </property>
</configuration>
EOL

cat > yarn-site.xml << EOL
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOL

cat > hdfs-site.xml << EOL
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/opt/hadoop/app/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/opt/hadoop/app/hdfs/datanode</value>
    </property>
</configuration>
EOL

echo "7. Loading the ZSH profile"
source ~/.zshrc
echo "8. Formatting the Hadoop NameNode"
hdfs namenode -format
echo "9. Starting Hadoop"
hstart
echo "10. Create the User directory under HDFS"
hadoop fs -mkdir -p /user/$(whoami)
echo "11. Check running processes"
echo "Must find :
xxxxx NameNode
xxxxx SecondaryNameNode
xxxxx Jps
xxxxx DataNode
xxxxx NodeManager
xxxxx ResourceManager
"
jps
echo "12. Stopping Hadoop"
hstop
