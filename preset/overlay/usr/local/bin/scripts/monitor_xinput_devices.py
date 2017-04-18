# -*- coding: utf-8 -*-
import socket
from sys import argv
ip = "127.0.0.1"
port = 12332
def send_xinput_events_2_daemon(message):
    ret = True
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_address = (ip, port)

        sock.sendto(message, server_address)
        print 'Closing socket.'
        sock.close()
    except Exception as e:
        ret = False
    finally:
        if not ret:
            return -1
    return 0
if __name__ == "__main__":
    if argv[1] == "add":
        message="\x00\x03\x00\x05\x00\x06\x00\x01\x01"
    elif argv[1] == "remove":
        message="\x00\x03\x00\x05\x00\x06\x00\x01\x00"
    ret = send_xinput_events_2_daemon(message)
    if ret != -1:
        print 'send successfull'
    else:
	print 'send failed'
