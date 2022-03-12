import json
from Engine import TravianManager as TM
from getpass import getpass
import time
import random

try:
    last_login = json.load(open('last_login.json', 'r', encoding='utf-8-sig'))  # noqa
except FileNotFoundError:
    last_login = {'servers': [], 'users': []}
except json.decoder.JSONDecodeError:
    last_login = {'servers': [], 'users': []}

servers = {str(i): ser for i, ser in enumerate(last_login['servers'])}
users = {str(i): u for i, u in enumerate(last_login['users'])}

while True:
    if len(servers) == 0:
        print('There is no servers in history')
    else:
        print('Servers history:')
        for i, s in servers.items():
            print(f"[{i}]- {s}")
    server = input('Please enter server url / or enter id from history: ').strip()  # noqa
    if server.isnumeric() and server not in list(servers.keys()):
        print('\n' * 2)
        print('#' * 20)
        print('ID entered is not in history list.')
        print('#' * 20)
    elif server.isnumeric() and server in list(servers.keys()):
        server = servers[server]
        break
    else:
        break

print('\n' * 3)

while True:
    if len(users) == 0:
        print('There is no users in history')
    else:
        print('Users history:')
        for i, s in users.items():
            print(f"[{i}]- {s}")
    user = input('Please enter username / or enter id from history: ').strip()  # noqa
    if user.isnumeric() and user not in list(users.keys()):
        print('#' * 20)
        print('ID entered is not in history list.')
        print('#' * 20)
    elif user.isnumeric() and user in list(users.keys()):
        user = users[user]
        break
    else:
        break

# save data
if server not in last_login['servers']:
    last_login['servers'].append(server)
if user not in last_login['users']:
    last_login['users'].append(user)
json.dump(last_login, open('last_login.json', 'w', encoding='utf-8-sig'), indent=4)  # noqa


tm = None
loggedIn = False

while loggedIn is False:
    password = getpass()
    if tm is None:
        tm = TM(server)
    loggedIn = tm.login(user, password)
    if not loggedIn:
        print('\n\nInvalid login.\n\n')
    else:
        print("=" * 20)
        print("Logged in!")
        print("=" * 20)
        break

print('loading farm lists...')
my_lists = tm.get_farm_lists()
if len(my_lists) == 0:
    print('Please create farm list first')
    exit()

print("Farm lists:")
for l_id, l_name in my_lists.items():
    print(f"[{l_id}] -> {l_name}")

ids = input("Please enter farms id (ex: 1,2,3,4 ..., all): ")
lists = my_lists
if ids != 'all':
    lists = {l_id: my_lists[l_id] for l_id in ids.split(',')}

allow_active = input('Allow active [re-send raid to village already under your raids] ? (y, n) default (n): ').strip()  # noqa
if allow_active == '':
    allow_active = 'n'

if allow_active == 'n':
    max_i = int(input('How many villages you want to check each farm list ?: ').strip())  # noqa
else:
    max_i = 100

resend_every = input('Resend raids every X minutes / integer only [default is 25]: ').strip()  # noqa
if resend_every == '':
    resend_every = 25
else:
    resend_every = int(resend_every)


def run():
    try:
        tm.auto_checker(lists, max_i, allow_active)
    except KeyboardInterrupt:
        exit()
    except Exception:
        print('#' * 10)
        print('Something went wrong.')
        print("retrying ...")
        print('#' * 10)
        return run()
    print('sleeping...')
    time.sleep(resend_every * 60 + random.randint(10, 300) + random.random())  # noqa
    run()


run()
