Create Sqoop user:
  user.present:
    - name: sqoop
    - gid_from_name: True
    - groups:
      - hadoop
    - require:
      - group: sqoop
  group.present:
    - name: sqoop
    
