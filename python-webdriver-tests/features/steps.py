import os
import inspect

from lettuce import *
from lettuce_webdriver.util import (assert_true,
                                    AssertContextManager)
from selenium.webdriver import ActionChains

import sys
import time

current_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0, parent_dir)
from prepare_loans import prepare_loans
from prepare_loans import prepare_loans_in_chunk
from prepare_loans import prepare_sort_in_chunk
from prepare_loans import prepare_grouping_data
from prepare_loans import prepare_grouped_loans

import requests
import json
import basic_opr_module as bo

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
            "inner column sort": "http://localhost:4200/groups-sort",
            "lazy load page": "http://localhost:4200/lazy-loaded-loans?totalCount=200",
            "grouping column": "http://localhost:4200/grouping-column",
            "grouping column with fixed columns": "http://localhost:4200/grouping-column-and-fixed",
            "grouping column with pluggable indicator": "http://localhost:4200/grouped-rows-with-level",
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
        originalWidth = bo.get_column_width_by_class_name(world.browser, index)
        drag_element_by_offset_class_name(world.browser, className, index, rightOrLeft, offsetx)
        changedWidth = bo.get_column_width_by_class_name(world.browser, index)

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
        bo.drag_scroll_by_css_with_times(world.browser, offset, times)


@step('Only first and last chunk was loaded in total (\d+) in first time')
def check_loaded_chunk(step, num):
    with AssertContextManager(step):
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
    get_url(world.browser, "http://localhost:4200/lazy-loaded-loans?totalCount=" + str(num))

    bo.drag_scroll_by_css_with_times(world.browser, offsety, times)
    assert len(get_mb_request()) == int(times) + 2

    bo.drag_scroll_to_top(world.browser, -int(offsety))
    assert len(get_mb_request()) == int(times) + 2


@step('The page should style for entire group, inner column, first column and last column')
def check_fields_class_by_css(step):
    with AssertContextManager(step):
        assert_true(step, "text-red" in bo.get_grouped_column_css(world.browser, "Group1"))
        assert_true(step, "text-blue" in bo.get_grouped_column_css(world.browser, "Activity"))
        assert_true(step, "bg-gray" in bo.get_grouped_column_css(world.browser, "Activity"))
        assert_true(step, "text-blue" in bo.get_grouped_column_css(world.browser, "status"))
        assert_true(step, "bg-lightgray" in bo.get_grouped_column_css(world.browser, "status"))


@step('Click to sort as "(.*?)" for column "(.*?)"$')
def click_to_sort_column(step, asc_or_desc, column_name="Id"):
    with AssertContextManager(step):
        bo.sort_column(world.browser, column_name)


@step('The "(.*?)" record should be "(.*?)"$')
def check_sort_column(step, record_index, record_content):
    with AssertContextManager(step):
        if record_index == "first":
            result = bo.get_record_content(world.browser, 0)
            assert_true(step, str(result) == record_content)
        elif record_index == "last":
            result = bo.get_record_content(world.browser, 1)
            assert_true(step, str(result) == record_content)
        else:
            result = bo.get_record_content(world.browser, 3)
            assert_true(step, str(result) == record_content)


@step('Drag scroll bar to "(.*?)"')
def drag_scroll_bar(step, top_or_bottom):
    with AssertContextManager(step):
        offsety = 60
        if top_or_bottom == "bottom":
            bo.drag_scroll_to_bottom(world.browser, offsety)
        else:
            bo.drag_scroll_to_top(world.browser, -int(offsety))


@step('Drag horizontal scroll bar with (\d+) pixel$')
def drag_horizontal_scroll_bar(step, offsetx):
    with AssertContextManager(step):
        bo.drag_horizontal_offset(world.browser, offsetx)


@step('The column header block should has "(.*?)" and same as body scroll left$')
def check_header_scroll_left(step, name):
    with AssertContextManager(step):
        start = time.time()
        flag = False
        while time.time() - start < 20:
            if int(bo.get_head_block_scroll_left(world.browser)) == int(bo.get_body_scroll_left(world.browser)):
                flag = flag or True
                break
            time.sleep(0.2)
        assert_true(step, flag)


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
        if str(column_name) == "GroupingColumn":
            bo.resize_column_by_index(world.browser, 0, left_or_right, offsetx)
        else:
            bo.resize_column(world.browser, column_name, left_or_right, offsetx)


@step('Reorder an inner column "(.*?)" header to "(.*?)" with (\d+) pixel')
def reorder_column_with_pixel(step, column_name, left_or_right, offsetx):
    with AssertContextManager(step):
        if str(column_name) == "GroupingColumn":
            bo.reorder_column_by_index(world.browser, 0, left_or_right, offsetx)
        else:
            bo.reorder_column(world.browser, column_name, left_or_right, offsetx)


