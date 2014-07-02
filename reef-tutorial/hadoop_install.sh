nstall java
sudo apt-get update
echo Y | sudo apt-get install openjdk-7-jdk 
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64 && echo export JAVA_HOME=$JAVA_HOME >> ~/.profile

# Install hadoop
wget http://mirror.apache-kr.org/hadoop/common/hadoop-2.4.0/hadoop-2.4.0.tar.gz
tar xvzf hadoop-2.4.0.tar.gz 
mv hadoop-2.4.0 hadoop 
export HADOOP_HOME=$HOME/hadoop && echo export HADOOP_HOME=$HADOOP_HOME >> ~/.profile
export YARN_HOME=$HADOOP_HOME && echo export YARN_HOME=$YARN_HOME >> ~/.profile
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin 
export HADOOP_CONF=$HADOOP_HOME/etc/hadoop && echo export HADOOP_CONF=$HADOOP_CONF >> ~/.profile


#### trouble shooting 
echo export `env | grep ^JAVA_HOME` >> hadoop/etc/hadoop/hadoop-env.sh # java_home이 없다고 나올 때 

# start-dfs.sh 실행 시 이상한 에러 메시지들 
#echo "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> ~/hadoop/etc/hadoop/hadoop-env.sh # trouble shooting 
#echo "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> ~/hadoop/etc/hadoop/yarn-env.sh
#echo export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib" >> ~/hadoop/etc/hadoop/hadoop-env.sh
#echo export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib" >> ~/hadoop/etc/hadoop/yarn-env.sh

# git 
echo Y | sudo apt-get install git-core git-doc 

# maven 3
echo Y | sudo apt-get install maven
#wget http://mirror.apache-kr.org/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
#tar xzvf apache-maven-3.2.1-bin.tar.gz
#mv apache-maven-3.2.1 maven
#export PATH=$PATH:$HOME/maven/bin



# gcc for proto
echo Y | sudo apt-get install gcc 
# g++ for proto
echo Y | sudo apt-get install g++ 
# make
sudo apt-get install make 

# proto buf 
wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz 
tar zxvf protobuf-2.5.0.tar.gz 
cd protobuf-2.5.0 
./configure 
sudo make install 
cd src/ 
sudo ldconfig # error 해결방법
cd ~ 


echo Y | sudo apt-get install pkg-config libfuse-dev libcurl4-openssl-dev libxml2-dev

# hadoop 64bit compile
echo Y | sudo apt-get install build-essential
echo Y | sudo apt-get install g++ autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev
wget http://apache.tt.co.kr/hadoop/common/hadoop-2.4.0/hadoop-2.4.0-src.tar.gz
tar xzvf hadoop-2.4.0-src.tar.gz
echo Y | sudo apt-get install build-essential
echo Y | sudo apt-get install g++ autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev
cd hadoop-2.4.0-src
mvn package -Pdist,native -DskipTests -Dtar
mv $HADOOP_HOME/lib/native $HADOOP_HOME/lib/native.bu
sudo cp -r hadoop-dist/target/hadoop-2.4.0/lib/native $HADOOP_HOME/lib/
cd ~

echo PATH=$PATH >> ~/.profile

