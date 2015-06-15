from lettuce import before, after, world
from selenium import webdriver
import time
@before.each_scenario
def setup_browser(scenario):
    time.sleep(1)
    driver_arguments = {'chrome_options': webdriver.ChromeOptions()}
    driver_arguments['chrome_options'].add_argument('--no-sandbox')
    world.browser = webdriver.Chrome(chrome_options=driver_arguments['chrome_options'])
    world.browser.set_window_size(1024, 768)


@after.each_scenario
def teardown_browser(scenario):
    world.browser.quit()