@step('The reorder indicator line should be (\d+) from left$')
def get_reorder_indicator(step, pixel):
    with AssertContextManager(step):
        style = world.browser.execute_script(
            "return $('.ember-table-column-sortable-indicator.active').attr(\"style\")")
        indicator = str(style).split("left:")[1].split("px")[0].strip()

        assert_true(step, int(indicator) == int(pixel))


@step('Drag and hold column "(.*?)" to "(.*?)" with (\d+) pixel$')
def drag_hold_column(step, column_name, left_or_right, offsetx):
    with AssertContextManager(step):
        chains = ActionChains(world.browser)
        wait_for_elem(world.browser, "return $('.ember-table-content-container')")
        element = world.browser.execute_script(
            "return $('.ember-table-content-container .ember-table-content:contains(" + column_name + ")')")
        if left_or_right == "left":
            chains.click_and_hold(element[0]).move_by_offset(-int(offsetx), 0).perform()
        else:
            chains.click_and_hold(element[0]).move_by_offset(int(offsetx), 0).perform()


@step('The "(.*?)" column width should be (\d+) pixel')
def check_column_width(step, column_name, pixel):
    with AssertContextManager(step):
        if str(column_name) == "GroupingColumn":
            assert_true(step, int(bo.get_col_width_by_index(world.browser, 0)) == int(pixel))
        else:
            assert_true(step, int(bo.get_col_width(world.browser, column_name)) == int(pixel))


@step('The index (\d+) should be "(.*?)" column$')
def check_reorder_column(step, index, name):
    with AssertContextManager(step):
        if name == "GroupingColumn":
            assert_true(step, bo.get_col_name_by_index(world.browser, index) == "")
        else:
            assert_true(step, bo.get_col_name_by_index(world.browser, index) == name)


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


@step('I have the following grouped loans in MounteBank:')
def prepare_grouped_loans_in_mb(step):
    with AssertContextManager(step):
        prepare_grouped_loans(step.hashes)


@step('I see grouped rows:$')
def verify_grouped_rows(step):
    for index in range(0, len(step.hashes)):
        verify_grouped_row(index, step.hashes[index])


def verify_grouped_row(index, row):
    indicator = row['indicator']
    if indicator == '-':
        assert_true(step, is_the_row_expanded(index))
    elif indicator == '+':
        assert_true(step, not is_the_row_expanded(index))
    elif indicator == '':
        assert_true(step, is_the_leaf_node(index))

    for field in row:
        if field != 'indicator':
            verify_cell_content(index, field, row[field])


def is_the_row_expanded(index):
    return world.browser.execute_script(
        "return $('.ember-table-body-container .ember-table-left-table-block .ember-table-table-row:eq(" + str(
            index) + ") .ember-table-cell:eq(0) .grouping-column-indicator').hasClass('unfold')")


def is_the_leaf_node(index):
    length = world.browser.execute_script(
        "return $('.ember-table-body-container .ember-table-left-table-block .ember-table-table-row:eq(" + str(
            index) + ") .ember-table-cell:eq(0) .grouping-column-indicator:has(div)').length")
    return int(length) == 0


def is_the_leaf_node(index):
    length = world.browser.execute_script(
        "return $('.ember-table-body-container .ember-table-left-table-block .ember-table-table-row:eq(" + str(
            index) + ") .ember-table-cell:eq(0) .grouping-column-indicator:has(div)').length")
    return int(length) == 0


def verify_cell_content(row_index, name, value):
    col_index, is_fixed = find_col_index(name)
    block_selector = '.ember-table-right-table-block'
    if is_fixed:
        block_selector = '.ember-table-left-table-block'

    col_value = world.browser.execute_script(
        "return $('.ember-table-body-container " + block_selector + " .ember-table-table-row:eq(" + str(row_index) +
        ") .ember-table-cell:eq(" + str(col_index) + ") span').text().trim()")
    assert_true(step, str(col_value) == str(value))


def find_col_index(name):
    if name == 'groupName':
        return 0, True

    col_index = do_find_col_index(name, True)
    if col_index:
        return col_index, True
    else:
        return do_find_col_index(name, False), False


