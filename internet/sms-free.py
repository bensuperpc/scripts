#!/usr/bin/env python3
#//////////////////////////////////////////////////////////////
#//   ____                                                   //
#//  | __ )  ___ _ __  ___ _   _ _ __   ___ _ __ _ __   ___  //
#//  |  _ \ / _ \ '_ \/ __| | | | '_ \ / _ \ '__| '_ \ / __| //
#//  | |_) |  __/ | | \__ \ |_| | |_) |  __/ |  | |_) | (__  //
#//  |____/ \___|_| |_|___/\__,_| .__/ \___|_|  | .__/ \___| //
#//                             |_|             |_|          //
#//////////////////////////////////////////////////////////////
#//                                                          //
#//  Script, 2021                                            //
#//  Created: 30, July, 2021                                 //
#//  Modified: 30, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://mobile.free.fr/account/mes-options/notifications-sms                                                //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

import urllib
from urllib import parse, request
import sys

if len(sys.argv) <= 3:
    print("Need more arguments: <user> <API key> <Message (in quotes)>")
    exit(1)

user = sys.argv[1]
key = sys.argv[2]
msg = sys.argv[3]

payload = { 'user' : user, 'pass' : key, 'msg' : msg}
url = "https://smsapi.free-mobile.fr/sendmsg?"

full_url = url + urllib.parse.urlencode(payload)

try:
    response = urllib.request.urlopen(full_url)
    code = response.getcode()
    print('Return code:', code)

except Exception as e:
    print(f'Error:  {full_url} : {str(e)}')
