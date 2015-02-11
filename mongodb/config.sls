{% set p  = salt['pillar.get']('mongo-config', {}) %}
{% set dir          = p.get("dir", "/opt/mongo/mongodb/data/config") %}
{% set log_path     = p.get("log_path", "/var/log/mongo/configsvr.log") %}
{% set port         = p.get("port", "27019") %}
{% set conf_file    = p.get("conf_file", "/opt/mongo/mongodb/conf/configsvr.conf") %}

{{ dir }}:
  file.directory:
    - user: mongo
    - group: mongo
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

Mongo Config server configuration:
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
        config_svr: True
        shard_svr: False
        mongos: False

Start Mongo-Config:
  cmd.run:
    - name: "nohup bin/mongod --config {{ conf_file }} >/dev/null 2>&1 &" 
    - cwd: /opt/mongo/mongodb
    - user: mongo
