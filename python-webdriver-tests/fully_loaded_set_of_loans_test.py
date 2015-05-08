from selenium import webdriver
from unittest2 import TestCase
from prepare_loans import prepare_loans
import time


class _BaseTest(TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()


class TestFullLoadedSetOfLoans(_BaseTest):
    def test_homepage(self):
        prepare_loans(3500)
        self.driver.get('http://localhost:4200/fully-loaded-loans')
        elements = self.driver.find_elements_by_css_selector(".ember-table-body-container .ember-table-table-row")
        time.sleep(120)
        assert 3502 == len(elements)
