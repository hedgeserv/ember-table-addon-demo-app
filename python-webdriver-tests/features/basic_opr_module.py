__author__ = 'Liang Zhen'
from selenium.webdriver import ActionChains
import time


def drag_scroll_by_css(browser, offsetx, offsety):
    scroll = browser.find_element_by_css_selector("div.antiscroll-scrollbar.antiscroll-scrollbar-vertical")
    action = ActionChains(browser)
    action.click_and_hold(scroll).move_by_offset(int(offsetx), int(offsety)).release().perform()


def wait_for_elem(browser, script, timeout=20):
    start = time.time()
    elems = []
    while time.time() - start < timeout:
        elems = browser.execute_script(str(script))
        if elems:
            return elems
        time.sleep(0.2)
    return elems


def drag_scroll_by_css_with_times(browser, offsety, times):
    start = time.time()
    css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        eles = browser.find_elements_by_css_selector(css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value > int(offsety) * int(times):
            break
        time.sleep(1)


def drag_scroll_to_top(browser, offsety):
    start = time.time()
    css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        eles = browser.find_elements_by_css_selector(css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value == 0:
            break
        time.sleep(0.5)


def drag_scroll_to_bottom(browser, offsety):
    start = time.time()
    css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        eles = browser.find_elements_by_css_selector(css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value > 243:
            break
        time.sleep(0.5)


def get_column_width_by_class_name(browser, index):
    columns = browser.find_element_by_class_name("ember-table-header-cell")
    return columns[int(index) - 1].get_attribute("style").split(";")[0].split(":")[1].split("px")[0].strip()


def get_grouped_column_css(browser, col_name):
    element = browser.execute_script(
        "return $('span.ember-table-content:contains(" + col_name + ")').parent().parent()")
    return element[0].get_attribute("class")


def get_record_content(browser, index):
    result = browser.execute_script(
        'return $($("div.ember-table-body-container div.ember-table-table-row")[' + str(
            index) + ']).find("div div:eq(0) span").text().trim()')
    return result


def drag_horizontal_offset(browser, offsetx):
    horizontal_css = ".antiscroll-scrollbar.antiscroll-scrollbar-horizontal"
    elements = browser.find_elements_by_css_selector(horizontal_css)

    action = ActionChains(browser)
    action.click_and_hold(elements[0]).move_by_offset(int(offsetx), 0).release().perform()


def get_head_block_scroll_left(browser):
    return browser.execute_script("return $('.ember-table-table-block.ember-table-header-block').scrollLeft()")


def get_body_scroll_left(browser):
    return browser.execute_script("return $('.lazy-list-container').scrollLeft()")


def resize_column(browser, column_name, left_or_right, offsetx):
    action_chains = ActionChains(browser)
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().parent().children()[1]")
    if left_or_right == "left":
        action_chains.drag_and_drop_by_offset(element, -int(offsetx), 0).release().perform()
    else:
        action_chains.drag_and_drop_by_offset(element, int(offsetx), 0).release().perform()


def resize_column_by_index(browser, index, left_or_right, offsetx):
    action_chains = ActionChains(browser)
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:eq(" + str(
            index) + ")').parent().parent().children()[1]")
    if left_or_right == "left":
        action_chains.drag_and_drop_by_offset(element, -int(offsetx), 0).release().perform()
    else:
        action_chains.drag_and_drop_by_offset(element, int(offsetx), 0).release().perform()


def reorder_column(browser, col_name, left_or_right, offsetx):
    chains = ActionChains(browser)
    wait_for_elem(browser, "return $('.ember-table-content-container')")
    element = browser.execute_script(
        "return $('.ember-table-content-container .ember-table-content:contains(" + col_name + ")')")
    if left_or_right == "left":
        chains.click_and_hold(element[0]).move_by_offset(-int(offsetx), 0).release().perform()
    else:
        chains.click_and_hold(element[0]).move_by_offset(int(offsetx), 0).release().perform()


def reorder_column_by_index(browser, index, left_or_right, offsetx):
    chains = ActionChains(browser)
    wait_for_elem(browser, "return $('.ember-table-content-container')")
    element = browser.execute_script(
        "return $('.ember-table-content-container .ember-table-content:eq(" + str(index) + ")')")
    if left_or_right == "left":
        chains.click_and_hold(element[0]).move_by_offset(-int(offsetx), 0).release().perform()
    else:
        chains.click_and_hold(element[0]).move_by_offset(int(offsetx), 0).release().perform()


def get_col_width(browser, col_name):
    return browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:contains(" + col_name + ")').parent().width()")


def get_col_width_by_index(browser, index):
    return browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:eq(" + str(index) + ")').parent().width()")


def get_col_name_by_index(browser, index):
    elements = browser.execute_script("return $('.ember-table-content-container')")
    list = []
    for i in range(0, len(elements)):
        column = browser.execute_script(
            "return $('.ember-table-content-container .ember-table-content:eq(" + str(i) + ")').text()")
        list.append(str(column).strip())
    return list[int(index)]


def sort_column(browser, col_name):
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:contains(" + col_name + ")').parent().parent()")
    element[0].click()


def expand_collapse_row(browser, row_name):
    row = browser.execute_script(
        "return $('.ember-table-content:contains(" + str(row_name) + ")').siblings()")
    row[0].click()
