# coding: utf-8

from  more_itertools import unique_everseen  # noqa
from bs4 import BeautifulSoup as BS  # noqa
from time import sleep
import requests as rq
import json
import uuid
import os

# IMPORTANT LIBRARY
# 1 - more_itertools
# 2 - bs4
# 3 - requests

# If you are using linux set linux to True value to using tor service
linux = False
# command in your linux distro to START tor
start_tor_command = "systemctl start tor"
# command in your linux distro to RE-START tor
restart_tor_command = "systemctl restart tor"
if(linux is True):
    os.system(start_tor_command)
print("\n\nPlease Select Option:\n\n")
print("[1] - Implicit message")
print("[else option] - Default mode\n")
user_option = input("option >>> ")

msgs_url = "https://khamsat.com/messages"
source_url_to_check = msgs_url

cookie_list = [
    "Cookie1",
    "Cookie2",
    "Cookie3"
]

get_he = {  # noqa
    'Host': "khamsat.com",
    'User-Agent': "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0",
    'Accept': "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    'Accept-Language': "en-US,en;q=0.5",
    'Accept-Encoding': "gzip, deflate, br",
    'Connection': "keep-alive",
    'Upgrade-Insecure-Requests': "1",
    'Cache-Control': "max-age=0",
}

last_part = '/?show=recent'
parts = [
    ['business', '3'],
    ['consulting', '1'],
    ['programming', '5'],
    ['training', '6'],
    ['marketing', '8'],
    ['designing', '7'],
    ['technology', '4'],
    ['misc', ''],
    ['writing', '9'],
]
s = rq.Session()

# implicit msgs
if(user_option == '1'):
    number_of_each_msg = 10
    try:
        number_of_each_msg = int(input("Number of msg into each msg (Just Integer): "))
    except Exception:
        print("Error You entered a string ...")
        print("Setting to default 10 each msg")
        number_of_each_msg = 10

    for cookie in cookie_list:
        get_he["Cookie"] = cookie
        msgs_page_source = s.get(msgs_url, headers=get_he).content.decode('utf-8')
        pm = BS(msgs_page_source, "html.parser")
        msgs_table = pm.find("table", {"id": "messages_table"})
        all_msgs_urls_list = msgs_table.findAll("tr", {"class", "message"})
        msgs_urls = []
        for msg_id in all_msgs_urls_list:
            msg_id = msg_id['id']
            msg_id = msg_id[msg_id.find('-') + 1:]
            msg_href = msgs_url[:-1] + "/" + msg_id
            # print(msgs_url[:-1] + "/" + msg_id)
            msgs_urls.append(msg_href)
            pass
        # print(msgs_urls)
        i = 1
        while(i <= number_of_each_msg):
            sleep(5)
            for m_url in msgs_urls:
                msg_page = s.get(m_url, headers=get_he).content.decode('utf-8')
                pm = BS(msg_page, 'html.parser')
                token = pm.find("input", {"id": "user_token"})['value']
                # print(token)
                unique_msg = str(uuid.uuid4())
                sleep(4)
                msg_data = {
                    "content": unique_msg,
                    "confirm": '0',
                    "confirm2": '0',
                    "token": token
                }
                send_msg = s.post(m_url, headers=get_he, data=msg_data).content.decode('utf-8')
                resp = s.get(m_url, headers=get_he).content.decode('utf-8')
                if(unique_msg in resp):
                    print("Msg sent")
                else:
                    print("Unable to send Msg")
                pass
            i += 1
        print("\nChanging account ...\n\n")
    print("\nFinished!\n\n")
    exit()

pages_each_part = int(input("Insert number of pages each part : "))
for cookie in cookie_list:
    done_msg = True
    get_he["Cookie"] = cookie
    for the_part in parts:
        ids = []
        part = the_part[0]
        print(part)
        check = s.get(source_url_to_check, headers=get_he).content.decode('utf-8')
        # print(check)
        # exit()
        for p_n in range(pages_each_part + 1):
            if(p_n == 0):
                continue
            c_num = the_part[1]
            if(part != 'misc'):
                pages_data = [
                    ('c[]', str(c_num)),
                    ('dt', ""),
                    ('so', "false"),
                    ('sr', ""),
                    ('page', str(pages_each_part)),
                    ('no_keyword', "true"),
                    ('show', "recent")
                ]
            else:
                pages_data = {
                }
            section_url = 'https://khamsat.com/' + part + last_part
            sec_source = s.get(section_url, headers=get_he).content.decode('utf-8')
            # exit()
            sec_elements = BS(sec_source, 'html.parser')
            all_ids = sec_elements.find('div', {'class': 'services_block_list'}).findAll('div')
            for the_id in all_ids:
                from_index = the_id['id'].find('-') + 1
                real_id = the_id['id'][from_index:]
                ids.append(real_id)

            for service in ids:
                new_data = ('service_ids[]', str(service))
                pages_data.append(new_data)

            show_more = s.post('https://khamsat.com/ajax/load_more/search/no_keyword', headers=get_he, data=pages_data).content.decode('utf-8')
            show_more = json.loads(show_more)
            show_more = show_more['content']
            sec_elements = BS(show_more, 'html.parser')
            all_ids = sec_elements.findAll('div')
            for the_id in all_ids:
                from_index = the_id['id'].find('-') + 1
                real_id = the_id['id'][from_index:]
                ids.append(real_id)
            sleep(3)
        ids = list(unique_everseen(ids))
        # print(ids)
        for msg_id in ids:
            msg_url = 'https://khamsat.com/message/new/' + str(msg_id)
            m = s.get(msg_url, headers=get_he).content.decode('utf-8')
            bs = BS(m, 'html.parser')
            title = bs.find('input', {'name': 'title', 'readonly': 'readonly', 'maxlength': '60'})['value']
            user_token = bs.find('input', {'id': 'user_token', 'type': 'hidden'})['value']
            content = str(uuid.uuid4())
            msg_data = {
                'title': title,
                'content': content,
                'confirm': "0",
                'confirm2': "0",
                'token': user_token
            }
            print("Title: " + title)
            print("Service Number: " + str(msg_id))
            print("Token: " + user_token)
            msg_posted = s.post(msg_url, headers=get_he, data=msg_data).content.decode('utf-8')
            if('بنجاح!' in msg_posted):
                print('Status: Msg Sent!')
                print("-----")
                done_msg = False
            else:
                done_msg = True
                print('Status: Unable to send Msg!')
                print("-----")
                break
            sleep(3)
        sleep(4)
        if(done_msg):
            if(linux is True):
                print("\n\nChanging IP ...")
                os.system(restart_tor_command)
                sleep(10)
            print("Changing account ...\n\n")
            break
print("\nFinished!\n")
