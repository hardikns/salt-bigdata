#!pydsl

roles = __grains__.get('roles', [])
hadoop = __pillar__.get('hadoop', {})
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')

files = ['mongo-hadoop-core-1.3.2.jar', 
         'mongo-hadoop-hive-1.3.2.jar',
         'mongo-hadoop-streaming-1.3.2.jar',
         'mongo-java-driver-2.9.3.jar']



if 'hadoop-master' in roles or 'hadoop-slave' in roles or 'hive' in roles:
    for file in files:
        hl = state("Copy " + file + " to $hadoop-home/lib")
        hl.file("managed", \
                name=base_dir + "/lib/" + file, \
                            user="hadoop", group="hadoop", \
                            mode=644, source="salt://mongo-hadoop/" + file)

        hl = state("Copy " + file + " to $hadoop-home/share/hadoop/mapreduce")
        hl.file("managed", \
                name=base_dir + "/share/hadoop/mapreduce/" + file, \
                            user="hadoop", group="hadoop", \
                            mode=644, source="salt://mongo-hadoop/" + file)

        hl = state("Copy " + file + " to $hive-home/lib")
        hl.file("managed", \
                name="/opt/hive/hive/lib/" + file, \
                            user="hive", group="hive", \
                            mode=644, source="salt://mongo-hadoop/" + file)

if 'flume' in roles:
    fl = state("Copy " + flume + " to $flume_home/lib")
    fl.file("managed", \
            name="/opt/flume/flume/lib/flume-1.3.2.jar", \
                        user="flume", group="flume", \
                        mode=644, source="salt://mongo-hadoop/flume-1.3.2.jar")                        