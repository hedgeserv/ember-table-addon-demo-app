from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class Driver:
    def __init__(self, server_host):
        self._server_host = server_host
        self._driver = webdriver.Chrome()
        self._driver.implicitly_wait(10)

    def get(self, path):
        self._driver.get(self._server_host + path)

    def find_element_by_css_selector(self, css_selector):
        return self._driver.find_element_by_css_selector(css_selector)

    def find_elements_by_css_selector(self, css_selector):
        return self._driver.find_elements_by_css_selector(css_selector)

    def click_by_css_selector(self, css_selector):
        first_row_elem = driver.find_element_by_css_selector(css_selector)
        ActionChains(self._driver) \
            .move_to_element(first_row_elem).click(first_row_elem).perform()

    def drag_element_to(self, css_selector, x, y):
        scroll_bar = driver.find_element_by_css_selector(css_selector)
        actions = ActionChains(self._driver)
        actions.move_to_element(scroll_bar)
        actions.drag_and_drop_by_offset(scroll_bar, x, y)
        actions.perform()

    def close(self):
        self._driver.close()

def scroll_down_to_last_row(driver):
    driver.click_by_css_selector(".ember-table-body-container .ember-table-table-block > div:first-child")
    driver.drag_element_to(".antiscroll-scrollbar-shown", 0, 500)

def select_row_number_of_last_row(driver):
    row_elems = driver.find_elements_by_css_selector(".ember-table-body-container .ember-table-table-block > div")
    last_row_elem = max(row_elems, key= lambda e: e.value_of_css_property("top"))
    row_number_cell_elem = last_row_elem.find_element_by_css_selector("div > div:first-child > .ember-table-content")
    return row_number_cell_elem


driver = Driver("http://localhost:4200")
try:
    driver.get("/loans")

    scroll_down_to_last_row(driver)
    row_number_cell_elem = select_row_number_of_last_row(driver)

    assert "3500" in row_number_cell_elem.text
finally:
    driver.close()
