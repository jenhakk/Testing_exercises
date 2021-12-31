# Jenna Hakkarainen

import unittest
import peli
import unittest.mock

class TestGameEngine(unittest.TestCase):

#Funktio peli.playersChoice()
#Testataan jos käyttäjä syöttää "R" = Rock, palauttaako ohjelma oikean resultin
    def test_IfUserInputIs_R_ReturnResult(self):

    #Arrange
       with unittest.mock.patch('builtins.input', return_value="R"):
        expected = "R"
    #Act
        result = peli.playersChoice()
    #Assert
        self.assertEqual(result, expected)


#Testataan jos käyttäjä syöttää "K" = Väärä arvo, palauttaako ohjelma oikean resultin

    def test_IfUserInputIsNot_R_P_OR_S_ReturnResult(self):

    #Arrange
       with unittest.mock.patch('builtins.input', return_value="K"):
        expected = "Wrong input"
    #Act
        result = peli.playersChoice()
    #Assert
        self.assertEqual(result, expected)


#Funktio peli.decideWinner()
#Testataan eri tulosvaihtoehdot

    def test_IfTie_ReturnResult(self):

    #Arrange
        p = "Rock"
        cpu = "Rock"
        expected = "It's a tie!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)



    def test_IfPlayerHasRock_And_CpuScissors_ReturnResult(self):

    #Arrange
        p  = "Rock"
        cpu = "Scissors"
        expected = "Rock crushes scissors! You win!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(expected, result)


    def test_IfPlayerHasRock_And_CpuPaper_ReturnResult(self):

    #Arrange
        p = "Rock"
        cpu = "Paper"
        expected = "Paper covers rock! You lose!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)


    def test_IfPlayerHasPaperk_And_CpuRock_ReturnResult(self):

    #Arrange
        p = "Paper"
        cpu = "Rock"
        expected = "Paper covers rock! You win!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)


    def test_IfPlayerHasPaperk_And_CpuScissors_ReturnResult(self):

    #Arrange
        p = "Paper"
        cpu = "Scissors"
        expected = "Scissors cuts paper! You lose!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)


    def test_IfPlayerHasScissorsk_And_CpuPaper_ReturnResult(self):

    #Arrange
        p = "Scissors"
        cpu = "Paper"
        expected = "Scissors cuts paper! You win!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)


    def test_IfPlayerHasScissorsk_And_CpuRock_ReturnResult(self):

    #Arrange
        p = "Scissors"
        cpu = "Rock"
        expected = "Rock crushes scissors! You lose!"
    #Act
        result = peli.decideWinner(p, cpu)
    #Assert
        self.assertEqual(result, expected)


if __name__ == '__main__':
    unittest.main()