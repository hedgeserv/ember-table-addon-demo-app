from unittest2 import TestCase
from selenium import webdriver
import os


class ChromeTest(TestCase):
    def setUp(self):
        os.system('mb restart &')

        driver_arguments = {'chrome_options': webdriver.ChromeOptions()}
        driver_arguments['chrome_options'].add_argument('--no-sandbox')
        self.driver = webdriver.Chrome(chrome_options= driver_arguments['chrome_options'])

        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()
        os.system('mb stop')

    def assert_row_count(self, row_count):
        elements = self.driver.find_elements_by_css_selector(".ember-table-body-container .ember-table-table-row")
        self.assertEqual(len(elements), row_count + 2)

    def visit(self, path):
        self.driver.get("http://localhost:4200" + path)
