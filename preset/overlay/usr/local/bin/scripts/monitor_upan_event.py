# -*- coding: utf-8 -*-
import socket
from sys import argv
import httplib 
import os


url = "127.0.0.1"
port = 8099
def send_upan_message_2_autoprint(requrl):
    ret = True	
    try:
        headerdata = {"Host":url}
        conn = httplib.HTTPConnection(url, port)
        conn.request(method="POST", url=requrl,headers = headerdata)
        response = conn.getresponse()
        res= response.read()
        print res
    except Exception as e:
        ret = False 
    finally:
        conn.close()
	if not ret:
	    return -1
    return 0

if __name__ == "__main__":
    if argv[1] == "add":
        usb_message = "uname=/media/cqutprint"
    elif argv[1] == "remove":
        usb_message = "uname="
    requrl = '/?' +  usb_message
    print usb_message
    print requrl
    send_upan_message_2_autoprint(requrl)

