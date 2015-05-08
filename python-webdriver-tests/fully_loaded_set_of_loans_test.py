from test_helper import ChromeTest
from prepare_loans import prepare_loans


class TestFullLoadedSetOfLoans(ChromeTest):

    def test_homepage(self):
        prepare_loans(3500)

        self.visit('/fully-loaded-loans')

        self.assert_row_count(3500)
