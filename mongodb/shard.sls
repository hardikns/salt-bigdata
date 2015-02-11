{% set p  = salt['pillar.get']('mongo-shard', {}) %}
{% set dir          = p.get("dir", "/opt/mongo/mongodb/data/shard") %}
{% set log_path     = p.get("log_path", "/var/log/mongo/shard.log") %}
{% set port         = p.get("port", "27018") %}
{% set conf_file    = p.get("conf_file", "/opt/mongo/mongodb/conf/shard.conf") %}

Db Path Shard:
  file.directory:
    - name: {{ dir }}
    - user: mongo
    - group: mongo
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

Mongodb configuration:
  file.managed:
    - name: {{ conf_file }}
    - user: root
    - group: root
    - mode: 644
    - source: salt://mongodb/files/config.jinja
    - template: jinja
    - context:
        dbpath: {{ dir }}
        logpath: {{ log_path }}
        port: {{ port }}
        replica_set: False
        config_svr: False
        shard_svr: True
        mongos: False

Start Mongo-Shard:
  cmd.run:
    - name: "bin/mongod --config {{ conf_file }} >/dev/null 2>&1 &" 
    - cwd: /opt/mongo/mongodb
    - user: mongo
