base:
  'roles:mongo*':
    - match: grain
    - mongodb

  'roles:mongo-config':
    - match: grain
    - mongodb.config

  'roles:mongo-shard':
    - match: grain
    - mongodb.shard            

  'roles:mongo-router':
    - match: grain
    - mongodb.router
    - mongodb.mongos-connect-shard

  'roles:hadoop*':
    - match: grain
    - hadoop

  'roles:sqoop':
    - match: grain
    - sqoop  

  'roles:hive':
    - match: grain
    - hive      

  '*':
    - mongo-hadoop