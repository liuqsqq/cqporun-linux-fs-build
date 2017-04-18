#!/usr/bin/env python
# coding=utf-8
import json
import copy
import socket
from bluetooth import *

def discover_bluetooth_device():
    nearby_devices = discover_devices(2, lookup_names = True)
    devicesDict = {}
    print "found %d devices" % len(nearby_devices)

    devicesDict['num'] = int(len(nearby_devices))
    devicesDict['type'] = 1
    devicesArray = []
    tempDevicesDict = {}
    for name, addr in nearby_devices:
        tempDevicesDict['name'] = addr
        tempDevicesDict['mac'] = name
        devicesArray.append(copy.deepcopy(tempDevicesDict))
        tempDevicesDict.clear()
    devicesDict['devices'] = devicesArray

    print devicesArray
    print devicesDict
    return devicesDict


def send_bluetooth_message_2_node(ip, port, message):
    ret = True  
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	server_address = (ip, port)
	print 'Connecting to %s:%s.' % server_address
	sock.connect(server_address)
	print message
	sock.sendall(message)
	print 'Closing socket.'
        sock.close()
    except Exception as e:
        ret = False 
    finally:
	if not ret:
            return -1
    return 0

if __name__ == "__main__":
    bluetooth_message = discover_bluetooth_device()
    print bluetooth_message
    bluetooth_message = json.dumps(bluetooth_message)
    send_bluetooth_message_2_node("127.0.0.1", 7103, bluetooth_message)
