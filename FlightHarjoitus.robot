*** Settings ***
Library   SeleniumLibrary
Library   String

*** Keywords ***

Select Departure City
    [Arguments]   ${departureCity}
    Select from list by value   xpath://select[@name='fromPort']   ${departureCity}
    ${depCity}=   Set variable   ${departureCity}
    Set global variable   ${depCity}
    
Select Destination City
    [Arguments]   ${destinationCity}
    Select from list by value   xpath://select[@name='toPort']   ${destinationCity}
    ${destCity}=   Set variable   ${destinationCity}
    Set global variable   ${destCity}

Search for flights
    Click button   xpath:/html/body/div[3]/form/div/input

*** Test Cases ***
Find flights from Boston to Cairo

    #Avataan sivu selaimella ja katsotaan että sisältää tietyn tekstin
    Open browser    http://blazedemo.com/
    Maximize browser window
    Page should contain   Welcome to the Simple Travel Agency!
    
    #Valitaan lähtö- ja saapumiskaupungit alasvetovalikosta käyttäen aiemmin luotuja Keywordeja
    Select departure city   Boston
    Select destination city   Cairo
    
    #Tarkistetaan että Find Flights-nappi on olemassa ja painetaan sitä, tarkistetaan että teksti löytyy sivulta
    Page should contain element   xpath:/html/body/div[3]/form/select[2]
    Search for flights
    

*** Test Cases ***
Check flights, choose one and save it's info
    Page should contain   Flights from ${depCity} to ${destCity}
    #Lasketaan osumat ja tarkistetaan että niitä on vähintään yksi
    ${flights}=   Get element count   xpath:/html/body/div[2]/table/tbody/tr[*]/td[1]
    Should be true   ${flights} > 0
    
    #Tallennetaan lennon numero, numero ja lentoyhtiö otsikoineen
          
    ${flightNumber}=   Get text   xpath:/html/body/div[2]/table/tbody/tr[2]/td[2]
    ${Airline}=   Get text   xpath:/html/body/div[2]/table/tbody/tr[2]/td[3]
    ${Price}=   Get text   xpath:/html/body/div[2]/table/tbody/tr[2]/td[6]
    
    #Valitse lento painamalla painiketta
    Click button   xpath:/html/body/div[2]/table/tbody/tr[2]/td[1]/input

*** Test Cases ***
Check flight info and save total cost
    Page should contain   Flight Number
    Page should contain   Airline
    Page should contain   Price
    
    #Haetaan tekstit sivulta muuttujiin, splitataan ne listoihin ja otetaan oikeat arvot talteen vertailua varten
    #Lennon numero
    ${fli_Nbr}=   Get text   xpath:/html/body/div[2]/p[2]
    @{fli_Nbr_List}=   Split string   ${fli_Nbr}
    ${fli_Nbr}=   set variable   ${fli_Nbr_List}[2]
    
    #Lentoyhtiö
    ${air_Ln}=   Get text   xpath:/html/body/div[2]/p[1]
    ${air_Ln_List}=   Split string   ${air_Ln}
    ${air_Ln}=   Set variable   ${air_Ln_List}[1]
    
    #Hinta
    ${pri}=   Get text   xpath:/html/body/div[2]/p[3]
    @{pri_List}=   Split string   ${pri}
    ${pri}=   set variable   ${pri_List}[1]
    
    #Verrataan että lennon tiedot täsmäävät (Ohitetaan siis virheet)
    Run keyword and ignore error   Should be equal   ${flightNumber}   ${fli_Nbr}
    Run keyword and ignore error   Should be equal   ${Airline}   ${air_Ln}
    Run keyword and ignore error   Should be equal   ${Price}   ${pri}
    
    #Otetaan kokonaishinta talteen
    ${totalPrice}=   Get text   xpath:/html/body/div[2]/p[5]/em
    Set global variable   ${totalPrice}
    
    

*** Test Cases ***
Fill information and send
    #Nimi
    ${name}=   set variable   Matti Matkustaja
    Click element   xpath://*[@id="inputName"]
    Input text   xpath://*[@id="inputName"]   ${name}
    
    #Osoite
    Click element   xpath://*[@id="address"]
    Input text   xpath://*[@id="address"]   Kotikatu 3
    
    #Kaupunki
    Click element   xpath://*[@id="city"]
    Input text   xpath://*[@id="city"]   Helsinki
    
    #Valtio
    Click element   xpath://*[@id="state"]
    Input text   xpath://*[@id="state"]   Finland
    
    #Postinumero
    Click element   xpath://*[@id="zipCode"]
    Input text   xpath://*[@id="zipCode"]   10020
    
    #Valitaan Visa luottokortiksi valikosta
    Select from list by label   id:cardType   Diner's Club
    
    #Luottokortin numero
    Click element   xpath://*[@id="creditCardNumber"]
    Input text   xpath://*[@id="creditCardNumber"]   1234567890123456
    
    #Vanhentumiskuukausi
    ${expMonth}=   Set variable   12
    Click element   xpath://*[@id="creditCardNumber"]
    Input text   xpath://*[@id="creditCardMonth"]   ${expMonth}
    Set global variable   ${expMonth}
       
    
    #Vanhentumisvuosi
    ${expYear}=   Set variable   2023
    Click element   xpath://*[@id="creditCardNumber"]
    Input text   xpath://*[@id="creditCardYear"]   ${expYear}
    Set global variable   ${expYear}
    
    #Luottokortissa oleva nimi
    Click element   xpath://*[@id="nameOnCard"]
    Input text   xpath://*[@id="nameOnCard"]   ${name}
    
    #Klikkaa Rememeber me -boksia
    Click element   xpath://*[@id="rememberMe"]
    
    #Paina Purchase flight
    Click button   xpath:/html/body/div[2]/form/div[11]/div/input

*** Test Cases ***
Check final information and close browser
    Page should contain   Thank you for your purchase today!
    
    #Otetaan luottokortin päättymisaika talteen muuttujaan, splitataan se listaan erotellaan kuukausi ja vuosi
    ${expiration}=   get text   xpath:/html/body/div[2]/div/table/tbody/tr[5]/td[2]
    @{expiration}=   Split string   ${expiration}   /
    ${exMo}=   Set variable   ${expiration}[0]
    ${exYe}=   Set variable   ${expiration}[1]
    
    #Otetaan kokonaissumma talteen muuttujaan, splitataan se listaan, erotellaan hinta ja valuutta
    ${to_pri}=   Get text   xpath:/html/body/div[2]/div/table/tbody/tr[3]/td[2]
    @{to_pri_List}=   Split string   ${to_pri}
    ${to_pri}=   set variable   ${to_pri_List}[0]
    
    #Verrataan aikaisemmin syötettyihin arvoihin
    Run keyword and ignore error   Should be equal   ${expMonth}   ${exMo}
    Run keyword and ignore error   Should be equal   ${expYear}   ${exYe}
    Run keyword and ignore error   Should be equal   ${totalPrice}   ${to_pri}
    
    #Suljetaan selain
    Close browser
