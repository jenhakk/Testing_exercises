import unittest
import fizzbuzz

class FizzBuzzTesting(unittest.TestCase):

    def test_Send_1_ToFizzBuzzEngine_Returns_1(self):

        #Arrange
        num = int(1)

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, 1)

    def test_Send_2_ToFizzBuzzEngine_Returns_2(self):

         #Arrange
        num = int(2)

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, 2)

    def test_Send_3_ToFizzBuzzEngine_Returns_Fizz(self):

         #Arrange
        num = int(3)
        expected = "Fizz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_4_ToFizzBuzzEngine_Returns_4(self):

         #Arrange
        num = int(4)

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, 4)

    def test_Send_5_ToFizzBuzzEngine_Returns_Buzz(self):

         #Arrange
        num = int(5)
        expected = "Buzz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_6_ToFizzBuzzEngine_Returns_Fizz(self):

         #Arrange
        num = int(6)
        expected = "Fizz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_7_ToFizzBuzzEngine_Returns_7(self):

         #Arrange
        num = int(7)

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, 7)

    def test_Send_9_ToFizzBuzzEngine_Returns_Fizz(self):

         #Arrange
        num = int(9)
        expected = "Fizz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_10_ToFizzBuzzEngine_Returns_Buzz(self):

         #Arrange
        num = int(10)
        expected = "Buzz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_15_ToFizzBuzzEngine_Returns_FizzBuzz(self):

         #Arrange
        num = int(15)
        expected = "FizzBuzz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    def test_Send_30_ToFizzBuzzEngine_Returns_FizzBuzz(self):

         #Arrange
        num = int(30)
        expected = "FizzBuzz"

        #Act
        result = fizzbuzz.WhatToWrite(num)

        #Assert

        self.assertEqual(result, expected)

    


if __name__ == "__main__":
    unittest.main()



