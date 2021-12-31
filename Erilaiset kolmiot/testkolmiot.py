#Jenna Hakkarainen

import unittest
import kolmiot

class TestTriangleTypeEngine(unittest.TestCase):

    #Testataan funktion osaa joka tarkistaa ovatko muuttujat int-tietotyyppiä, jos ei palauttaa arvon None

    def test_IfTriangleValuesAreInt(self):
        #Arrange
        side1 = 4
        side2 = 4
        side3 = 3

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertIsNone(result)


    #Testataan funktion osan joka tarkistaa ovatko arvot positiivisia 

    def test_TriangleCannotWithNegativeNumbers(self):
        #Arrange
        side1 = int(3)
        side2 = int(4)
        side3 = int(3)

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertEqual("Sivu ei voi olla nolla tai pienempi kuin 0!", result)

#Testataan funktion osa joka tarkistaa voiko kolmiota muodostaa annetuilla arvoilla (a+b<=c) = ei voi muodostaa

    def test_TriangleCannotForm(self):
        #Arrange
        side1 = int(1)
        side2 = int(1)
        side3 = int(1)

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertEqual("Kolmiota ei voida muodostaa!", result)

#Testataan funktion osa joka tarkistaa onko kolmio tasasivuinen


    def test_IfTriangleIsEquilateral(self):
         #Arrange
        side1 = int(4)
        side2 = int(4)
        side3 = int(3)

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertEqual("Kolmio on tasasivuinen", result)


#Testataan funktion osa joka tarkistaa onko kolmio tasakylkinen

    def test_IfTriangleIsIsosceles(self):
        #Arrange
        side1 = int(5)
        side2 = int(4)
        side3 = int(2)

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertEqual("Kolmio on tasakylkinen", result)

#Testataan funktion osa joka tarkistaa onko kolmio epäsäännöllinen

    def test_IfTriangleIsIsScalene(self):
        #Arrange
        side1 = int(2)
        side2 = int(3)
        side3 = int(3)

        #Act
        result = kolmiot.triangleType(side1,side2,side3)

        #Assert
        self.assertEqual("Kolmio on epäsäännöllinen", result)



if __name__ == '__main__':
    unittest.main()