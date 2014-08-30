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
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property> 
      <name>mapred.job.tracker</name> 
      <value>localhost:8021</value> 
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
    <property>
      <name>yarn.resourcemanager.address</name>
      <value>localhost:8032</value>
    </property>
    <property>
      <name>yarn.resourcemanager.scheduler.address</name>
      <value>localhost:8030</value>
    </property>
    <property>
      <name>yarn.resourcemanager.resource-tracker.address</name>
      <value>localhost:8031</value>
    </property>
</configuration>
	
	```
	
* stop-dfs and stop-yarn
* $HADOOP_HOME/bin/hdfs namenode -format
* Start daemons again
