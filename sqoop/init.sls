include:
  - sqoop.user

# Set the directory
/opt/sqoop:
  file.directory:
    - user: sqoop
    - group: sqoop
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

# Send the Downloaded Hbase Binaries.
/opt/sqoop/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz:
  file: 
    - managed
    - source: salt://sqoop/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
    - user: sqoop
    - group: sqoop
    - mode: 644
    - require:
       - file: /opt/sqoop
  cmd.run:
    - name: "tar -zxf sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz; mv sqoop-1.4.5.bin__hadoop-2.0.4-alpha sqoop;"
    - user: sqoop
    - cwd: /opt/sqoop/
    - require:
       - file: /opt/sqoop/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
    - creates:
       - /opt/sqoop/sqoop

/opt/sqoop/sqoop/conf/sqoop-site.xml:
  file: 
    - managed
    - source: salt://sqoop/sqoop-site.xml
    - user: sqoop
    - group: sqoop
    - mode: 644

/opt/sqoop/sqoop/conf/sqoop-env.sh:
  file: 
    - managed
    - source: salt://sqoop/sqoop-env.sh
    - user: sqoop
    - group: sqoop
    - mode: 644
