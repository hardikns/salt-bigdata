# Pre-Requisits are installed first. 
include:
  - hadoop.user
  - hadoop.ssh
  - hadoop.java

# Set the directory
/opt/hadoop:
  file.directory:
    - user: hadoop
    - group: hadoop
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

Export JAVA_HOME:
  environ.setenv: 
    - name: JAVA_HOME
    - value: /usr/lib/jvm/java-7-oracle
    - update_minion: True

# Send the Downloaded Hadoop Binaries.
/opt/hadoop/hadoop.tar.gz:
  file: 
    - managed
    - source: salt://hadoop/hadoop.tar.gz
    - user: hadoop
    - group: hadoop
    - mode: 644
  cmd.run:
    - name: tar -zxvf hadoop.tar.gz
    - user: hadoop
    - cwd: /opt/hadoop/
    - require:
       - file: /opt/hadoop/hadoop.tar.gz
    - creates:
       - /opt/hadoop/hadoop-2.6.0

# copy the config files
/opt/hadoop/hadoop-2.6.0/etc/hadoop/core-site.xml:
  file: 
    - managed
    - source: salt://hadoop/core-site.xml
    - user: hadoop
    - group: hadoop
    - mode: 644


/opt/hadoop/hadoop-2.6.0/etc/hadoop/hdfs-site.xml:
  file: 
    - managed
    - source: salt://hadoop/hdfs-site.xml
    - user: hadoop
    - group: hadoop
    - mode: 644

/opt/hadoop/hadoop-2.6.0/etc/hadoop/hadoop-env.sh:
  file: 
    - managed
    - source: salt://hadoop/hadoop-env.sh
    - user: hadoop
    - group: hadoop
    - mode: 644

# Should run only once. Echo N will take care of it.
Format Hadoop NameNode:
  cmd.run:
    - name: echo N | bin/hdfs namenode -format
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop

Start_Hadoop:
  cmd.run:
    - name: sbin/start-dfs.sh
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop
    - unless: "`jps | grep -c NameNode` -gt 0" 

Create Dir User:
  cmd.run: 
    - name: echo N |bin/hdfs dfs -mkdir /user
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop
    - requires:
       - cmd: Start_Hadoop

Create Dir User/hadoop:
  cmd.run: 
    - name: echo N | bin/hdfs dfs -mkdir /user/hadoop
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop
    - unless 
    - requires:
       - cmd: Start_Hadoop







