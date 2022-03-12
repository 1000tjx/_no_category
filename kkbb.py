# coding: utf-8

from selenium import webdriver
import selenium.common.exceptions
from time import sleep
from bs4 import BeautifulSoup as BS
import requests
import shutil
import os

sleep_time = int(input("Insert number of seconds to sleep (Depends on your connection suggest 20 ( each book ) if your connection slow): "))  # noqa
print("1 - Collect URLs from WEBSITE")
print("2 - Collect URLs from FILES")
option_u = int(input('-> '))
if(option_u is not 1 and option_u is not 2):
    print("Invalid option")
    exit()

images_folder = 'images/'
default_value = 'No'
link_class = 'product-image'
no_store_class = 'btn-out-of-stock'
td = 'product-attributes__item'
tbo_class = 'store-tbody'
main_urls = [
    {
        'url': 'http://www.jarir.com/arabic-books/engineering.html',  # noqa
        'section': 'engineering',
        'show_more': 2
    },
    {
        'url': 'http://www.jarir.com/english-books/business-management.html',  # noqa
        'section': 'business-management',
        'show_more': 1
    },
    {
        'url': 'http://www.jarir.com/arabic-books/jarir-publications-books.html',  # noqa
        'section': 'jarir-publications-books',
        'show_more': 2
    }
]


main_files = [
    {
        'file': '/home/tplinux/Downloads/www.jarir.com_27th_Oct_2017.txt',  # noqa
        'section': 'jarir-publications-books',
    },
]

post_url = 'http://www.jarir.com/jarirwebservice/index/storeavailability/'
check_id = 'availability-check-button'
driver = webdriver.PhantomJS()


