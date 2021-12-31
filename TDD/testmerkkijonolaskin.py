import unittest
import merkkijonolaskin

class MerkkijonoLaskinTesti(unittest.TestCase):

    def test_Send_Empty_ToLaskeEngine_Return_0(self):

        #Arrange
        str = ""
        expected = 0
        
        #Act
        result = merkkijonolaskin.MerkkijonoLaskin.Laske(str)

        #Arrange
        self.assertEqual(result, expected)

    def test_Send_Number_ToLaskeEngine_Return_NumbersValue(self):

        #Arrange
        str = 1
        expected = 1
        
        #Act
        result = merkkijonolaskin.MerkkijonoLaskin.Laske(str)

        #Arrange
        self.assertEqual(result, expected)

    def test_Send_TwoNumbersWithComma_ToLaskeEngine_Return_SumOfThem(self):

        #Arrange
        str = 1
        expected = 1
        
        #Act
        result = merkkijonolaskin.MerkkijonoLaskin.Laske(str)

        #Arrange
        self.assertEqual(result, expected)


if __name__ == "__main__":
    unittest.main()