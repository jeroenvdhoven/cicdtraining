from unittest import TestCase


class TestDummy(TestCase):

    def test_addition(self):
        result = 1 + 1

        self.assertEqual(result, 2)
