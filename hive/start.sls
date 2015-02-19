Start Hive MetaStore:
  cmd.run:
    - name: "nohup bin/hive --service metastore >/dev/null 2>&1 &"
    - cwd: /opt/hive/hive
    - user: hive