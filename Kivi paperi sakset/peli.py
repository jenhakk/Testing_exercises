# Jenna Hakkarainen

import random


#Tietokone valitsee välineen
def computersChoice():

    tools = ["Rock", "Paper", "Scissors"]
    cpu = random.choice(tools)
    print("Computer chose: " + cpu)
    return cpu

#Käyttäjä valitsee välineen
def playersChoice():

    #Muutetaan syöte isoiksi kirjaimiksi
    player = input("Choose R (=Rock), P (=Paper) or S (=Scissors):").upper()

    if player == "R" or player == "P" or player == "S":
        return player
    else:
        print("Wrong input. Game over.")
        return "Wrong input"  

#Valitaan voittaja
def decideWinner(player, cpu):

        #Kerrotaan käyttäjän syötteen perusteella minkä hän valitsi

    if player == "R":
        player = "Rock"
        print("You chose: " + player)
            
    elif player == "P":
        player = "Paper"
        print("You chose: " + player)

    elif player == "S":
        player = "Scissors"
        print("You chose: " + player)
       
       #Verrataan käyttäjän ja tietokoneen välineitä ja ilmoitetaan tulos -> paulautetaan tulos

    if player == cpu:
        result = "It's a tie!"
        print(result)
            
    elif player == "Rock" and cpu == "Scissors":
        result = "Rock crushes scissors! You win!"
        print(result)
                
    elif player == "Rock" and cpu == "Paper":
        result = "Paper covers rock! You lose!"
        print(result) 

    elif player == "Paper" and cpu == "Rock":
        result = "Paper covers rock! You win!"
        print(result)

    elif player == "Paper" and cpu == "Scissors":
        result = "Scissors cuts paper! You lose!"
        print(result)

    elif player == "Scissors" and cpu == "Paper":
        result = "Scissors cuts paper! You win!"
        print(result)

    elif player == "Scissors" and cpu == "Rock":
        result = "Rock crushes scissors! You lose!"
        print(result) 

    return result

if __name__ == '__main__':

        #kysytään käyttäjän syöte

    player = playersChoice()

        #Mikäli käyttäjän syöte ei ole "Wrong input" jatketaan peliä, valitaan tietokoneen syöte, verrataan niitä ja katsotaan tulokset

    if player != "Wrong input":
        cpu = computersChoice()            
        decideWinner(player, cpu)



