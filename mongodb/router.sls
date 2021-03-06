#!pydsl

def convert_ip_data(data, ip):
    delim = ':' + ip + ','
    return delim.join([x[0] for x in data]) + ":" + ip

mongo_config_ips = __salt__['mine.get']('roles:mongo-config', 'prodapt_ip_addrs', 'grain').values() 
config_ip_string = convert_ip_data(mongo_config_ips, "27019")
p = __pillar__.get('mongo-router', {})
log_path     = p.get("log_path", "/var/log/mongo/mongos.log")
port         = p.get("port", "27017")
conf_file    = p.get("conf_file", "/opt/mongo/mongodb/conf/mongos.conf")


mongos_configuration = state("mongos_configuration")
mongos_configuration.file("managed", \
                    name=conf_file, \
                    user="mongo", group="mongo", \
                    mode=644, source="salt://mongodb/files/config.jinja", \
                    template="jinja", context = {'dbpath':"",
                                               'logpath':log_path,
                                               'port':port,
                                               'replica_set':False,
                                               'config_svr':False,
                                               'shard_svr': False,
                                               'mongos':True} )
cmd = "nohup bin/mongos --config %s --configdb %s >/dev/null 2>&1 &"%(conf_file, config_ip_string)
state("Start Mongos-Router").cmd.run(cmd, user="mongo", cwd="/opt/mongo/mongodb")


