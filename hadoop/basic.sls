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

# Send the Downloaded Hadoop Binaries.
/opt/hadoop/hadoop.tar.gz:
  file: 
    - managed
    - source: salt://hadoop/hadoop.tar.gz
    - user: hadoop
    - group: hadoop
    - mode: 644

Extract Hadoop:
  cmd.run:
    - name: tar -zxvf hadoop.tar.gz
    - user: hadoop
    - cwd: /opt/hadoop/
    - require:
       - file: /opt/hadoop/hadoop.tar.gz
    - creates:
       - /opt/hadoop/hadoop-2.6.0
