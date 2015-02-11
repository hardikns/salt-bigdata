base:
  '*':
    - ipdata

  'roles:mongo-config':
    - match: grain
    - mongo.config

  'roles:mongo-router':
    - match: grain
    - mongo.router

  'roles:mongo-shard':
    - match: grain
    - mongo.shard
