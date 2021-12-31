#Jenna Hakkarainen

#Ohjelma jolle annetaan 3 kolmion sivun pituutta ja kertoo sitten millainen kolmio on kyseessä ja palauttaa tulostetun lauseen

def triangleType(side1, side2, side3):

    try: 
        side1 = int(side1)
        side2 = int(side2)
        side3 = int(side3)

    #Mikäli luvut eivät ole kokonaislukuja, tulostetaan huomautus ja ohjelma palauttaa "None"
    except:
        print("Vain numeroita!")
        return None

    #Jos joku sivuista on yhtä suuri tai pienempi kuin 0
    if (side1<=0 or side2<=0 or side3<=0):
        result = "Sivu ei voi olla nolla tai pienempi kuin 0!"
        print(result)
        return result

    #Jos kolmion kahden lyhyemmän sivun summa on yhtä suuri tai pienempi kuin pisimmän sivun, kolmiota ei voi muodostaa
    elif side1+side2<=side3 or side1+side3<=side2 or side2+side3<=side1:
        result = "Kolmiota ei voida muodostaa!"
        print(result)
        return result
    
    #Jos kolmion kaikki sivut ovat yhtä pitkät
    elif side1==side2==side3:
        result = "Kolmio on tasasivuinen"
        print(result)
        return result
    
    #Jos kolmion kaksi sivua ovat keskenään yhtä pitkiä ja erisuuri kuin kolmas sivu
    elif side1==side2 or side1==side3 or side2==side3:
        result = "Kolmio on tasakylkinen"
        print(result)
        return result
    
    #Jos kaikki sivut ovat keskenään eri pituisia
    elif side1!=side2!=side3:
        result = "Kolmio on epäsäännöllinen"
        print(result)
        return result


if __name__ == '__main__':
    triangleType(5, 2, "!")


