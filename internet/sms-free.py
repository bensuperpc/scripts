#!/usr/bin/env python
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
#//  Source: https://mobile.free.fr/account/mes-options/notifications-sms     //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

import urllib
from urllib import parse, request
import sys

if len(sys.argv) <= 3:
    print('Need more arguments: <user> <API key> <Message (in quotes)>')
    print('ex: sms-free 01234567 aBcDE012345fgH "Hello world!"')
    sys.exit(1)

user = sys.argv[1]
key = sys.argv[2]
msg = sys.argv[3]

payload = {'user':user, 'pass':key, 'msg':msg}
URL = "https://smsapi.free-mobile.fr/sendmsg?"

FULL_URL = URL + urllib.parse.urlencode(payload)

req = urllib.request.Request(FULL_URL)
with urllib.request.urlopen(req) as response:
    print('Return code:', response.getcode())

