Create Hive user:
  user.present:
    - name: hive
    - gid_from_name: True
    - groups:
      - hadoop
    - require:
      - group: hive
  group.present:
    - name: hive
    
