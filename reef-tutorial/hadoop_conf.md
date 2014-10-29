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
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
	
	```
* yarn-site.xml

	```		
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
</configuration>
	
	```
	
* stop-dfs and stop-yarn
* $HADOOP_HOME/bin/hdfs namenode -format
* Start daemons again