def scrap_all_books(all_books, book_section):
    if(os.path.exists(book_section + '.csv') is False):
        f = open(book_section + '.csv', 'w')
        f.write('product_id,stores,title,author,price,section,publisher,key,image_name,book_ext')  # noqa
        f.close()
    for book in all_books:
        book = book.replace('\r', '').replace('\n', '')
        book_info = {
            'product_id': default_value,
            'stores': [],
            'publisher': default_value,
            'price': default_value,
            'title': default_value,
            'author': default_value,
            'key': default_value,
            'section': default_value,
            'book_ext': default_value,
            'image_name': default_value
        }
        print('scrapping "%s"...' % book)
        driver.get(book)
        sleep(2)
        if('404 Not Found' in driver.page_source):
            print('book has been deleted from website')
            continue
        if(no_store_class in driver.page_source):
            fff = open('not_exists_books.txt', 'a')
            fff.write(book + '\n')  # noqa
            fff.close()
            print("Not existst in stores")
            continue
        try:
            driver.find_element_by_id(check_id).click()
        except selenium.common.exceptions.ElementNotVisibleException:
            driver.execute_script('getElementsByClassName("availability-check__button")[0].click();')  # noqa
        sleep(sleep_time)
        bbb = BS(driver.page_source, 'html.parser')
        stores_body = bbb.find('tbody', {'class': tbo_class})
        stores = stores_body.find_all('tr')
        true_book = False
        for store in stores:
            store_info = store.find_all('td')
            store_name = store_info[0].string
            store_name = (u'' + store_name).encode('utf-8')
            store_status = store_info[2].string
            store_status = (u'' + store_status).encode('utf-8')
            if((store_name == 'الظهران' and store_status == 'متوفر')):  # noqa
                true_book = True
                book_info['stores'].append('الظهران')
            if((store_name == 'الخبر' and store_status == 'متوفر')):  # noqa
                true_book = True
                book_info['stores'].append('الخبر')
            if((store_name == 'الدمام' and store_status == 'متوفر')):  # noqa
                book_info['stores'].append('الدمام')
                true_book = True
        if(not true_book):
            fff = open('not_exists_books.txt', 'a')
            fff.write(book + '\n')  # noqa
            fff.close()
            print("Not exists in stores")
            continue
        if(true_book is True):
            print('-' * 10)
            book_info['stores'] = set(book_info['stores'])
            tds = bbb.find_all('li', {'class': td})  # noqa | infos
            price = bbb.find_all('span', {'class': 'price'})[0].text.encode('utf-8').replace('\n', '')  # noqa
            title = bbb.find('h1', {'class': 'product__name'}).text.encode('utf-8').replace('\n', '').replace(',', '-')  # noqa
            try:
                image_url = bbb.find_all('img', {'class': 'cloudzoom-gallery'})[0]['src'].replace('thumbnail/56x56', 'image/800x800')  # noqa
                image_name = image_url.split('/')[-1]
                print("downloading image '%s' ..." % image_url)
                r = requests.get(image_url, stream=True)
                if r.status_code == 200:
                    with open(images_folder + image_name, 'wb') as f:
                        r.raw.decode_content = True
                        shutil.copyfileobj(r.raw, f)
            except Exception:
                image_name = default_value
            product_id = bbb.find('span', {'itemprop': 'productID'}).string
            book_info['product_id'] = (u'' + product_id).encode('utf-8').replace('\n', '').replace(' ', '')  # noqa
            book_info['price'] = price  # noqa
            book_info['title'] = title  # noqa
            book_info['image_name'] = (u'' + image_name).encode('utf-8')  # noqa
            for tt in tds:
                div1 = tt.find_all('div')[0].string[:-1]
                div1 = (u'' + div1).encode('utf-8').replace('\n', '')
                div2 = tt.find_all('div')[1].string
                div2 = (u'' + div2).encode('utf-8').replace('\n', '').replace(',', '-')  # noqa
                if(div1 == 'المؤلف الاساسي' or div1 == 'المؤلف'):
                    book_info.update({'author': div2})
                if(div1 == 'اسم الناشر الاساسي'):
                    book_info.update({'publisher': div2})
                if(div1 == 'صيغة الكتاب'):
                    book_info.update({'book_ext': div2})
                if(div1 == 'الرقم التسلسلي الدولي الموحد'):
                    book_info.update({'key': div2})
                book_info.update({'section': book_section})
            stores_as_string = ''
            print('-' * 10)
            for k, v in book_info.iteritems():
                if(k == 'stores'):
                    for sto in v:
                        stores_as_string += sto + ' | '
                if(k != 'stores'):
                    print(k + ": " + v)
            print('-' * 10)
            print('Stores: %s' % stores_as_string)
            f = open(book_section + '.csv', 'a')
            f.write('\n%s,%s,%s,%s,%s,%s,%s,%s,%s,%s' % (book_info['product_id'], stores_as_string, book_info['title'], book_info['author'], book_info['price'], book_info['section'], book_info['publisher'], book_info['key'], book_info['image_name'], book_info['book_ext']))  # noqa
            f.close()
            print('#' * 10)
            print('Book\'s info has been saved')
            print('#' * 10 + '\n\n')
        else:
            continue


if(option_u is 1):
    for main_url in main_urls:
        books_links = []
        print('#' * 20)
        print('scrapping %s ...' % main_url['url'])
        print('#' * 20)
        driver.get(main_url['url'])
        for i in range(2, main_url['show_more'] + 1):
            print('loading more for page : %d ...' % i)
            driver.execute_script('amscroll_object.loadNextPage(%d);' % i)
            print('sleeping for %d seconds...' % sleep_time)
            print('-' * 10)
            sleep(sleep_time)

        sss = BS(driver.page_source, 'html.parser')
        all_links = sss.find_all('a', {'class': link_class})
        for link in all_links:
            href = link['href']
            books_links.append(href)
        books_count = len(books_links)
        print('*' * 15)
        print('We now have links of %d Books' % books_count)
        print('*' * 15)
        # print("LINKS:\n\n")
        # print(books_links)
        # with open('www.html', 'w') as f:
        #     print('to be sure that source code of page is correct, page source was saved in www.html')  # noqa
        #     f.write((u'' + driver.page_source).encode('utf-8'))
        #     f.close()
        # exit()
        scrap_all_books(books_links, main_url['section'])
        print("\n\nSection '%s' with URL: '%s' finished .\n\n" % (main_url['section'], main_url['url']))  # noqa


elif(option_u is 2):
    for the_file in main_files:
        urls = open(the_file['file'], 'r').readlines()
        scrap_all_books(urls, the_file['section'])
