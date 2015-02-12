#!pydsl
roles = __grains__.get('roles', [])
hadoop = __pillar__.get('hadoop', {})
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')

if 'hadoop-master' in roles:
	command = "sbin/hadoop-daemon.sh --script hdfs stop namenode"
	state("Stop NameNode").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh stop resourcemanager"
	state("Stop Yarn ResourceMgr").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh stop proxyserver"
	state("Stop Yarn ProxyServer").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/mr-jobhistory-daemon.sh stop historyserver"
	state("Stop MapReduce JobHistory Server").cmd.run(command, user="hadoop", cwd=base_dir)

if 'hadoop-slave' in roles:
	command = "sbin/hadoop-daemon.sh --script hdfs stop datanode"
	state("Stop DataNode").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh stop nodemanager"
	state("Stop Yarn NodeMgr").cmd.run(command, user="hadoop", cwd=base_dir)

