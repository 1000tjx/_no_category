# -*- coding: utf-8 -*-

from __future__ import print_function
from time import sleep
import os

def p1():
    print('I am P1')
    sleep(1)

def p2():
    the_pid = os.fork()
    if(the_pid == 0):
        p1()
    else:
        os.waitpid(the_pid, False)
        print("I am P2")

def main_p():
    new_pid = os.fork()
    if(new_pid == 0):
        p2()
    else:
        os.waitpid(new_pid, False)
        sleep(1)
        print("I am Main")

main_p()
