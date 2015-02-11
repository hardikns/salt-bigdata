Create Flume user:
  user.present:
    - name: flume
    - gid_from_name: True
    - require:
      - group: flume
  group.present:
    - name: flume
    
