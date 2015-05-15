/etc/salt/minion.d/mine.conf:
  file: 
    - managed
    - source: salt://mine.conf
    - user: root
    - group: root
    - mode: 644

salt-minion:
  service.restart
