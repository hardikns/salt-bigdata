{%- set mongo_shard_ips = salt['mine.get']('roles:mongo-shard', 'prodapt_ip_addrs', 'grain').values() %}

{%- for shard in mongo_shard_ips %}
Connect to Shard {{ shard }}:
  cmd.run: 
    - name: "bin/mongo --port 27017 --eval 'sh.addShard(\"{{ shard[0] }}:27018\")' "
    - user: mongo
    - cwd: /opt/mongo/mongodb
{%- endfor %}

Check Shard:
  cmd.run: 
    - name: "bin/mongo --port 27017 --eval 'sh.status()' "
    - user: mongo
    - cwd: /opt/mongo/mongodb

