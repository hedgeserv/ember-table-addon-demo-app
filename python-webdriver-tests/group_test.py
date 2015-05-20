from test_helper import ChromeTest
from prepare_loans import prepare_loans


class TestGroup(ChromeTest):

    def test_index(self):

    	prepare_loans(20)
        
        self.visit('/groups')

        element_title = self.driver.find_element_by_class_name('group-title')

        self.assertEqual('Group', element_title.text)

        goups = self.driver.find_element_by_class_name('group')
