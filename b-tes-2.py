# coding: utf-8

import random
import json

brain_path = '.new_bot/brain'
try:
    brain_f = open(brain_path, 'r')
    brain_data = brain_f.readline()
    brain = json.loads(brain_data)
except Exception as e:
    # print(e)
    brain = {}


def up_brain(new_brain):
    update_brain = open(brain_path, 'w')
    # update_brain.write(new_brain)
    update_brain.write(str(json.dumps(brain)))
    update_brain.close()


while 1 == 1:
    s = ''
    word_1 = input('>>> ')
    if(word_1 == '' or word_1 == ' '):
        continue
    elif(word_1[:4] == 'هههه'):
        print(random.choice(brain[word_1[0:4]]))
    else:
        if(word_1.split(' ')[0] == 'تعلم' or word_1.split(' ')[0] == 'teach'):
            for i in range(1, len(word_1.split(' '))):
                if(i == len(word_1.split(' ')) - 1):
                    s += word_1.split(' ')[i]
                else:
                    s += word_1.split(' ')[i] + " "
            answer = input('شو بدك رد عليها؟ >>> ')
            new_brain = {s: [answer]}
            try:
                for answers in brain[s]:
                    new_brain[s].append(answers)
                brain.update(new_brain)
                up_brain(brain)
            except:
                brain.update(new_brain)
                up_brain(brain)
                pass
        else:
            try:
                resp = random.choice(brain[word_1])
                print(resp)
            except:
                word_2 = input('ما علمتني عليها .. شو لازم رد ؟ >>> ')
                new_brain = {word_1: [word_2]}
                brain.update(new_brain)
                up_brain(brain)
                pass
