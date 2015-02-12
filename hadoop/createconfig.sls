#!pydsl
roles = __grains__.get('roles', [])
hadoop = __pillar__.get('hadoop', {})
data_dirs = hadoop.get('data-dirs',['data1'])
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')
core_site = hadoop.get("config", {'core-site':{}}).get("core-site")
hdfs_site = hadoop.get("config", {'hdfs-site':{}}).get("hdfs-site")
mapred_site = hadoop.get("config", {'mapred-site':{}}).get("mapred-site")
yarn_site = hadoop.get("config", {'yarn-site':{}}).get("yarn-site")
config_dir = hadoop.get("config", {'directory':"etc/hadoop"}).get("directory")

hadoop_master_ips = __salt__['mine.get']('roles:hadoop-master', 'prodapt_ip_addrs', 'grain').values()[0]
hadoop_slave_count = len(__salt__['mine.get']('roles:hadoop-slave', 'prodapt_ip_addrs', 'grain').keys())

core_site['fs.defaultFS'] = {'value': "hdfs://" + hadoop_master_ips[0] + ":9000/"}    

hdfs_site['dfs.replication'] = {'value':3 if hadoop_slave_count>3 else hadoop_slave_count}

nn_dirs = []
dn_dirs = []
for dir in data_dirs:
    nn_dirs.append( base_dir + "/" +  dir + "/nn")
    dn_dirs.append( base_dir + "/" +  dir + "/dn")


if 'hadoop-master' in roles:
    hdfs_site['dfs.namenode.rpc-address'] = {'value': "0.0.0.0:9000"}
    hdfs_site['dfs.namenode.name.dir'] = {'value':','.join(nn_dirs)}
    yarn_site['yarn.resourcemanager.hostname'] = {'value': hadoop_master_ips[0]}
    yarn_site['yarn.web-proxy.address'] = {'value': hadoop_master_ips[0] + ":9001"}

if 'hadoop-slave' in roles:
    hdfs_site['dfs.datanode.data.dir'] = {'value' : ','.join(dn_dirs)}

cs = state("core-site")
cs.file("managed", \
        name=base_dir + "/" + config_dir + "/core-site.xml", \
                    user="hadoop", group="hadoop", \
                    mode=644, source="salt://hadoop/files/config.jinja", \
                    template="jinja", context = {'dyn_cfg':core_site})
hs = state("hdfs-site")
hs.file("managed", \
        name=base_dir + "/" + config_dir + "/hdfs-site.xml", \
                    user="hadoop", group="hadoop", \
                    mode=644, source="salt://hadoop/files/config.jinja", \
                    template="jinja", context = {'dyn_cfg':hdfs_site})

ms = state("mapred-site")
ms.file("managed", \
        name=base_dir + "/" + config_dir + "/mapred-site.xml", \
                    user="hadoop", group="hadoop", \
                    mode=644, source="salt://hadoop/files/config.jinja", \
                    template="jinja", context = {'dyn_cfg':mapred_site})

ys = state("yarn-site")
ys.file("managed", \
        name=base_dir + "/" + config_dir + "/yarn-site.xml", \
                    user="hadoop", group="hadoop", \
                    mode=644, source="salt://hadoop/files/config.jinja", \
                    template="jinja", context = {'dyn_cfg':yarn_site})