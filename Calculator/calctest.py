import unittest
import calculator

class CalculatorEngineTest(unittest.TestCase):
    def test_CalculateSumOfIntegers_Value1_and_Value2_And_AssignValueToResult(self):
        #Arrange
        val1 = int(4)
        val2 = int(3)

        #Act
        result = calculator.addition(val1, val2)

        #Assert
        self.assertEqual(7, result)

    def test_CalculateRemainderOfIntegers_Value1_and_Value2_And_AssignValueToResult(self):
        #Arrange
        val1 = int(4)
        val2 = int(3)

        #Act
        result = calculator.subtraction(val1, val2)

        #Assert
        self.assertEqual(1, result)

    def test_CalculateIncomeOfIntegers_Value1_and_Value2_And_AssignValueToResult(self):
        #Arrange
        val1 = int(4)
        val2 = int(3)

        #Act
        result = calculator.multiplication(val1, val2)

        #Assert
        self.assertEqual(12, result)

    def test_CalculateQuotientOfIntegers_Value1_and_Value2_And_AssignValueToResult(self):
        #Arrange
        val1 = int(6)
        val2 = int(2)

        #Act
        result = calculator.division(val1, val2)

        #Assert
        self.assertEqual(3, result)
    
if __name__ == '__main__':
    unittest.main()