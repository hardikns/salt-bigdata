Create Hadoop user:
  user.present:
    - name: hadoop
    - gid_from_name: True
    - require:
      - group: hadoop
  group.present:
    - name: hadoop
    
