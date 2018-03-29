import unittest


class ServicesTest(unittest.TestCase):

    # A class method called before tests in an individual class run
    @classmethod
    def setUpClass(cls):
        print("called once before any tests in class")

    # Method called to prepare the test fixture.This is called immediately before
    # calling the test method
    def setUp(self):
        pass

    # Method called immediately after the test method has been called and the
    # result recorded. This is called even if the test method raised an exception,
    def tearDown(self):
        pass

    # A class method called after tests in an individual class have run.
    @classmethod
    def tearDownClass(cls):
        print("\ncalled once after all tests in class")

    def _getTargetClass(self):
        from api import services
        return services

    def _makeOne(self, *args, **kw):
        return self._getTargetClass()

    def test_hello(self):
        services = self._makeOne()
        out = services.hello()
        self.assertEqual("Hello World", out)


if __name__ == '__main__':
    unittest.main()
