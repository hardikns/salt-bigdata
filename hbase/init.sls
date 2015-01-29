# Send the Downloaded Hbase Binaries.
/opt/hadoop/hbase-0.98.9-hadoop2-bin.tar.gz:
  file: 
    - managed
    - source: salt://hbase/hbase-0.98.9-hadoop2-bin.tar.gz
    - user: hadoop
    - group: hadoop
    - mode: 644
    - require:
       - file: /opt/hadoop
  cmd.run:
    - name: "tar -zxvf hbase-0.98.9-hadoop2-bin.tar.gz; mv hbase-0.98.9-hadoop2 hbase;"
    - user: hadoop
    - cwd: /opt/hadoop/
    - require:
       - file: /opt/hadoop/hbase-0.98.9-hadoop2-bin.tar.gz
    - creates:
       - /opt/hadoop/hbase

/opt/hadoop/hbase/conf/hbase-site.xml:
  file: 
    - managed
    - source: salt://hbase/hbase-site.xml
    - user: hadoop
    - group: hadoop
    - mode: 644

/opt/hadoop/hbase/conf/hbase-env.sh:
  file: 
    - managed
    - source: salt://hbase/hbase-env.sh
    - user: hadoop
    - group: hadoop
    - mode: 644


StartHbase:
  cmd.run:
    - name: "bin/start-hbase.sh"
    - user: hadoop
    - cwd: /opt/hadoop/hbase/

