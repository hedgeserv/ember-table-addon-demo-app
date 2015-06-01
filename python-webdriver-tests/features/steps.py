from lettuce import *

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
from prepare_loans import prepare_sort_in_chunk
import requests
import json

spanWidthPix = 1


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
    assert len(elements) == int(num)


def execute_js_script(browser, script):
    return browser.execute_script(script)


def wait_for_elem(browser, script, timeout=20):
    start = time.time()
    elems = []
    while time.time() - start < timeout:
        elems = browser.execute_script(str(script))
        if elems:
            return elems
        time.sleep(0.2)
    return elems


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
        eles = find_elements_by_css(world.browser, scroll_css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value == 0:
            break
        time.sleep(0.5)


def drag_scroll_to_bottom(browser, scroll_css, offsety):
    start = time.time()
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        eles = find_elements_by_css(world.browser, scroll_css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value > 243:
            break
        time.sleep(0.5)


def get_mb_request():
    text = requests.get("http://localhost:2525/imposters/8888").json()
    dumpText = json.dumps(text)
    toJson = json.loads(dumpText)['requests']

    return toJson


@step('I visit "(.*?)"$')
def visit(step, url):
    with AssertContextManager(step):
        world.browser.get(url)


@step('There are (\d+) loans$')
def fill_in_textfield_by_class(step, num):
    with AssertContextManager(step):
        prepare_loans(int(num) - 2)


@step('There are (\d+) loans in chunk size (\d+)$')
def there_are_loans_in_chunk(step, totalCount, chunkSize):
    with AssertContextManager(step):
        prepare_loans_in_chunk(int(totalCount), int(chunkSize))


@step('There are (\d+) sortable loans in chunk size (\d+)$')
def prepare_loans_as_asc(step, totalCount, chunkSize):
    with AssertContextManager(step):
        prepare_sort_in_chunk(int(totalCount), int(chunkSize))


@step('Presenting "(.*?)"')
def list_all_loans(step, url):
    with AssertContextManager(step):
        options = {
            "the list of loans": "http://localhost:4200/fully-loaded-loans",
            "groups": "http://localhost:4200/groups",
            "column sort": "http://localhost:4200/lazy-loaded-loans?totalCount=200",
            "column reorder": "http://localhost:4200/groups-reorder",
        }
        get_url(world.browser, options.get(url))


@step('(\d+) loans should be shown in a table, from the outset')
def check_all_loans_shown(step, num):
    with AssertContextManager(step):
        check_fields_counts_by_css(world.browser, ".ember-table-body-container .ember-table-table-row",
                                   num)


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
        # time.sleep(5)
        changedWidth = get_column_width_by_class_name(world.browser, "ember-table-header-cell", index)

        if str(rightOrLeft) == "left":
            assert_true(step, (int(changedWidth) - int(originalWidth)) == (-int(offsetx) - int(spanWidthPix)))
        else:
            assert_true(step, (int(changedWidth) - int(originalWidth)) == (int(offsetx) - int(spanWidthPix)))


@step('I want to sort column with index (\d+) by css "(.*?)"')
def sort_column(step, index, css):
    with AssertContextManager(step):
        sort_column_by_css(world.browser, css, index)


@step('Customer drags scroll bar by offset (\d+) with (\d+) times$')
def drag_scroll_bar_with_offset(step, offset, times):
    with AssertContextManager(step):
        scroll_css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
        drag_scroll_by_css_with_times(world.browser, scroll_css, offset, times)


@step('Only first and last chunk was loaded in total (\d+) in first time')
def check_loaded_chunk(step, num):
    with AssertContextManager(step):
        # prepare_loans_in_chunk(50)
        get_url(world.browser, "http://localhost:4200/lazy-loaded-loans?totalCount=" + str(num))
        text = requests.get("http://localhost:2525/imposters/8888").json()
        dumpText = json.dumps(text)
        toJson = json.loads(dumpText)['requests']

        assert_true(step, len(toJson) == 2)
        assert_true(step, toJson[0]['query']['section'] == "1")
        assert_true(step, toJson[1]['query']['section'] == str(int(num) / 50))


@step('There should be (\d+) sections loaded')
def get_loaded_section(step, num):
    assert_true(step, len(get_mb_request()) == int(num))


@step(
    'Scroll bar by offset (\d+) with (\d+) times to load next chunks in total (\d+) and drag scroll bar to top without rerender')
def check_next_chunk_loaded(step, offsety, times, num):
    # chunk = 50
    scroll_css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"

    # prepare_loans_in_chunk(chunk)
    get_url(world.browser, "http://localhost:4200/lazy-loaded-loans?totalCount=" + str(num))

    # drag scroll bar by css with parameter times
    drag_scroll_by_css_with_times(world.browser, scroll_css, offsety, times)

    # check the chunk loaded time, it's related with how many times customer drag scroll bar with certain offset
    assert len(get_mb_request()) == int(times) + 2
    drag_scroll_to_top(world.browser, scroll_css, -int(offsety))

    # check the chunck shouldn't be rendered when customer drag scroll bar back to top
    assert len(get_mb_request()) == int(times) + 2


@step('The page should style for entire group, inner column, first column and last column')
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


@step('Click to sort a column as "(.*?)"')
def click_to_sort_column(step, asc_or_desc):
    with AssertContextManager(step):
        column_css = ".ember-table-header-cell"
        find_elements_by_css(world.browser, column_css)[0].click()


@step('The "(.*?)" record should be "(.*?)"$')
def check_sort_column(step, record_index, record_content):
    with AssertContextManager(step):
        if record_index == "first":
            result = world.browser.execute_script(
                'return $($("div.ember-table-body-container div.ember-table-table-row")[' + str(
                    0) + ']).find("div div:eq(0) span").text()')
            assert_true(step, str(result).strip() == record_content)
        elif record_index == "last":
            result = world.browser.execute_script(
                'return $($("div.ember-table-body-container div.ember-table-table-row")[' + str(
                    1) + ']).find("div div:eq(0) span").text()')
            assert_true(step, str(result).strip() == record_content)
        else:
            result = world.browser.execute_script(
                'return $($("div.ember-table-body-container div.ember-table-table-row")[' + str(
                    3) + ']).find("div div:eq(0) span").text()')
            assert_true(step, str(result).strip() == record_content)


@step('Drag scroll bar to "(.*?)"')
def drag_scroll_bar(step, top_or_bottom):
    with AssertContextManager(step):
        scroll_css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
        offsety = 60
        if top_or_bottom == "bottom":
            drag_scroll_to_bottom(world.browser, scroll_css, offsety)
        else:
            drag_scroll_to_top(world.browser, scroll_css, -int(offsety))


@step('The user get the resize cursor in "(.*?)" column')
def get_column_cursor(step, column_name):
    with AssertContextManager(step):
        cursor_css = "body.ember-application"

        action_chains = ActionChains(world.browser)
        element = world.browser.execute_script(
            "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().parent().children()[1]")
        action_chains.drag_and_drop_by_offset(element, 10, 0).release().perform()

        cursor = find_elements_by_css(world.browser, cursor_css)
        style = cursor[0].get_attribute("style")
        assert_true(step, ("auto" in style) or ("resize" in style) or ("pointer" in style))
        action_chains.release()
        world.browser.refresh()


@step('The user drags the "(.*?)" on column to "(.*?)" with (\d+) pixel')
def drag_column_with_pixel(step, column_name, left_or_right, offsetx):
    with AssertContextManager(step):
        action_chains = ActionChains(world.browser)
        element = world.browser.execute_script(
            "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().parent().children()[1]")
        if left_or_right == "left":
            action_chains.drag_and_drop_by_offset(element, -int(offsetx), 0).release().perform()
        else:
            action_chains.drag_and_drop_by_offset(element, int(offsetx), 0).release().perform()


@step('Reorder an inner column "(.*?)" header to "(.*?)" with (\d+) pixel')
def reorder_column_with_pixel(step, column_name, left_or_right, offsetx):
    with AssertContextManager(step):
        chains = ActionChains(world.browser)
        wait_for_elem(world.browser, "return $('.ember-table-content-container')")
        element = world.browser.execute_script(
            "return $('.ember-table-content-container .ember-table-content:contains(" + column_name + ")')")
        if left_or_right == "left":
            chains.click_and_hold(element[0]).move_by_offset(-int(offsetx), 0).move_by_offset(-1, 0).release().perform()
        else:
            chains.click_and_hold(element[0]).move_by_offset(int(offsetx), 0).move_by_offset(-1, 0).release().perform()


@step('The "(.*?)" column width should be (\d+) pixel')
def check_column_width(step, column_name, pixel):
    with AssertContextManager(step):
        width = world.browser.execute_script(
            "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().width()")
        assert_true(step, int(width) == int(pixel))


@step('The index (\d+) should be "(.*?)" column$')
def check_reorder_column(step, index, name):
    with AssertContextManager(step):
        elements = world.browser.execute_script("return $('.ember-table-content-container')")
        list = []
        for i in range(0, len(elements)):
            column = world.browser.execute_script(
                "return $('.ember-table-content-container .ember-table-content:eq(" + str(i) + ")').text()")
            list.append(str(column).strip())
        assert_true(step, list[int(index)] == name)


@step('The "(.*?)" column sort indicator should be "(.*?)"$')
def check_sort_indicator(step, column_name, sort):
    with AssertContextManager(step):
        class_content = world.browser.execute_script(
            "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().parent().attr(\'class\')")
        options = {"none": "",
                   "asc": "sort-indicator-icon sort-indicator-icon-up",
                   "desc": "sort-indicator-icon sort-indicator-icon-down", }
        if options.get(sort) == "none":
            assert_true(step, "sort-indicator-icon" not in class_content)
        assert_true(step, options.get(sort) in class_content)
