# Jenna Hakkarainen

import unittest
import age

class TestAgeEngine(unittest.TestCase):

#Testataan funktion osaa jossa tarkistetaan muuttujan tietotyyppi
    def test_IfUserInputIsNotInt(self):
        #Arrange
        value = "!"

        #Act

        result = age.AgeOfUser(value)

        #Assert

        self.assertIsNone(result)

#Testataan funktion osaa jossa tarkistetaan onko käyttäjä alle 18
    def test_IfUserInputIsUnderEighteen_And_PrintAnswer(self):
        #Arrange
        value = int(6)       

        #Act
        result = age.AgeOfUser(value)

        #Assert
        self.assertLess(result, 18)

#Testataan funktion osaa jossa tarkistetaan onko käyttäjä 18-69
    def test_IfUserInputIsUnderSeventy_And_PrintAnswer(self):
        #Arrange
        value = int(55)

        #Act
        result = age.AgeOfUser(value)

        #Assert
        self.assertLess(result, 70)
        self.assertGreaterEqual(result, 18)        

#Testataan funktion osaa jossa tarkistetaan onko käyttäjä yli 69
    def test_IfUserInputIsOverSixtynine_And_PrintAnswer(self):
        #Arrange
        value = int(75)

        #Act
        result = age.AgeOfUser(value)

        #Assert
        self.assertGreaterEqual(result, 70) 

#Testataan funktion osaa jossa tarkistetaan onko käyttäjän syöte positiivinen numero
    def test_IfUserInputIsAPositiveNumber_And_PrintAnswer(self):
        #Arrange
        value = int(5)

        #Act
        result = age.AgeOfUser(value)

        #Assert
        self.assertGreaterEqual(result, 0)   

    

if __name__ == '__main__':
    unittest.main()
