#!pydsl
hadoop = __pillar__.get('hadoop', {})
data_dirs = hadoop.get('data-dirs',['data1'])
base_dir = hadoop.get('base-dir', '/opt/hadoop/hadoop-2.6.0/')
roles = __grains__.get('roles', [])

for dir in data_dirs:
    if "hadoop-master" in roles:
        dir_state = state("Create NN Dirs" + dir)
        dir_state.file("directory", name=base_dir + "/" +  dir + "/nn"   , 
                        user="hadoop", group="hadoop", 
                        mode=755, makedirs=True, 
                        recurse=['user', 'group', 'mode'])        

    if "hadooo-slave" in roles:
        dir_state = state("Create NN Dirs" + dir)
        dir_state.file("directory", name=base_dir + "/" +  dir + "/dn"  , 
                        user="hadoop", group="hadoop", 
                        mode=755, makedirs=True, 
                        recurse=['user', 'group', 'mode'])          

