# Jenna Hakkarainen

#Ohjelma joka kysyy käyttäjältä iän ja tulostaa vastaukseksi mihin ryhmään hän kuuluu

def AgeOfUser(userinput):
    

    #Muutetaan käyttäjän syöte kokonaisluvuksi
    try: 
        userinput = int(userinput)

    #Mikäli syöte ei ole kokonaisluku, tulostetaan huomautus ja ohjelma palauttaa "None"
    except:
        print("Syötä vain numeroita!")
        return None

    #Vertaillaan käyttäjän syöttämää arvoa eri raja-arvoihin
    if int(userinput) < 18 and int(userinput) > 0:
        print("Olet lapsi")
        
    elif int(userinput) >= 18 and int(userinput) < 70:
        print("Olet aikuinen")

    elif int(userinput) > 69:
        print("Olet eläkeläinen")

    #Mikäli käyttäjän syöte on negatiivinen luku
    else:
        print("Vain positiivisia lukuja")

    #Funktio palauttaa käyttäjän syötteen
    return userinput

if __name__ == '__main__':

    #Kysytään käyttäjän ikä
    userinput = input("Hei! Syötä ikäsi numeroina:")

    #Kutsutaan funktiota AgeOfUser ja annetaan sille käyttäjän syöte arvona
    AgeOfUser(userinput)