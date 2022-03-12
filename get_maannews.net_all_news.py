# coding: utf-8

from bs4 import BeautifulSoup as BS
import requests as rq

# Save directory
folder = ""

url = "http://maannews.net/"
part1 = "ViewPage.aspx?p="
part_list = [
    'NEW',
    'ECO',
    'PRI',
    'SPO',
    'MUR',
    'DIA',
    'REG',
    'ISR',
    'JER',
    'RAM',
    'BET',
    'HEB',
    'NAB',
    'JRC',
    'TUL',
    'JEN',
    'QAL',
    'TUB',
    'SAL',
    'GAZ',
    '48',
]
he = {
    "Accept-Encoding": "gzip, deflate"
}
try:
    v_ids = open(folder + 'visited.txt', 'r')
    visited_ids = v_ids.read()
    v_ids.close()
except:
    visited_ids = ""
    pass
visited_ids = visited_ids.split('\n')
for part2 in part_list:
    # print(visited_ids)
    # print(part2)
    the_http = url + part1 + part2
    urls = rq.get(the_http, headers=he).content
    source = BS(urls, 'html.parser')
    newslist = source.findAll("div", {"class": "newslist"})[0].findAll("li")
    for news in newslist:
        part = news.findAll('a')[0]['href']
        title = news.findAll('a')[0].text[:news.findAll('a')[0].text.find('نشر بتاريخ:')]
        title = title.replace("'", "-")
        title = title.replace('"', '-')
        title = title.replace(':', '---')
        # Url of news
        href = url + part
        the_id = part[part.find('=') + 1:]
        if(the_id in visited_ids):
            print("The Title: " + "%s" % title + " Is already visited")
            print("URL: " + href)
            print('---------------------------------------')
            continue
        into_news_source = rq.get(href, headers=he).text
        into_news = BS(into_news_source, 'html.parser')
        # Content of news
        content = str(into_news.findAll("div", {"class": "BodyDiv"})[0].text)
        content = content.replace("'", "-")
        content = content.replace('"', "-")
        if content == "":
            content = "no content"
        new_file = open(folder + title + '.txt', encoding='utf-8', mode='w')
        # print(1)
        # print(content)
        new_file.write(content)
        # print(2)
        new_file.close()
        print("Saved:")
        print(title)
        print(href)
        print('------------------')
        visited_file = open(folder + 'visited.txt', 'a')
        visited_file.write(the_id + '\n')
        visited_file.close()
        # print(title)
        # print(content)
print('---------')
