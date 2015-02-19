include:
  - mysql
  - hive.user

#set Directory
/opt/hive:
  file.directory:
    - user: hive
    - group: hive
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

# Send the Downloaded Hadoop Binaries.
/opt/hive/apache-hive-1.0.0-bin.tar.gz:
  file:
    - managed
    - source: salt://hive/apache-hive-1.0.0-bin.tar.gz
    - user: hive
    - group: hive
    - mode: 644
    - require:
       - file: /opt/hive    
  cmd.run:
    - name: "tar -zxf apache-hive-1.0.0-bin.tar.gz; mv apache-hive-1.0.0-bin hive;"
    - user: hive
    - cwd: /opt/hive/
    - require:
       - file: /opt/hive/apache-hive-1.0.0-bin.tar.gz
    - creates:
       - /opt/hive/hive

#Copy the Config Files
/opt/hive/hive/conf/hive-site.xml:
  file:
    - managed
    - source: salt://hive/hive-site.xml
    - user: hive
    - group: hive
    - mode: 644

/opt/hive/hive/conf/hive-env.sh:
  file:
    - managed
    - source: salt://hive/hive-env.sh
    - user: hive
    - group: hive
    - mode: 755

#Copy the mysql-connecter-java
/opt/hive/hive/mysql-connector-java-5.1.34.tar.gz:
  file:
    - managed
    - source: salt://hive/mysql-connector-java-5.1.34.tar.gz
    - user: hive
    - group: hive
    - mode: 755    

Extract and copy the mysql connector:
  cmd.run:
    - name: |
        tar -zxf mysql-connector-java-5.1.34.tar.gz; 
        cp -f mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar lib/
        rm -fr mysql-connector-java-5.1.34
        rm mysql-connector-java-5.1.34.tar.gz
    - user: hive
    - cwd: /opt/hive/hive

#Copy the mysql-script for hive
/opt/hive/hive/mysql-script.sql:
  file:
    - managed
    - source: salt://hive/mysql-script.sql
    - user: hive
    - group: hive
    - mode: 755    

Run Mysql Script:
  cmd.run:
    - name: |
        mysql < /opt/hive/hive/mysql-script.sql
        rm /opt/hive/hive/mysql-script.sql
    - user: root
    - cwd: /

#Start Hive
Create Dir hive/warehouse:
  cmd.run:
    - name: "bin/hdfs dfs -mkdir -p /user/hive/warehouse"
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop
 
Give Read Write Permission:
  cmd.run:
    - name: "echo N |bin/hdfs dfs -chmod g+w /user/hive/warehouse"
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop

Give owner Permission to hive:
  cmd.run:
    - name: "echo N |bin/hdfs dfs -chown -R hive /user/hive"
    - cwd: /opt/hadoop/hadoop-2.6.0
    - user: hadoop
