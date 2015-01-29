if [ `cat ~/.ssh/authorized_keys |grep -c hadoop` -eq 0 ] 
then 
  echo y | ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
  cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
  ssh localhost -o StrictHostKeyChecking=no ls
  ssh 0.0.0.0 -o StrictHostKeyChecking=no ls
fi

