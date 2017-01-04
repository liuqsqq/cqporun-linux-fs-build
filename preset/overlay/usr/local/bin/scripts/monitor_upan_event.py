# -*- coding: utf-8 -*-
import socket
from sys import argv


def send_upan_message_2_node(ip, port, message):
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
    usb_message =  argv[1]
    print usb_message
    print type(usb_message)
    send_upan_message_2_node("127.0.0.1", 7102, usb_message)

