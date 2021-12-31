*** Settings ***
Library   OperatingSystem
Library   String
Library   Collections


*** Test Cases ***
Read file into variable
    #Luetaan tiedostosta tekstit muuttujaan
    ${textFile}=   Get file   C:/Users/jenna/Documents/webpages.txt
    #Jaetaan tekstit listaan
    @{fileList}=   Split string   ${textFile}
    Set global variable   ${fileList}
    #Katsotaan montako sanaa (eli osoitetta) listassa on
    ${wordCount}=   Get length   ${fileList}

*** Test Cases ***
Ping first address and get ip and ping time
    #Pingataan listan ensimmäinen osoite ja otetaan vastauksen toisesta indexistä tiedot uuteen listaan
    ${webpage}=   Run and return rc and output   ping ${fileList}[0]
    @{pingList}=   Split string   ${webpage}[1]
    #haetaan IP-osoite indexistä 2
    ${IP1}=   Get From List   ${pingList}   2
    Set global variable   ${IP1}
    #haetaan keskimääräinen vastausaika indexistä 62
    ${averageTime1}=   Get From List   ${pingList}   62
    Set global variable   ${averageTime1}
    #Erotetaan muuttujasta pelkät sekunnit ja katsotaan onko alle 50
    ${seconds1}=   Remove string   ${averageTime1}   ms
    Should be true   ${seconds1} < 50   msg="Ei alle 50ms!"

*** Test Cases ***
Ping second address and get ip and ping time
    #Pingataan listan toinen osoite ja otetaan vastauksen toisesta indexistä tiedot uuteen listaan
    ${webpage}=   Run and return rc and output   ping ${fileList}[1]
    @{pingList}=   Split string   ${webpage}[1]
    #haetaan IP-osoite indexistä 2
    ${IP2}=   Get From List   ${pingList}   2
    Set global variable   ${IP2}
    #haetaan keskimääräinen vastausaika indexistä 62
    ${averageTime2}=   Get From List   ${pingList}   62
    Set global variable   ${averageTime2}
    #Erotetaan muuttujasta pelkät sekunnit ja katsotaan onko alle 50
    ${seconds2}=   Remove string   ${averageTime2}   ms   
    Should be true   ${seconds2} < 50   msg="Ei alle 50ms!"

*** Test Cases ***
Ping third address and get ip and ping time
    #Pingataan listan kolmas osoite ja otetaan vastauksen toisesta indexistä tiedot uuteen listaan
    ${webpage}=   Run and return rc and output   ping ${fileList}[2]
    @{pingList}=   Split string   ${webpage}[1]
    #haetaan IP-osoite indexistä 2
    ${IP3}=   Get From List   ${pingList}   2
    Set global variable   ${IP3}
    #haetaan keskimääräinen vastausaika indexistä 62
    ${averageTime3}=   Get From List   ${pingList}   62
    Set global variable   ${averageTime3}
    #Erotetaan muuttujasta pelkät sekunnit ja katsotaan onko alle 50
    ${seconds3}=   Remove string   ${averageTime3}   ms   
    Should be true   ${seconds3} < 50   msg="Ei alle 50ms!"

*** Test Cases ***
Create file and save all ips and times
    #Luodaan uusi tiedosto ja katsotaan että se on olemassa
    ${path}=   Set variable   C:/Users/jenna/Documents/ping/
    Create file   ${path}pings.txt
    File should exist   ${path}pings.txt
    #Lisätään tiedostoon osoitteiden ip-osoitteet sekä vastausajat
    Append to file   ${path}pings.txt   Ensimmäinen osoite on ${fileList}[0],\n sen ip-osoite on ${IP1}\n ja keskimääräinen vastausaika on ${averageTime1}\n\n
    Append to file   ${path}pings.txt   Toinen osoite on ${fileList}[1],\n sen ip-osoite on ${IP2}\n ja keskimääräinen vastausaika on ${averageTime2}\n\n
    Append to file   ${path}pings.txt   Kolmas osoite on ${fileList}[2],\n sen ip-osoite on ${IP3}\n ja keskimääräinen vastausaika on ${averageTime3}\n\n
    #Katsotaan että tiedosto ei ole tyhjä
    File should not be empty   ${path}pings.txt


