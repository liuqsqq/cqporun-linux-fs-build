# -*- coding: utf-8 -*-
import socket
import json
from sys import argv


def send_bluetooth_message_2_node(ip, port, message):
    ret = True	
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_address = (ip, port)
        print 'Connecting to %s:%s.' % server_address
        sock.connect(server_address)
	print 'Sending "%s".' % message
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
    typecode = int(argv[1])
    resultcode = int(argv[2])
    bluetooth_message = {}
    bluetooth_message['type'] = typecode
    bluetooth_message['result'] = resultcode
    if typecode==3:
        bluetooth_message['dir'] = "/home/cqutprint/bluetooth_file/"
        if resultcode==1:
            bluetooth_message['filename'] =  str(argv[3])    
    bluetooth_message =  json.dumps(bluetooth_message)
    print bluetooth_message
    send_bluetooth_message_2_node("127.0.0.1", 7103, bluetooth_message)

