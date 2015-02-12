/opt/hadoop/hadoop-2.6.0/etc/hadoop/hadoop-env.sh:
  file: 
    - managed
    - source: salt://hadoop/hadoop-env.sh
    - user: hadoop
    - group: hadoop
    - mode: 644