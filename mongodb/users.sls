Create Mongo user:
  user.present:
    - name: mongo
    - gid_from_name: True
    - require:
      - group: mongo
  group.present:
    - name: mongo
    