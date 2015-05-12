from lettuce import *
from lettuce_webdriver.util import AssertContextManager

import os,sys,inspect
current_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0,parent_dir)
from prepare_loans import prepare_loans


def find_field_by_id(browser, attribute):
    elems = browser.find_elements_by_id(attribute)
    return elems[0] if elems else False


def get_url(browser, url):
    browser.get(url)


def check_fields_counts_by_css(browser, css, num):
    elements = browser.find_elements_by_css_selector(css)
    assert len(elements) == num


@step('There are 3502 loans')
def fill_in_textfield_by_class(step):
    with AssertContextManager(step):
        prepare_loans(3500)


@step('Presenting the list of loans')
def list_all_loans(step):
    with AssertContextManager(step):
        get_url(world.browser, "http://localhost:4200/fully-loaded-loans")


@step('All loans should be shown in a table, from the outset')
def check_all_loans_shown(step):
    with AssertContextManager(step):
        check_fields_counts_by_css(world.browser, ".ember-table-body-container .ember-table-table-row", 3502)


@step('The page load time should be longer than ten seconds')
def wait_page_load(step):
    with AssertContextManager(step):
        # TODO: the wait time will be implemented in future
        pass



