from lettuce import before, after, world
from selenium import webdriver
import os
import time
@before.each_scenario
def setup_browser(scenario):
    os.system('mb restart &')
    time.sleep(5)
    driver_arguments = {'chrome_options': webdriver.ChromeOptions()}
    driver_arguments['chrome_options'].add_argument('--no-sandbox')
    world.browser = webdriver.Chrome(chrome_options=driver_arguments['chrome_options'])


@after.each_scenario
def teardown_browser(scenario):
    world.browser.quit()
    os.system('mb stop')