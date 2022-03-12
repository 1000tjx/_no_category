# coding: utf-8

from __future__ import print_function
import random
import json
import sys

reload(sys)
sys.setdefaultencoding("utf-8")

b_path = 'brain.txt'

# get data as brain ( json data)
f = open(b_path, 'r')
json_data = f.readlines()[0]
f.close()

d = json.loads(json_data)

user_option = None


def save_data(data):
    f = open(b_path, 'w')
    f.write(str(json.dumps(data)))
    f.close()


while(user_option != "q"):
    user_option = raw_input("[q]  quit, [i] insert new statements, Am listening : ").lower()
    if(user_option != "q" and user_option != 'i'):
        try:
            resp = d[user_option]
            print(random.choice(resp))
        except KeyError:
            user_option = raw_input("I can't understand you ! , can you teach me ? [n/y]: ")
            if(user_option.lower() == "n"):
                print("\nOk i will be very very sad for that :( \n\n")
                pass
            elif(user_option.lower() == 'y'):
                word = raw_input("Insert word you need: ")
                word_resp = raw_input("resp: ")
                new_data = {word: [
                    word_resp
                ]}
                d.update(new_data)
                save_data(d)
            pass
    elif(user_option.lower() == 'i'):
        word = raw_input("Insert word: ")
        word_resp = raw_input("resp: ")
        try:
            to_append = d[word]  # d["oo"] -> kkk
            to_append.append(word_resp)
            save_data(d)
        except KeyError:
            new_key = {word: [word_resp]}
            d.update(new_key)
            save_data(d)
            pass
    else:
        print("\n\nExited\n")
        break