def do_find_col_index(name, in_fixed_block):
    block_selector = '.ember-table-right-table-block'
    if in_fixed_block:
        block_selector = '.ember-table-left-table-block'

    col_count = world.browser.execute_script(
        "return $('.ember-table-header-container " + block_selector + " .ember-table-header-cell').length")
    for i in range(0, col_count):
        headerName = world.browser.execute_script(
            " return $('.ember-table-header-container " + block_selector +
            " .ember-table-table-row > div .ember-table-header-cell:eq(" + str(i) + ") span').text().trim()")
        if headerName == name:
            return i


@step('There are (\d+) columns$')
def check_columns_numbers(step, num):
    with AssertContextManager(step):
        col_count = world.browser.execute_script(
            "return $('.ember-table-content-container .ember-table-content').length")
        assert_true(step, int(col_count) == int(num))


@step('Click "(.*?)" for row "(.*?)"$')
def expand_collapse_row(step, expand_collapse, row_name):
    with AssertContextManager(step):
        bo.expand_collapse_row(world.browser, row_name)


@step('Collapse all expanded rows')
def collapse_expanded_rows(step):
    with AssertContextManager(step):
        row = find_elements_by_css(world.browser, ".ember-table-toggle.ember-table-collapse")
        array = []
        for i in range(0, len(row)):
            row_name = world.driver.execute_script(
                "return $('.ember-table-toggle.ember-table-collapse:eq(" + str(i) + ")').siblings().text().trim()")
            array.append(row_name)
        for i in range(2, array.__len__())[::-1]:
            element = world.driver.execute_script(
                "return $('.ember-table-content:contains(" + str(array[i - 1]) + ")').siblings()")
            element[0].click()


@step('The row "(.*?)" indicator should be "(.*?)"$')
def check_row_indicator(step, row_name, indicator):
    with AssertContextManager(step):
        row = world.browser.execute_script(
            "return $('.ember-table-content:contains(" + str(row_name) + ")').siblings()")
        if indicator == "expand":
            assert_true(step, "unfold" not in row[0].get_attribute("class"))
        else:
            assert_true(step, "unfold" in row[0].get_attribute("class"))


@step('The row "(.*?)" indicator should be "(.*?)" with customized$')
def check_row_indicator(step, row_name, indicator):
    with AssertContextManager(step):
        row = world.browser.execute_script(
            "return $('.ember-table-content:contains(" + str(row_name) + ")').siblings()")
        if indicator == "expand":
            assert_true(step, ("unfold" not in row[0].get_attribute("class")) and is_the_row_custom(row_name))
        else:
            assert_true(step, ("unfold" in row[0].get_attribute("class")) and is_the_row_custom(row_name))


def is_the_row_custom(row_name):
    return world.browser.execute_script(
        "return $('.ember-table-content:contains(" + row_name + ")').siblings().hasClass('custom-grouped-row-indicator')")


@step('There are (\d+) grouped loans$')
def prepare_grouping_loans(step, count):
    with AssertContextManager(step):
        prepare_grouping_data(count)


@step('The "(.*?)" should not be scrolled$')
def check_grouping_column_should_not_scroll(step, column_name):
    with AssertContextManager(step):
        columns = world.browser.execute_script(
            "return $('.ember-table-header-container .ember-table-content').parent().parent()")
        for index, col in enumerate(columns):
            name = world.browser.execute_script(
                "return $('.ember-table-header-container .ember-table-content:eq(" + str(index) + ")').text().trim()")
            if name == column_name:
                num = index
        grouping_column_scroll_left = world.browser.execute_script(
            "return $('.lazy-list-container:eq(" + str(num) + ")').scrollLeft()")

        assert_true(step, int(grouping_column_scroll_left) == 0)


@step('The grouping and fixed columns should not be scrolled$')
def check_grouping_fixed_should_not_scroll(step):
    with AssertContextManager(step):
        grouping_fixed_scroll_left = world.browser.execute_script(
            "return $('.lazy-list-container:eq(0)').scrollLeft()")
        assert_true(step, int(grouping_fixed_scroll_left) == 0)


@step('There are (\d+) grouping and fixed columns$')
def check_grouping_fixed_num(step, num):
    with AssertContextManager(step):
        grouping_fixed_col_num = world.browser.execute_script(
            "return $('.ember-table-table-fixed-wrapper > div:eq(0) span').length")
        assert_true(step, int(num) == int(grouping_fixed_col_num))


@step('The column "(.*?)" should be fixed$')
def check_column_is_fixed(step, col_name):
    with AssertContextManager(step):
        col_names = world.browser.execute_script(
            "return $('.ember-table-table-fixed-wrapper > div:eq(0) span').text()")
        if str(col_name) == "GroupingColumn":
            assert_true(step, str("") in str(col_names))
        else:
            assert_true(step, str(col_name) in str(col_names))
