import unittest
from api.app import create_app


class ViewsTest(unittest.TestCase):

    # A class method called before tests in an individual class run
    @classmethod
    def setUpClass(cls):
        print("called once before any tests in class")

    # Method called to prepare the test fixture.This is called immediately before
    # calling the test method
    def setUp(self):
        self.app = create_app('test_config')
        self.test_client = self.app.test_client()

    # Method called immediately after the test method has been called and the
    # result recorded. This is called even if the test method raised an exception,
    def tearDown(self):
        pass

    # A class method called after tests in an individual class have run.
    @classmethod
    def tearDownClass(cls):
        print("\ncalled once after all tests in class")

    def test_hello(self):
        out = self.test_client.get('/api/')
        data = out.data.decode()
        self.assertEqual('Hello World', data)

if __name__ == '__main__':
    unittest.main()
