from lettuce import *

from selenium.common.exceptions import (
    StaleElementReferenceException)
from lettuce_webdriver.util import (assert_true,
                                    AssertContextManager, assert_false)
import os, sys, inspect
from selenium.webdriver import ActionChains
import time

current_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0, parent_dir)
from prepare_loans import prepare_loans

spanWidthPix = 1


def find_field_by_id(browser, attribute):
    elems = browser.find_elements_by_id(attribute)
    return elems[0] if elems else False


def get_url(browser, url):
    browser.get(url)


def find_elements_by_class(browser, className):
    elements = browser.find_elements_by_class_name(className)
    return elements


def find_elements_by_css(browser, css):
    elements = browser.find_elements_by_css_selector(css)
    return elements


def check_fields_counts_by_css(browser, css, num):
    elements = browser.find_elements_by_css_selector(css)
    assert len(elements) == num


def contains_content(browser, content):
    # Search for an element that contains the whole of the text we're looking
    # for in it or its subelements, but whose children do NOT contain that
    # text - otherwise matches <body> or <html> or other similarly useless
    # things.
    for elem in browser.find_elements_by_xpath(str(
            '//*[contains(normalize-space(.),"{content}") '
            'and not(./*[contains(normalize-space(.),"{content}")])]'
                    .format(content=content))):

        try:
            if elem.is_displayed():
                return True
        except StaleElementReferenceException:
            pass

    return False


def wait_for_elem(browser, xpath, timeout=20):
    start = time.time()
    elems = []
    while time.time() - start < timeout:
        elems = browser.find_elements_by_xpath(str(xpath))
        if elems:
            return elems
        time.sleep(0.2)
    return elems


def wait_for_content(step, browser, content, timeout=15):
    start = time.time()
    while time.time() - start < timeout:
        if contains_content(world.browser, content):
            return
        time.sleep(0.2)
    assert_true(step, contains_content(world.browser, content))


def get_column_width_by_class_name(browser, className, index):
    columns = find_elements_by_class(browser, className)
    return columns[int(index) - 1].get_attribute("style").split(";")[0].split(":")[1].split("px")[0].strip()


def drag_element_by_offset_class_name(browser, className, index, rightOrLeft, offset):
    elements = find_elements_by_class(browser, className)
    action_chains = ActionChains(browser)
    if str(rightOrLeft) == "left":
        action_chains.drag_and_drop_by_offset(elements[int(index) - 1], -int(offset), 0).perform()
    else:
        action_chains.drag_and_drop_by_offset(elements[int(index) - 1], int(offset), 0).perform()


def reorder_column_with_offset(browser, css, index, rightOrLeft, offset):
    columnsHeader = find_elements_by_css(browser, css)
    action_chains = ActionChains(browser)
    if str(rightOrLeft) == "left":
        action_chains.click_and_hold(columnsHeader[int(index) - 1]).move_by_offset(-int(offset), 0).move_by_offset(10,
                                                                                                                   0).release().perform()
    else:
        action_chains.click_and_hold(columnsHeader[int(index) - 1]).move_by_offset(int(offset), 0).move_by_offset(-10,
                                                                                                                  0).release().perform()


def get_column_header_name(browser, css, index):
    columnsHeader = find_elements_by_css(browser, css)
    return columnsHeader[int(index) - 1].text


@step('I visit "(.*?)"$')
def visit(step, url):
    with AssertContextManager(step):
        world.browser.get(url)


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


@step('I want to drag element by class "(.*?)" and the (\d+) column to "(.*?)" with (-?\d+)$')
def drag_element_offset(step, className, index, rightOrLeft, offsetx):
    with AssertContextManager(step):
        originalWidth = get_column_width_by_class_name(world.browser, "ember-table-header-cell", index)
        drag_element_by_offset_class_name(world.browser, className, index, rightOrLeft, offsetx)
        time.sleep(5)
        changedWidth = get_column_width_by_class_name(world.browser, "ember-table-header-cell", index)

        if str(rightOrLeft) == "left":
            assert_true(step, (int(changedWidth) - int(originalWidth)) == (-int(offsetx) - int(spanWidthPix)))
        else:
            assert_true(step, (int(changedWidth) - int(originalWidth)) == (int(offsetx) - int(spanWidthPix)))


@step('I want to recorder by "(.*?)" for the (\d+) column to "(.*?)" with offset (\d+)$')
def reorder_column_by_offset(step, css, index, rightOrLeft, offsetx):
    with AssertContextManager(step):
        originalHeaderName = get_column_header_name(world.browser, css, index)
        reorder_column_with_offset(world.browser, css, index, rightOrLeft, offsetx)
        changedHeaderName = get_column_header_name(world.browser, css, index)
        assert_false(step, str(originalHeaderName) == str(changedHeaderName))