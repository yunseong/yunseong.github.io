# REEF on YARN Environment in Mac
REEF does not work stable on YARN with Java 6 in Mac. So, if you develop REEF in Mac, Java 7 will be a better choice. This is a tutorial to set up Hadoop 2.2.0 in Mac and make REEF work on YARN.

## Set up Hadoop 2.2.0
#### Install Java 7
* Download Java 7 [`here`](http://java.com/en/download/mac_download.jsp)
* Add `export JAVA_HOME=$(/usr/libexec/java_home)` in `~/.bash_profile`
* Type `source ~/.bash_profile` to apply the change. Then `echo $JAVA_HOME` gives you the result like this

	```
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
	```
 Please make sure `java -version` gives you the same version of Java.

	```
java version "1.7.0_51"
Java(TM) SE Runtime Environment (build 1.7.0_51-b13)
Java HotSpot(TM) 64-Bit Server VM (build 24.51-b03, mixed mode)
	```


#### Download Hadoop
 * Download Hadoop 2.2.0 in [`Apache Download Mirrors`](http://www.apache.org/dyn/closer.cgi/hadoop/common/)
 * Unpack in a directory you want. Your home directory(`/Users/{username}`) or `/usr/local` are normal choice.
 
#### PATH Variables
It is a quite tricky part. If you encounter a problem related the PATH variables and google it, you may find a bunch of answers which vary a lot. This was very confusing and followings are maybe quite small values to be set necessarily.

* HADOOP_HOME
* YARN_HOME : YARN_HOME=$HADOOP_HOME
* REEF_HOME
 
Next, you add a line - `export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin` for convenience. After setting this, you can execute `hadoop` or `hdfs` command without not providing full path of the program.

#### Configurations

In `$HADOOP_HOME/etc/hadoop`, you can find the configuration scripts and files - `hadoop-env.sh`, `yarn-env.sh`, `core-site.xml`, `hdfs-site.xml`, `mapred-site.xml`, `yarn-site.xml`, etc. We will run hadoop in pseudo-distributed mode and followings are options for pseudo-distributed mode. 

* hadoop-env.sh, yarn-env.sh : you can leave these files if you set correct `HADOOP_HOME` and `YARN_HOME`.
* core-site.xml 

	```		
<configuration>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://localhost:9000</value>
	</property>
</configuration>
	
	```
* hdfs-site.xml

	```		
<configuration>
	<property>
		<name>dfs.replication</name>
		<value>1</value>
	</property>
	<property>
   		<name>dfs.namenode.name.dir</name>
   		<value>file:/usr/local/hadoop-2.2.0/dfs/name</value>
 	</property>
 	<property>
   		<name>dfs.datanode.data.dir</name>
   		<value>file:/usr/local/hadoop-2.2.0/dfs/data</value>
 	</property>
</configuration>
	
	```
* mapred-site.xml

	```		
<configuration>
	<property>
		<name>mapred.job.tracker</name>
		<value>localhost:9001</value>
	</property>
</configuration>
	
	```
* yarn-site.xml

	```		
<configuration>
	<property>
		<name>yarn.resourcemanager.address</name>
		<value>localhost:8032</value>
	</property>
</configuration>
	
	```
 
#### Starting the daemons

* In Pseudo-distributed mode, SSH is required and you should make sure that SSH is installed.
* To start the HDFS and YARN daemons, type:

	```
$ $HADOOP_HOME/sbin/start-dfs.sh && $HADOOP_HOME/sbin/start-yarn.sh
	```
* If you want to skip typing the password whenever starting or stopping the daemons, generate a new SSH key with an empty passphrase and add the public key to the authorized keys list.

	```
$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	```
	

## Test Configuration
You can check your configuration running those example applications below.

* WordCount


	```
# create a input file in local 
$ echo "hello world" > local_input.txt 
# copy the local file into hdfs
$ hadoop fs -copyFromLocal local_input.txt hdfs_input.txt  
# execute wordcount
$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount hdfs_input.txt ouput 
# check output
$ hadoop fs -ls output
 	```
* PI

	```
$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar pi 20 5
 	```
* HelloReefYarn : See this [tutorial](https://github.com/cmssnu/surf/blob/master/tutorial/hello-reef-yarn.md)

* RetainedEval : See $REEF_HOME/reef-examples/run.sh. You can run the script like

	```
$ ./run.sh com.microsoft.reef.examples.retained_eval.Launch -num_eval 2 -local false
	```


## TroubleShooting

#### No datanode running
```
There are 0 datanode(s) running and no node(s) are excluded in this operation
```

This may happen when the namenode runs at Safemode. I removed dfs files(default location:/tmp/hadoop-[username]/dfs/) in Local File System and format the hdfs.

#### Connection refused

```
Call From Yunseong-2.local/192.168.0.105 to localhost:9000 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused
```

Stop all the daemons running. Format the namenode and start the daemons.

```
$ stop-dfs.sh && stop-yarn.sh
$ hdfs namenode -format
$ start-dfs.sh && start-yarn.sh
```

#### Java Heap space

```
 com.microsoft.wake.impl.SyncStage onNext
 SEVERE: com.microsoft.reef.io.network.impl.MessageHandler Exception from event handler java.lang.OutOfMemoryError: Java heap space
```
This error notifies you need more memory space. Enlarge your heap size of JVM.
