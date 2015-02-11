# Pre-Requisits are installed first. 
include:
  - mongodb.users

# Set the directory
/opt/mongo:
  file.directory:
    - user: mongo
    - group: mongo
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

# Send the Downloaded Hbase Binaries.
/opt/mongo/mongodb-linux-x86_64-2.6.7.tar.gz:
  file: 
    - managed
    - source: salt://mongodb/mongodb-linux-x86_64-2.6.7.tar.gz
    - user: mongo
    - group: mongo
    - mode: 644
  cmd.run:
    - name: "tar -zxvf mongodb-linux-x86_64-2.6.7.tar.gz; mv mongodb-linux-x86_64-2.6.7 mongodb;"
    - user: mongo
    - cwd: /opt/mongo/
    - output_loglevel: quiet
    - require:
       - file: /opt/mongo/mongodb-linux-x86_64-2.6.7.tar.gz
    - creates:
       - /opt/mongo/mongodb

/opt/mongo/mongodb/conf:
  file.directory:
    - user: mongo
    - group: mongo
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

/var/log/mongo:
  file.directory:
    - user: mongo
    - group: mongo
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode      