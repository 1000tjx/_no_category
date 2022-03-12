from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
import random
import pickle


class TravianManager:
    def __init__(self, server, driver_name='chrome'):
        self.server = server.strip().rstrip('/')
        self.drivername = driver_name
        self.init_driver()
        self.conf_file = self.server.replace('.', '_').replace('https://', '') + '_config.json'  # noqa

    def init_driver(self):
        if self.drivername == 'chrome':
            opts = Options()
            opts.add_argument("user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36")  # noqa
            opts.add_argument("--start-maximized")
            # opts.add_argument('--headless')
            opts.add_experimental_option("excludeSwitches", ['enable-automation'])  # noqa
            self.driver = webdriver.Chrome('./chromedriver', options=opts)
        else:
            fp = webdriver.FirefoxProfile()
            fp.set_preference("general.useragent.override", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36")  # noqa
            self.driver = webdriver.Firefox(executable_path='./geckodriver')
            self.driver.maximize_window()

    def login(self, username, password):
        self.driver.get(self.server + '/login.php')
        time.sleep(2)
        self.driver.find_element_by_xpath('//input[@name="name"]').send_keys(username)  # noqa
        self.driver.find_element_by_xpath('//input[@name="password"]').send_keys(password)  # noqa
        self.driver.find_element_by_xpath('//input[@name="lowRes"]').click()
        self.driver.find_element_by_xpath('//button[@id="s1"]').click()
        errors = self.driver.find_elements_by_class_name('error')
        if(len(errors) > 0):
            return False
        return True

    def get_farm_lists(self):
        self.driver.get(self.server + '/build.php?id=39&gid=16&tt=99')
        time.sleep(3)

        raid_lists = self.driver.find_elements_by_class_name('raidList')
        my_lists = {}

        for raid_list in raid_lists:
            list_id = raid_list.get_attribute('data-listid')
            list_name = raid_list.find_elements_by_class_name('listName')[0].text  # noqa
            my_lists[list_id] = list_name
        time.sleep(5)
        return my_lists

    def auto_checker(self, lists, max_i, allow_active='n'):
        self.driver.get(self.server + '/build.php?id=39&gid=16&tt=99')
        time.sleep(8)
        for list_id, list_name in lists.items():
            time.sleep(5)
            raid_list = self.driver.find_element_by_id('raidList' + list_id)
            e_c = raid_list.find_element_by_xpath('.//div[contains(@class, "expandCollapse")]')  # noqa
            if 'collapsed' in e_c.get_attribute('class'):
                time.sleep(2)
                self.driver.execute_script(f'Travian.Game.RaidList.toggleList({list_id});')  # noqa
            trs = raid_list.find_elements_by_class_name('slotRow')
            i = 0
            time.sleep(5)
            total_checked = 0
            if allow_active == 'y':
                self.driver.execute_script(f'Travian.Game.RaidList.startRaid({list_id})')  # noqa
                print(f'[{list_id}] -> {list_name} sent!.')
                print('-' * 40)
                continue
            for tr in trs:
                lost = False
                last_raid = tr.find_elements_by_class_name('lastRaid')[0].find_elements_by_tag_name('div')[0].find_elements_by_tag_name('img')  # noqa
                if len(last_raid) > 0:
                    try:
                        report = last_raid[0].get_attribute('class')
                        if 'iReport2' in report or 'iReport3' in report:
                            lost = True
                    except IndexError:
                        pass
                is_inactive = 'inactive' in tr.find_elements_by_class_name('target')[0].find_elements_by_tag_name('i')[0].get_attribute('class')  # noqa
                if is_inactive and lost is False:
                    tr.find_elements_by_tag_name('td')[0].find_elements_by_tag_name('input')[0].click()  # noqa
                    total_checked += 1
                    time.sleep(0.34 + random.random())
                i += 1
                if i == max_i:
                    break
            if total_checked > 0:
                self.driver.execute_script(f'Travian.Game.RaidList.startRaid({list_id})')  # noqa
                print(f'[{list_id}] -> {list_name} sent!.')
            else:
                print(f'[{list_id}] -> {list_name} CANNOT SEND!, nothing has been checked.')  # noqa
            print('total checked:', total_checked, ', total rows:', i)
            print('-' * 40)

    def find_farms(self, min_pop=8, max_pop=20, load=True, save=True):
        farms_file = self.server.replace('.', '_').replace('://', '_') + '_farms'  # noqa
        if load:
            print('Loading farms...')
            self.farms = pickle.load(open(farms_file, 'rb'))
            print('Farms loaded.')
            print('Farms count:', len(self.farms))
            return self.farms
        self.driver.get(self.server + '/statistics/player')
        time.sleep(2)
        self.driver.find_elements_by_class_name('last')[0].click()
        players_pages_count = int(self.driver.current_url.split('=')[-1])

        time.sleep(3)
        self.driver.get(self.server + '/statistics/village')
        time.sleep(2)
        self.driver.find_elements_by_class_name('last')[0].click()
        villages_pages_count = int(self.driver.current_url.split('=')[-1])

        players = {}
        total_villages_in_loop = 0
        villages = {}

        for i in range(players_pages_count, 0, -1):
            self.driver.get(self.server + '/statistics/player?page=' + str(i))
            time.sleep(2)
            trs = self.driver.find_element_by_id('player').find_elements_by_tag_name('tbody')[0].find_elements_by_tag_name('tr')  # noqa
            for tr in trs:
                player_name = tr.find_elements_by_class_name('pla')[0].text.replace('\n', '').strip()  # noqa
                player_pop = int(tr.find_elements_by_class_name('pop')[0].text.replace('\n', '').strip())  # noqa
                if min_pop <= player_pop <= max_pop:
                    players[player_name] = player_pop
            if player_pop > max_pop:
                break
            time.sleep(3 + random.randint(2, 6) + random.random())

        player_pop = 0

        for i in range(villages_pages_count, 0, -1):
            self.driver.get(self.server + '/statistics/village?page=' + str(i))
            time.sleep(2)
            trs = self.driver.find_element_by_id('villages').find_elements_by_tag_name('tbody')[0].find_elements_by_tag_name('tr')  # noqa
            for tr in trs:
                total_villages_in_loop += 1
                player_name = tr.find_elements_by_class_name('pla')[0].text.replace('\n', '').strip()  # noqa
                village_name = tr.find_elements_by_class_name('vil')[0].text.replace('\n', '').strip()  # noqa
                if player_name not in players:
                    continue
                else:
                    player_pop = players.get(player_name, 9999999)
                    if min_pop <= player_pop <= max_pop:
                        vil_co = tr.find_elements_by_class_name('coords')[0].text.strip()[2:-2]  # noqa
                        splitted = vil_co.split('‬‬|')
                        if len(splitted) == 1:
                            splitted = vil_co.split('|')
                        x = splitted[0].replace('\u202d', '').replace('\u202c', '').replace('−', '-')  # noqa
                        y = splitted[1].replace('\u202d', '').replace('\u202c', '').replace('−', '-')  # noqa
                        villages[player_name] = {
                            'player': player_name,
                            'player_pop': player_pop,
                            'village_name': village_name,
                            'x': int(x),
                            'y': int(y)
                        }
            if player_pop > max_pop or total_villages_in_loop > len(players.keys()):  # noqa
                break
            time.sleep(3 + random.randint(2, 6) + random.random())
        self.farms = villages
        if save:
            print('Saving farms...')
            pickle.dump(self.farms, open(farms_file, 'wb'))
            print('Farms saved.')
        print('Farms count:', len(self.farms))
        return self.farms

    def calc_dist(self, co1, co2):
        return round(((co1[0] - co2[0])**2 + (co1[1] - co2[1])**2) ** 0.5, 1)

    def add_farms(self, from_co, fl_id, from_i, to_i, t, count):
        self.driver.get(self.server + '/karte.php')
        for farm in self.farms.values():
            farm['dst'] = self.calc_dist(from_co, (farm['x'], farm['y']))
        sorted_farms = sorted(list(self.farms.values()), key=lambda farm: farm['dst'])  # noqa
        for farm in sorted_farms[from_i:to_i]:
            x = farm['x']
            y = farm['y']
            self.driver.execute_script(f"Travian.Game.RaidList.addSlotPopupWrapper('{fl_id}', '{x}', '{y}'); return false;")  # noqa
            time.sleep(1)
            self.driver.find_element_by_id(t).send_keys(count)
            time.sleep(1)
            self.driver.find_element_by_id('save').click()
            time.sleep(random.randint(2, 4) + random.random())
