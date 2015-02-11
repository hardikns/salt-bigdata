base:
  '*':
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

