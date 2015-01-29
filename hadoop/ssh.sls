openssh-server:
  pkg:
    - installed

/home/hadoop/ssh_passwordless.sh:
  file:
    - managed
    - source: salt://hadoop/ssh_passwordless.sh
    - user: hadoop
    - group: hadoop
    - mode: 744
    - require:
       - pkg: openssh-server

Run Passwordless ssh login script:
  cmd.run: 
   - name: ~/ssh_passwordless.sh
   - user: hadoop
   - require:
      - file: /home/hadoop/ssh_passwordless.sh
