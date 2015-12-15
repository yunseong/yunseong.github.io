#!/usr/bin/env python
import paramiko
import random
import time
import sys
import getopt
import collections

# Take user's input for hosts, processName, probability
def main(argv):
  try:
    opts, args = getopt.getopt(argv, "hp:i:u:k:n:")
  except getopt.GetoptError:
    print 'prempt.py -p <probability> -i <interval> -u <username> -k <key>'
    sys.exit(2)

  for opt, arg in opts:
    if opt == '-h':
      print 'prempt.py -p <probability> -i <interval> -u <username> -k <key> -n <process_name>'
      sys.exit()
    elif opt == '-p':
      probability = float(arg)
    elif opt == '-i':
      interval = int(arg)
    elif opt == '-u':
      username = arg
    elif opt == '-k':
      password = arg
    elif opt == '-n':
      processName = arg

  print 'Probability: ', probability
  print 'Interval: ', interval 

  hosts = [41,42,44,46,47,48,49,50,52,53,55,56]
  counter = dict()

  while True:
    candidates = chooseCandidates(hosts, probability)
    preempt(candidates, counter, username, password, processName)
    print collections.OrderedDict(sorted(counter.items()))
    time.sleep(interval)

def chooseCandidates(hosts, probability):
  numHosts = len(hosts)
  numToChoose = (int)(numHosts * probability)
  candidate = random.sample(set(hosts), numToChoose)
  return candidate

def preempt(candidates, counter, username, password, processName):
  print 'Preempt!'
  for hostNum in candidates:
    hostNumStr = str(hostNum)
    if counter.has_key(hostNumStr):
      counter[hostNumStr] += 1 
    else:
      counter[hostNumStr] = 1

    server = "host-"+hostNumStr

    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(server, username=username, password=password)
    # shell script execute
    stdin, stdout, stderr = ssh.exec_command("/tmp/preemption.sh "+processName)
    ssh.close()

if __name__ == "__main__":
  main(sys.argv[1:]) 
