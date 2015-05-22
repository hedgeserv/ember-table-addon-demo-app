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
from prepare_loans import prepare_loans_in_chunk

import requests
import json

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


def execute_js_script(browser, script):
    return browser.execute_script(script)


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


# the index starts from 1
def get_column_header_name(browser, css, index):
    columnsHeader = find_elements_by_css(browser, css)
    return columnsHeader[int(index) - 1].text


def sort_column_by_css(browser, css, index):
    columnHeaders = find_elements_by_css(browser, css)
    columnHeaders[int(index) - 1].click()


# the index starts from 1
def get_column_content(browser, css, index):
    return find_elements_by_css(browser, "div.ember-table-table-block.lazy-list-container div div div:nth-child(" + str(
        index) + ") span")


def drag_scroll_by_css(browser, offsetx, offsety):
    scroll = browser.find_element_by_css_selector("div.antiscroll-scrollbar.antiscroll-scrollbar-vertical")
    action = ActionChains(browser)
    action.click_and_hold(scroll).move_by_offset(int(offsetx), int(offsety)).release().perform()


def drag_scroll_by_css_with_times(browser, scroll_css, offsety, times):
    start = time.time()
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        eles = find_elements_by_css(world.browser, scroll_css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value > int(offsety) * int(times):
            break
        time.sleep(1)


def drag_scroll_to_top(browser, scroll_css, offsety):
    start = time.time()
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        time.sleep(5)
        eles = find_elements_by_css(world.browser, scroll_css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value == 0:
            break
        time.sleep(1)


def get_mb_request():
    text = requests.get("http://localhost:2525/imposters/8888").json()
    dumpText = json.dumps(text)
    toJson = json.loads(dumpText)['requests']
    return toJson


@step('I visit "(.*?)"$')
def visit(step, url):
    with AssertContextManager(step):
        world.browser.get(url)


@step('There are (\d+) loans')
def fill_in_textfield_by_class(step, num):
    with AssertContextManager(step):
        prepare_loans(int(num) - 2)


@step('Presenting "(.*?)"')
def list_all_loans(step, url):
    with AssertContextManager(step):
        options = {
            "the list of loans": "http://localhost:4200/fully-loaded-loans",
            "the paratiral": "http://localhost:4200/lazy-loaded-loans",
            "groups": "http://localhost:4200/groups",
        }
        get_url(world.browser, options.get(url))


@step('"(.*?)" loans should be shown in a table, from the outset')
def check_all_loans_shown(step, num):
    with AssertContextManager(step):
        options = {
            "All": 3502,
        }
        check_fields_counts_by_css(world.browser, ".ember-table-body-container .ember-table-table-row",
                                   options.get(num))


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


@step('I want to sort column with index (\d+) by css "(.*?)"')
def sort_column(step, index, css):
    with AssertContextManager(step):
        sort_column_by_css(world.browser, css, index)


@step('I want to drag scroll bar by offset (\d+) and (\d+)$')
def drag_scroll_bar_with_offset(step, offsetx, offsety):
    with AssertContextManager(step):
        drag_scroll_by_css(world.browser, offsetx, offsety)


@step('Only first and last chunk was loaded in total (\d+) in first time')
def check_loaded_chunk(step, num):
    with AssertContextManager(step):
        prepare_loans_in_chunk(50)
        get_url(world.browser, "http://localhost:4200/lazy-loaded-loans?totalCount=" + str(num))
        text = requests.get("http://localhost:2525/imposters/8888").json()
        dumpText = json.dumps(text)
        toJson = json.loads(dumpText)['requests']

        assert_true(step, len(toJson) == 2)
        assert_true(step, toJson[0]['query']['page'] == str(int(num) / 50))
        assert_true(step, toJson[1]['query']['page'] == "1")


@step(
    'Scroll bar by offset (\d+) with (\d+) times to load next chunks in total (\d+) and drag scroll bar to top without rerender')
def check_next_chunk_loaded(step, offsety, times, num):
    chunk = 50
    scroll_css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"

    prepare_loans_in_chunk(chunk)
    get_url(world.browser, "http://localhost:4200/lazy-loaded-loans?totalCount=" + str(num))

    # drag scroll bar by css with parameter times
    drag_scroll_by_css_with_times(world.browser, scroll_css, offsety, times)

    # check the chunk loaded time, it's related with how many times customer drag scroll bar with certain offset
    assert len(get_mb_request()) == int(times) + 2
    drag_scroll_to_top(world.browser, scroll_css, -int(offsety))

    # check the chunck shouldn't be rendered when customer drag scroll bar back to top
    assert len(get_mb_request()) == int(times) + 2


@step('The page should style for entire group, each column, first column and last column')
def check_fields_class_by_css(step):
    with AssertContextManager(step):
        group_element = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(1)")')
        assert_true(step, group_element[0].text == "Group1")
        group_element = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(1)").parent().parent()')
        class_info = group_element[0].get_attribute("class")
        assert_true(step, "text-red" in class_info)

        first_column = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(2)")')
        assert_true(step, first_column[0].text == "Activity")
        first_column = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(2)").parent().parent()')
        class_info = first_column[0].get_attribute("class")
        assert_true(step, "text-blue" in class_info)
        assert_true(step, "bg-gray" in class_info)

        last_column = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(3)")')
        assert_true(step, last_column[0].text == "status")
        last_column = execute_js_script(world.browser, 'return $("span.ember-table-content:eq(3)").parent().parent()')
        class_info = last_column[0].get_attribute("class")
        assert_true(step, "text-blue" in class_info)
        assert_true(step, "bg-lightgray" in class_info)