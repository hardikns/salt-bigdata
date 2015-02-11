# Pre-Requisits are installed first. 
include:
  - flume.user

# Set the directory
/opt/flume:
  file.directory:
    - user: flume
    - group: flume
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

# Send the Downloaded Hbase Binaries.
/opt/flume/apache-flume-1.5.2-bin.tar.gz:
  file: 
    - managed
    - source: salt://flume/apache-flume-1.5.2-bin.tar.gz
    - user: flume
    - group: flume
    - mode: 644
  cmd.run:
    - name: "tar -zxvf apache-flume-1.5.2-bin.tar.gz; mv apache-flume-1.5.2-bin flume;"
    - user: flume
    - cwd: /opt/flume/
    - output_loglevel: quiet
    - require:
       - file: /opt/flume/apache-flume-1.5.2-bin.tar.gz
    - creates:
       - /opt/flume/flume

/opt/flume/flume/conf/flume-env.sh:
  file: 
    - managed
    - source: salt://flume/flume-env.sh
    - user: flume
    - group: flume
    - mode: 644


