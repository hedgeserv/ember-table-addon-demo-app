__author__ = 'twe'
from selenium import webdriver
from unittest import TestCase

class _BaseTest(TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(10)


    def tearDown(self):
        self.driver.quit()


class TestFullLoadedSetOfLoans(_BaseTest):
    def test_homepage(self):
        self.driver.get('http://localhost:4200/fully-loaded-loans')
        elements = self.driver.find_elements_by_css_selector(".ember-table-body-container .ember-table-table-row")
        assert 3502 == len(elements)
