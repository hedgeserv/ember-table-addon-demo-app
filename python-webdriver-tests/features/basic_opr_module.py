import time

from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains
from stub.prepare_loans import delete_imposter


def drag_scroll_by_css(browser, offset_x, offset_y):
    scroll, height = wait_element_present(browser)
    action = ActionChains(browser)
    try:
        action.click_and_hold(scroll[0]).move_by_offset(int(offset_x), int(offset_y) + 1).release().perform()
    except AssertionError:
        drag_scroll_by_css(browser, offset_x, offset_y)


def wait_for_elem(browser, script, timeout=20):
    start = time.time()
    elems = []
    while time.time() - start < timeout:
        elems = browser.execute_script(str(script))
        if elems:
            return elems
        time.sleep(0.2)
    return elems


def wait_element_present(browser):
    start = time.time()
    while time.time() - start < 15:
        elems = browser.execute_script("return $('.ember-table-body-container.antiscroll-wrap>div:eq(1)')")
        if elems[0] and 'antiscroll-scrollbar-vertical' in str(browser.execute_script(
                "return $('.ember-table-body-container.antiscroll-wrap>div:eq(1)').attr('class')")):
            return elems, browser.execute_script(
                "return $('.ember-table-body-container.antiscroll-wrap>div:eq(1)').css('top')")
        time.sleep(0.5)


def drag_scroll_by_css_with_times(browser, offset_y, times):
    start = time.time()

    while time.time() - start < 15:
        drag_scroll_by_css(browser, 0, offset_y)
        elems, top = wait_element_present(browser)
        if int(str(top).split('.')[0]) >= int(offset_y) * int(times):
            break
        time.sleep(0.5)


def drag_scroll_by_css_with_times_after_loading(browser, offset_y, times):
    while not times == 0:
        time.sleep(1)
        drag_scroll_by_css(browser, 0, offset_y)
        times = int(times) - 1


def drag_scroll_to_top(browser, offset_y):
    start = time.time()

    while time.time() - start < 15:
        wait_element_present(browser)
        drag_scroll_by_css(browser, 0, offset_y)
        elems, top = wait_element_present(browser)
        value = int(elems[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
        if value == 0:
            break
        time.sleep(0.5)


def drag_scroll_to_bottom(browser, offset_y):
    start = time.time()
    while time.time() - start < 15:
        wait_element_present(browser)
        drag_scroll_by_css(browser, 0, offset_y)
        elems, top = wait_element_present(browser)
        value = int(elems[0].get_attribute("style").split("top: ")[1].split("px")[0].split(".")[0])
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


def drag_horizontal_offset(browser, offset_x):
    horizontal_css = ".antiscroll-scrollbar.antiscroll-scrollbar-horizontal"
    elements = browser.find_elements_by_css_selector(horizontal_css)

    action = ActionChains(browser)
    action.click_and_hold(elements[0]).move_by_offset(int(offset_x), 0).release().perform()


def get_head_block_scroll_left(browser):
    return browser.execute_script("return $('.ember-table-table-block.ember-table-header-block').scrollLeft()")


def get_body_scroll_left(browser):
    return browser.execute_script("return $('.lazy-list-container').scrollLeft()")


def resize_column(browser, column_name, left_or_right, offset_x):
    action_chains = ActionChains(browser)
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:contains(" + column_name + ")').parent().parent().children()[1]")
    if left_or_right == "left":
        action_chains.drag_and_drop_by_offset(element, -int(offset_x), 0).release().perform()
    else:
        action_chains.drag_and_drop_by_offset(element, int(offset_x), 0).release().perform()


def resize_column_by_index(browser, index, left_or_right, offset_x):
    action_chains = ActionChains(browser)
    element = browser.execute_script(
        "return $('.ember-table-header-container .ember-table-content:eq(" + str(
            index) + ")').parent().parent().children()[1]")
    if left_or_right == "left":
        action_chains.drag_and_drop_by_offset(element, -int(offset_x), 0).release().perform()
    else:
        action_chains.drag_and_drop_by_offset(element, int(offset_x), 0).release().perform()


def reorder_column(browser, col_name, left_or_right, offset_x):
    chains = ActionChains(browser)
    wait_for_elem(browser, "return $('.ember-table-content-container')")
    element = browser.execute_script(
        "return $('.ember-table-content-container .ember-table-content:contains(" + col_name + ")')")
    if left_or_right == "left":
        chains.click_and_hold(element[0]).move_by_offset(-int(offset_x), 0).release().perform()
    else:
        chains.click_and_hold(element[0]).move_by_offset(int(offset_x), 0).release().perform()


def reorder_column_by_index(browser, index, left_or_right, offset_x):
    chains = ActionChains(browser)
    wait_for_elem(browser, "return $('.ember-table-content-container')")
    element = browser.execute_script(
        "return $('.ember-table-content-container .ember-table-content:eq(" + str(index) + ")')")
    if left_or_right == "left":
        chains.click_and_hold(element[0]).move_by_offset(-int(offset_x), 0).release().perform()
    else:
        chains.click_and_hold(element[0]).move_by_offset(int(offset_x), 0).release().perform()


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
    elems = []

    start = time.time()
    while time.time() - start < timeout:
        elements = browser.execute_script("return $('.ember-table-content-container')")
        if len(elements) != 0:
            break
        time.sleep(0.5)

    for i in range(0, len(elements)):
        column = browser.execute_script(
            "return $('.ember-table-content-container .ember-table-content:eq(" + str(i) + ")').text()")
        elems.append(str(column).strip())
    return elems[int(index)]


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
    delete_imposter()


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
