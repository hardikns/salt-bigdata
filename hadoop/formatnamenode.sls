#!pydsl
roles = __grains__.get('roles', [])
hadoop = __pillar__.get('hadoop', {})
data_dirs = hadoop.get('data-dirs',['data1'])
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')
hadoop_master_ips = __salt__['mine.get']('roles:hadoop-master', 'prodapt_ip_addrs', 'grain').values()[0]


if 'hadoop-master' in roles:
	command = "echo N | bin/hdfs namenode -format " + hadoop_master_ips[0] + ":9000"
	state("format NameNode").cmd.run(command, user="hadoop", cwd=base_dir)