*** Settings ***
Library   DatabaseLibrary
Library   Collections
Library   String
Library   OperatingSystem

*** Variables ***
${dbname}   school
${dbuser}   jennah
${dbpass}   jennah
${dbhost}   localhost
${dbport}   3306
${initialdbname}   mysql
@{TablesInDatabase}   aine   kurssi   opettaja   oppilas   suoritus
@{ColumnsInAine}   ainenro   nimi   vastuuopettaja   suorituspisteet
${table}   aine

*** Keywords ***
Make connection
    Connect to database   pymysql   ${dbname}   ${dbuser}   ${dbpass}   ${dbhost}   ${dbport}

*** Test Cases ***
Create database to be tested
    #Otetaan yhteys tietokantaan ja luodaan uusi tietokanta 'school', otetaan se köyttöön
    Connect to database   pymysql   ${initialdbname}   ${dbuser}   ${dbpass}   ${dbhost}   ${dbport}
    Execute sql string   drop database if exists school;
    Execute sql string   create database school;
    Execute sql string   use school;
    #haetaan tiedostosta tietokannan luomiseen komennot tekstinä
    ${GetCommands}=   get file   C:/Users/jenna/Documents/tietokanta/create_tables.txt
    #Erotellaan komennot toisistaan ; listaksi ja katsotaan listan pituus, poistetaan viimeinen tyhjä rivi
    @{CreationCommands}=   split string   ${GetCommands}   ;
    ${TableCount}=   Get length   ${CreationCommands}
    ${IndexToBeRemoved}=   Evaluate   ${TableCount}-1
    Remove from list   ${CreationCommands}   ${IndexToBeRemoved}
    #Suoritetaan loopissa tietokannan luomiskomennot
    ${TableCount}=   Get length   ${CreationCommands}
    FOR   ${INDEX}   IN RANGE   ${TableCount}
        Execute sql string   ${CreationCommands}[${INDEX}]
    END   
    Set global variable   ${TableCount}

*** Test Cases ***
Insert data into database
    #Toistetaan samat kuin edellisessä mutta lisätään tiedot äsken luotuihin tauluihin
    Make connection
    ${GetCommands}=   get file  C:/Users/jenna/Documents/tietokanta/insert_into_tables.txt
    @{InsertCommands}=   Split string   ${GetCommands}   ;
    ${InsertCount}=   Get length   ${InsertCommands}
    ${IndexToBeRemoved}   Evaluate   ${InsertCount}-1
    Remove from list   ${InsertCommands}   ${IndexToBeRemoved}
    ${InsertCount}=   Get length   ${InsertCommands}
    FOR   ${INDEX}   IN RANGE   ${InsertCount}
        Execute sql string   ${InsertCommands}[${INDEX}]
    END
    

*** Test Cases ***
Connect to database and get tables
    Make connection
    #Luodaan uusi lista johon haetaan taulut tietokannasta, muutetaan tiedot stringeiksi ja poistetaan erikoismerkit loopissa, lisätään listaan
    @{TablesFoundFromDB}=   create list
    ${DatabaseTables}=   query   show tables;
    ${length}=   Get length   ${DatabaseTables}
    Should be equal   ${length}   ${TableCount}
    FOR   ${INDEX}   IN RANGE   ${length}
        ${table}=   Set variable   ${DatabaseTables}[${INDEX}]
        ${table}=   Convert to string   ${table}
        ${table}=   Remove string   ${table}   ,   (   )   '
        
        Append to list   ${TablesFoundFromDB}   ${table}
    END
    #Tarkistetaan että listojen pituudet ovat samat
    ${TableListLength}=   Get length   ${TablesFoundFromDB}
    Should be equal   ${TableListLength}   ${length}
    Set global variable   ${TablesFoundFromDB}
    Set global variable   ${TableListLength}
    
    ${output}=   Query   describe ${table};

*** Test Cases ***
Check table aine columns and add new column
    Make connection
    #Lisätään tietokannan tauluun "aine" uusi sarake "Opetuskieli"
    Execute sql string   ALTER table ${table} ADD opetuskieli varchar(150);
    #Luodaan lista johon laitetaan taulun sarakkeet
    ${ColumnNameList}=   Create list
    ${output}=   Query   describe ${table};
    ${length}=   Get length   ${output}
    #Loopissa haetaan taulujen nimet ja lisätään ne listaan
    FOR   ${INDEX}   IN RANGE   ${length}
        ${ColumnName}=   Set variable   ${output}[${INDEX}][0]
        Append to list   ${ColumnNameList}   ${ColumnName}
    END
    #Verrataan ettei uusi lista ole sama kuin alkuperäinen lista jossa taulujen nimet
    Should not be equal   ${ColumnNameList}   ${ColumnsInAine}
    
    Set global variable   ${ColumnNameList}
    
    #Loopataan uuden listan sarakkeiden nimet näkyviin
    FOR   ${item}   IN   ${ColumnNameList}
        ${new}=   Set variable   ${item}
    END

*** Test Cases ***
Drop column from table
    Make connection
    Execute sql string   use school;
    #poistetaan taulusta "aine" sarake "opetuskieli"
    Execute sql string   ALTER table aine DROP column opetuskieli;
    
    ${output}=   Query   describe ${table};
    #Luodaan uusi lista johon haetaan taulun sarakkeet
    ${ColumnNameList2}=   Create list
    ${output}=   Query   describe ${table};
    ${length}=   Get length   ${output}
    FOR   ${INDEX}   IN RANGE   ${length}
        ${ColumnName}=   Set variable   ${output}[${INDEX}][0]
        Append to list   ${ColumnNameList2}   ${ColumnName}
    END
    
    #Verrataan uutta listaa jälleen alkuperäiseen sarakelistaan
    Should be equal   ${ColumnNameList2}   ${ColumnsInAine}

    #Loopataan uuden listan sarakkeet näkyviin
    FOR   ${item}   IN   ${ColumnNameList2}
        ${new}=   Set variable   ${item}
    END
    

*** Keywords ***    
Insert wrong data
    ${insert}=   Execute sql string   insert into aine values ('850', 'Koodauksen jatko', 'h180', 'viisi');

*** Test Cases ***
Try input wrong datatype into db
    Make connection
    
    #Katsotaan aine-taulun rivimäärä
    ${rowsInAine}=   Row count   select * from aine
    #Yritetään syöttää sarakkeen suorituspisteet kirjaimia kun pitäisi olla numeroita
    
    #Yritetään syöttää väärämuotoista dataa tietokantaan
    ${result}=   Run keyword and ignore error   Insert wrong data
    
    #Katsotaan uudelleen aine-taulun rivimäärä ja tallennetaan uuteen muuttujaan
    ${rowsInAineNew}=   Row count   select * from aine
    
    #Verrataan rivimääriä ja varmistetaan ettei väärä tieto mennyt tietokantaan läpi
    Should be equal   ${rowsInAine}   ${rowsInAineNew}      
    
    #Virheilmoituksen tulostus logiin
    Log   ${result}
