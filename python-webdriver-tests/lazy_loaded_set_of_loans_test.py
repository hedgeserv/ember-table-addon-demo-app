from test_helper import ChromeTest
from prepare_loans import prepare_loans_in_chunk


class TestFullLoadedSetOfLoans(ChromeTest):
    def test_show_first_section_of_loans(self):
        prepare_loans_in_chunk(200)

        self.visit('/lazy-loaded-loans?presentationLimit=100')

        self.assert_row_count(100)
