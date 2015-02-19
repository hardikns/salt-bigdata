hadoop:
  base-dir:
    /opt/hadoop/hadoop-2.6.0/
  data-dirs:
    - data1
    - data2
    - data3
    - data4
  config:
    directory: etc/hadoop
    core-site:
      io.native.lib.available:
        value: true
      io.file.buffer.size:
        value: 65536
      fs.trash.interval:
        value: 60
    hdfs-site:
      dfs.blocksize:
        value: 134217728 
      dfs.namenode.handler.count:
        value: 100
      dfs.permissions.superusergroup:
        value: hadoop
    yarn-site:
      yarn.log-aggregation-enable:
        value: true
      yarn.resourcemanager.scheduler.class:
        value: org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler 
      yarn.scheduler.minimum-allocation-mb:
        value: 1024
      yarn.scheduler.maximum-allocation-mb:
        value: 2048
      yarn.nodemanager.aux-services:
        value: mapreduce_shuffle
      yarn.nodemanager.resource.memory-mb:
        value: 2048
      yarn.log-aggregation.retain-seconds:
        value: -1
      yarn.log-aggregation.retain-check-interval-seconds: 
        value: -1
    mapred-site: 
      mapreduce.framework.name:
        value: yarn
      mapreduce.map.memory.mb:
        value: 1024
      mapreduce.map.java.opts:
        value: -Xmx1024M
      mapreduce.reduce.memory.mb:
        value: 2048
      mapreduce.reduce.java.opts:
        value: -Xmx2048M
      mapreduce.task.io.sort.mb:
        value: 512
      mapreduce.task.io.sort.factor:
        value: 100
      mapreduce.reduce.shuffle.parallelcopies:
        value: 50


