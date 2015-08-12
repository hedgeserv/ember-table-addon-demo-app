from selenium.webdriver.common.keys import Keys

__author__ = 'Liang Zhen'
from selenium.webdriver import ActionChains
import time
import os
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By


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


def wait_element_clickable(browser, css):
    WebDriverWait(browser, 30).until(
        EC.element_to_be_clickable((By.CSS_SELECTOR, css)))


def drag_scroll_by_css_with_times(browser, offsety, times):
    start = time.time()
    css = "div.antiscroll-scrollbar.antiscroll-scrollbar-vertical"
    wait_element_clickable(browser, css)

    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offsety)
        wait_element_clickable(browser, css)
        eles = browser.find_elements_by_css_selector(css)
        value = int(eles[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value > int(offsety) * int(times):
            break
        time.sleep(1)


def drag_scroll_by_css_with_times_after_loading(browser, offsety, times):
    while not times == 0:
        time.sleep(1)
        drag_scroll_by_css(browser, 0, offsety)
        times = int(times) - 1


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
        if value > 242:
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


def get_col_header_height(browser, col_name):
    return browser.execute_script(
        "return $('.ember-table-content-container .ember-table-content:contains(" + col_name + ")').parent().parent().height()")


def get_col_name_by_index(browser, index, timeout=5):
    list = []

    start = time.time()
    while time.time() - start < timeout:
        elements = browser.execute_script("return $('.ember-table-content-container')")
        if len(elements) != 0:
            break
        time.sleep(0.5)

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
    row = wait_for_elem(browser, "return $('.ember-table-content:contains(" + str(row_name) + ")').siblings()")
    row[1].click()


def expand_collapse_row_by_index(browser, index):
    row = browser.execute_script("return $('.grouping-column-indicator')")
    row[int(index)].click()


def stop_mb():
    os.system("mb stop")


def start_mb():
    os.system('mb --allowCORS &')


def command_ctrl_with_click(browser, col_name, command_or_ctrl):
    chains = ActionChains(browser)
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:contains(" + col_name + ")').parent().parent()")
    if command_or_ctrl == "command":
        chains.key_down(Keys.COMMAND).click(element[0]).key_up(Keys.COMMAND).perform()
    elif command_or_ctrl == "control":
        chains.key_down(Keys.CONTROL).click(element[0]).key_up(Keys.COMMAND).perform()


def wait_loading_indicator_disappear(browser, timeout=5):
    start = time.time()
    while time.time() - start < timeout:
        indicator = browser.execute_script("return $('.row-loading-indicator.loading')")
        if len(indicator) == 0:
            return
        time.sleep(0.2)
    raise AssertionError
