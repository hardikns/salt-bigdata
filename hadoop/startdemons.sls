#!pydsl
roles = __grains__.get('roles', [])
hadoop = __pillar__.get('hadoop', {})
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')

if 'hadoop-master' in roles:
	command = "sbin/hadoop-daemon.sh --script hdfs start namenode"
	state("Start NameNode").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh start resourcemanager"
	state("Start Yarn ResourceMgr").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh start proxyserver"
	state("Start Yarn ProxyServer").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/mr-jobhistory-daemon.sh start historyserver"
	state("Start MapReduce JobHistory Server").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "bin/hdfs dfs -mkdir /user"
	state("Create Dir User").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "bin/hdfs dfs -mkdir /user/hadoop"
	state("Create Dir User/hadoop").cmd.run(command, user="hadoop", cwd=base_dir)

if 'hadoop-slave' in roles:
	command = "sbin/hadoop-daemon.sh --script hdfs start datanode"
	state("Start DataNode").cmd.run(command, user="hadoop", cwd=base_dir)

	command = "sbin/yarn-daemon.sh start nodemanager"
	state("Start Yarn NodeMgr").cmd.run(command, user="hadoop", cwd=base_dir)

