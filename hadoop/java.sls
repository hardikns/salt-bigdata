{% if grains['os'] == 'Ubuntu' %}
java7_ppa:
  cmd.run:
    - name: add-apt-repository ppa:webupd8team/java --yes && apt-get update
    - user: root
    - unless:  "`ls -l /etc/apt/sources.list.d | grep -c webupd8team-java-trusty.list` -eq 0" 

accept-license:
  cmd.run:
    - name: echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    - unless: debconf-get-selections | grep -q shared/accepted-oracle-license-v1-1
    - user: root

jdk7:
  pkg.installed:
    - name: oracle-java7-installer
    - skip_verify: True
    - pkgrepo: apt-get
    - requires:
      - cmd: accept-license
{% endif %}
