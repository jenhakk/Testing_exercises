# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .robot
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.3.2
#   kernelspec:
#     display_name: Robot Framework
#     language: robotframework
#     name: robotkernel
# ---

*** Settings ***
Library   SeleniumLibrary
Library   OperatingSystem
Library   String

*** Variables ***
${email}   daisy.duck@duckburg.com
${password}   duckendaal
${firstName}   Daisy
${lastName}   Duck
${phoneNumber}   050 1234567

# +
*** Keywords ***
Clear text field
     [Arguments]   ${inputField}
     press keys   ${inputField}   CTRL+A   BACKSPACE     

Get CSS Property Value
    [Arguments]    ${locator}    ${attribute name}
    ${css}=         Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    [Return]     ${prop_val}
# -

*** Test Cases ***
Open browser and allow cookies
    #TONI NURMI
    Open browser   https://www.verkkokauppa.com
    Maximize browser window
    Wait until page contains   Evästeiden käytöstä   
    Click element   xpath://*[@id="allow-cookies"]

*** Test Cases ***
Test if the icons of product categories exist
    #TONI NURMI
    
    #Check if the menu is open
    ${bars}=   Run keyword and return status   Element should be visible   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app header.sc-1vuessv-0.hSrwis.app__header.right-scroll-bar-position div.header label.sc-26n4fx-2.sc-i6f0oa-0.jmTgVL.fLYqfq svg.icon-sc-td2w5n-0.sc-26n4fx-0.YZaTH
    Run keyword if   ${bars}   Click element   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app header.sc-1vuessv-0.hSrwis.app__header.right-scroll-bar-position div.header label.sc-26n4fx-2.sc-i6f0oa-0.jmTgVL.fLYqfq svg.icon-sc-td2w5n-0.sc-26n4fx-0.YZaTH
    
    #Get a count of categories
    Wait until element is enabled   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[1]/a/span[2]
    ${categories}=   Get element count   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[*]/a/span[2]

    #Get a count of icons
    ${icons}=   Get element count   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[*]/a/span[1]
    
    #Test
    Should be equal   ${categories}   ${icons}
    Set global variable   ${categories}

*** Test Cases ***
Check if each category has a working landing page
    #TONI NURMI
    FOR   ${index}   IN RANGE   1   ${categories}
    
        Exit for loop if   ${index} == 26
                
        #Open a page and save the name as a variable for comparison
        Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[${index}]
        ${name}=   Get text   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[${index}]
        Wait until page contains element   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
        ${compare}=   Get text   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
        Should be equal   ${name}   ${compare}
        
        #Scroll down
        Run keyword if   ${index} == 7   Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[3]/div[2]
        Run keyword if   ${index} == 11   Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[3]/div[2]
        
    END
    
    #26th element is missing because it's a divider, so the rest is done manually
    #Scroll down
    Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[3]/div[2]
    
    Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[27]
    ${name}=   Get text   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[27]
    Wait until page contains element   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
    ${compare}=   Get text   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
    Should be equal   ${name}   ${compare}
    
    Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[28]
    ${name}=   Get text   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[28]
    Wait until page contains element   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
    ${compare}=   Get text   xpath: /html/body/div[1]/div[1]/div/div/div/a[2]
    Should be equal   ${name}   ${compare}
    
    Click element   xpath: /html/body/div[1]/div[1]/div/aside/nav/div/div[2]/ul/li[29]
    Wait until page contains element   xpath: /html/body/div[1]/div[1]/div/div/main/div/div/div/div[1]/div/img

# +
*** Test Cases ***
Search functions functionality and does the link work as expected
    #ANNA-MARIA PALM
    #Write 'PS5' to a search function
    Input text    xpath:/html/body/div[1]/div[1]/header/div/nav/form/div/input   PS5
    Wait until page contains   Pelit ja viihde
    Click element   xpath:/html/body/div[1]/div[1]/header/div/nav/form/div/div/button[2]
    Wait until page contains   Uuden sukupolven PlayStation

    #Take a screenshot of the first result and save it to a new folder
    Sleep   3s
    ${path}=   Set variable    C:/Users/tompp/Desktop/project/
    Set global variable   ${path}
    ${snapshot}=   Set variable   pic1.png
    Set global variable   ${snapshot}
    Set screenshot directory    ${path}
    Capture element screenshot   xpath:/html/body/div[1]/div[1]/div/div/main/div/div[2]/div[1]/ol/li[1]/article/div/div[2]/div/div   ${path}${snapshot}
    #Navigate to a product page (of the first result)
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div[2]/div[1]/ol/li[1]/article/a
    #Check if the reached page is the right page, the page should contain "PlayStation"
    Page should contain   PlayStation

Comparing the screenshots
    ${snapshot2}=   Set variable   pic2.jpg
    sleep   3s
    Capture element screenshot   css: html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp main#main.page.page--product section.page__product aside.product__main-view div.main-view__gallery div.main-view-gallery div.fullscreen div.ratio-gallery-with-thumbnails div.ratio-gallery-carousel ul.ratio-carousel.ratio-carousel--gallery li.ratio-carousel__slide span.slide__gallery-slide.slide__gallery-slide--active picture.Picture-sc-uof9rq-0.cvsAIK.sc-1hx3h3x-0.fUcKHo img   ${path}${snapshot2}
    #Comparing snapshots
    ${rc}=    Run and return rc and output    magick ${path}${snapshot} ${path}${snapshot2} -metric RMSE -compare -format "%[distortion]" info:
    ${rc}=    Convert to string    ${rc}
    ${pituus}=    Get length   ${rc}
    ${rc}=    Run keyword if   ${pituus}>8    Get substring   ${rc}   5   11
    ${rc}=    Run keyword if   ${pituus}>8    Evaluate    ${rc}*100
    
    #The difference should be less than 5 %
    Run keyword and ignore error   Should be true   ${rc} < 5
    
    Run keyword if   ${pituus}>8   Run keyword if   ${rc}>=5   run   magick ${path}${snapshot2} ${path}${snapshot} -metric RMSE -compare ${path}robotDiff.png
# -

*** Test Cases ***
Testing if the page contains two particular sections
    #ANNA-MARIA PALM
    Page should contain   Esittely
    Page should contain   Lisätiedot
    
    Click element   xpath://*[@id="tabs-page-select-tab0"]
    
    Page should contain   Tuotenumero
    Page should contain   Tuotteen laatu
    Page should contain   Vastinetta rahalle
    Page should contain   Käyttömukavuus
    
    Click element   xpath://*[@id="tabs-page-select-tab1"]
    Page should contain   Takuutiedot
    Page should contain   Huolto ja palautukset
    Page should contain   Myyntihistoria
    
    #Back to frontpage
    Click element   css: html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app header.sc-1vuessv-0.hSrwis.app__header.right-scroll-bar-position div.header h1.sc-hnczcz-0.byBpQD a.sc-hnczcz-0.byBpQD svg.VkLogo-sc-1l5lj7b-0.eyYmPF
    

*** Test Cases ***
Find product from the page
    #JENNA HAKKARAINEN
    #Navigoidaan "Joululahjat"-sivulle
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div[1]/div[1]/a
    
    #Syötetään hakukenttään "paistinpannu"
    Wait until element is visible   xpath://*[@id="query"]
    Click element   xpath://*[@id="query"]
    Input text   xpath://*[@id="query"]   paistinpannu
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/form/button
    
    #Suodatetaan tuotteet valmistajan perusteella
    Wait until element is visible   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/span/div/button[2]
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/span/div/button[2]
    
    #Valitaan Tefal
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/div/div[4]/div/div/div/div[3]/section/ol/li[3]/label/span[1]
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/div[2]/div[4]/div/div/footer/button[2]/span[1]
    
    #Suodatetaan tuotteet hinnan perusteella
    ${minPrice}=   Set variable   xpath://*[@id="min"]
    ${maxPrice}=   Set variable   xpath://*[@id="max"]
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/span/div/button[3]
    
    #Laitetaan minimihinnaksi 25
    Double Click element   ${minPrice}
    Run keyword   Clear text field   ${minPrice}
    Input text   ${minPrice}   25
    
    #Laitetaan maksimihinnaksi 75
    Double Click element   ${maxPrice}
    Run keyword   Clear text field   ${maxPrice}
    Input text   ${maxPrice}   75
    
    #Painetaan suodata-painiketta
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[1]/div[1]/div/div[2]/div[4]/div/div/footer/button[2]
    
    #Valitaan listan ensimmäinen tuote
    Page should contain element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[2]/div/ol/li[1]/article/a
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div/div/div/div[4]/div/div/div[2]/div/ol/li[1]/article/a
    Page should contain   Esittely


*** Test Cases ***
Check product availability
    #JENNA HAKKARAINEN
    #Tallennetaan muuttujaan vihreä väri joka merkkaa tuotteen saatavuutta
    ${expectedColor}=   Set variable   rgb(20, 160, 6)
    
    Page should contain   Myymäläsaatavuus
    
    #Scrollataan tarvittaessa alas ja avataan dropdown ja valitaan sieltä Helsingin myymälä
    ${saatavuus}=   Run keyword and return status   Element should be visible   xpath://*[@id="store-availability-699224-label"]
    Run keyword unless   ${saatavuus}   Press keys   xpath://body   \ue00F
    Click element   xpath://*[@id="store-availability-699224-label"]
    Click element   xpath:/html/body/div[2]/div/div[3]/article/div[2]/div/label[1]/span
    
    #Haetaan valitun myymälän pallurasta värikoodi ja verrataan sitä oletettuun värikoodiin
    ${style}=   Get CSS Property Value   xpath:/html/body/div[1]/div[1]/div/div/main/section/aside/div[2]/div[2]/div[2]/div[1]/button/span/i  border-bottom-color
    Should be equal   ${style}   ${expectedColor}
    
    #Tarkistetaan verkkokaupan saatavuus vertaamalla palluran väriä oletettuun värikoodiin
    ${style}=   Get CSS Property Value   xpath:/html/body/div[1]/div[1]/div/div/main/section/aside/div[2]/div[2]/div[1]/div[1]/i   border-bottom-color
    Should be equal   ${style}   ${expectedColor}
    Press keys   xpath://body   \ue00E

# +
*** Test Cases ***
Add product successfully to the shopping cart and edit it
    #JENNA HAKKARAINEN
    #Lisätään tuote ostoskoriin painamalla "Lisää ostoskoriin"-painiketta
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/section/aside/div[2]/div[2]/div[1]/div[2]/button[1]
    
    #Mene ostoskoriin
    Click element   css: html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app header.sc-1vuessv-0.hSrwis.app__header.right-scroll-bar-position div.header nav.header__navigation div.header__navigation-icons span#checkout.navigation-icons__link.navigation-icons__link--shopping-cart svg.icon-sc-td2w5n-0.YZaTH
    Sleep   1
    Click element   css: html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app header.sc-1vuessv-0.hSrwis.app__header.right-scroll-bar-position div.header nav.header__navigation div.header__navigation-icons span#checkout.navigation-icons__link.navigation-icons__link--shopping-cart
    Wait until page contains element   xpath: /html/body/div[1]/div[1]/div/div/main/div[2]/section/div[1]/div/a
    
    #Lisätään tuote ostoskoriin paimalla tuotteen ostoskori-painiketta
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/div[1]/div/div/ol/li/div/div/button
    Sleep   1
    
    #Lisätään tuotteen määrää yhdellä painamalla +-nappia
    Click button   xpath: /html/body/div[1]/div[1]/div/div/main/div[2]/section/div[1]/div[1]/article/div/div[2]/div/div/div[2]/div/div/div[3]/button
    
    #Poistetaan äsken lisätyt tuotteet kirjoittamalla tuotteen määrän tekstikenttään 0
    ${toBeDeletedInputField}=   Set variable   xpath://*[@id="quantity"]
    Double click element   ${toBeDeletedInputField}
    Run keyword   Clear text field   ${toBeDeletedInputField}
    Input text   ${toBeDeletedInputField}   0
    
    Sleep   3
    Page should contain   1 tuote, yhteensä
    
    #Siirrytään kassalle painamalla Siirry kassalle-painiketta
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/div[5]/section/button



# +
*** Test Cases ***
Input information to registration form
    #AMANDA KARJALAINEN
    # klikataan 'Luo uusi asiakkuus'-linkkiä
    Click element   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp div.page.page--login div.split-blocks div.split-blocks.split-blocks--centered.l div.block.block--blue.block--full-width.block--new-customer a#register-button.Button-sc-mt7im1-0.sc-p4y2f5-0.ezZQIP.jEKFKr
    Wait until page contains   Asiakkuuden luonti
    Page should contain   Asiakkuuden luonti
    
    #email
    Click element   xpath://input[@name="email"]
    Input text   xpath://input[@name="email"]   ${email}
    
    # password
    Click element   xpath://input[@name="password"]
    Input text   xpath://input[@name="password"]   ${password}
    
    # first- and lastnames
    Click element   xpath://input[@name="firstname"]
    Input text   xpath://input[@name="firstname"]   ${firstName}
    
    Click element   xpath://input[@name="lastname"]
    Input text   xpath://input[@name="lastname"]   ${lastName}
    
    # phone number
    Click element   xpath://input[@name="phoneMobile"]
    Input text   xpath://input[@name="phoneMobile"]   ${phoneNumber}
    
    # language
    Click element   name:language
    Select from list by value   name:language   fi
    
Read privacy statement and close window
    # klikataan 'Tietosuojaseloste'-linkki auki ja varmistetaan, että ollaan oikealla sivulla.
    Click link   xpath:/html/body/div[1]/div[1]/div/div/div/form/fieldset/div[7]/label/span/a
    Page should contain   Tietosuojaseloste
    Sleep   2
    
    # suljetaan tietosuojaselosteen ikkuna ja jatketaan rekisteröintilomaketta.
    ${windowhandles} =   Get Window Handles
    Switch Window    ${windowhandles}[1]
    Close window
    Switch Window    ${windowhandles}[0]
    
Click privacy statement checkbox activated and complete registration
    # klikkaa checkbox aktiiviseksi (olet lukenut ja hyväksynyt tietoturvaselosteen)
    Click element   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp div.page.page--register form.sc-1n4x7vk-0.cDmiGk fieldset.sc-1n4x7vk-1.excPhV div.sc-1n4x7vk-4.bLnkLQ label.selector.selector--checkbox
    
    # klikkaa 'Lähetä tiedot'-nappia
    Click button   id:create-account-button

# +
*** Test Cases ***
Sign in to user Daisy Duck
    #AMANDA KARJALAINEN
    # palataan kirjautumis-sivulle
    Click link   xpath:/html/body/div[1]/div[1]/div/div/div/div/a
    
    # täytetään sähköpostiosoite ja klikataan 'Jatka'-nappia
    Page should contain   Kirjaudu sisään antamalla sähköpostiosoitteesi.
    Input text   xpath://input[@name="email"]   ${email}   
    Click button   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp div.page.page--login div.split-blocks div.block.block--centered.block--compact form.auth-form fieldset.auth-form__fieldset.auth-form button#login-button.Button-sc-mt7im1-0.ezZQIP
    
    # täytetään salasana
    Page should contain element   id:login-form-email
    Page should contain element   xpath:/html/body/div[1]/div[1]/div/div/div/div[2]/div[1]/form/fieldset[1]/div[1]/p
    Page should contain   Vaihda unohtunut salasana
    Input text   xpath://input[@name="password"]   ${password}  
    Click button   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp div.page.page--login div.split-blocks.split-blocks--centered div.block.block--full-width.block--compact form.auth-form fieldset.auth-form__fieldset.auth-form button#login-button.Button-sc-mt7im1-0.ezZQIP
    
Check that information are correct
    # varmistetaan, että ollaan 'Asiakastiedot'-tabissa
    Wait until page contains   Asiakastiedot
    Page should contain   Asiakastilin haltija
    
    # etu- ja sukunimi
    ${customerName} =   Get text   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section/div/div[2]/div/div[1]/dl/dd[1]
    @{customerName} =   Split string   ${customerName}
    ${customerFirstName} =   Set variable   ${customerName}[0]
    ${customerLastName} =   Set variable   ${customerName}[1]
    Should be equal   ${firstName}   ${customerFirstname}
    Should be equal   ${lastName}   ${customerLastName}
    
    # email
    ${customerEmail} =   Get text   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section/div/div[2]/div/div[2]/dl/dd[1]
    Should be equal   ${email}   ${customerEmail}
    
    # puhelinnro
    ${customerPhoneNumber} =   Get text   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section/div/div[2]/div/div[2]/dl/dd[2]
    Should be equal   ${phoneNumber}   ${customerPhoneNumber}
    
Change settings

    # vaihdetaan 'Asetukset'-tabiin
    Click element   xpath://*[@id="tabs-account-tab-tab2"]
    
    # varmistetaan, että ollaan 'Asetukset'-tabissa
    Page should contain   Yksityisyys
    
    # säädetään asetuksia
    # selaushistoriaan perustuva viestintä off
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section[1]/div/div[2]/div/section[3]/h4/label/span[1]
    
    # tuotearvostelupyynnöt off
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section[1]/div/div[2]/div/section[2]/h4/label/span[1]
    Sleep   3
    
    # Google-markkinointi off
    Click element   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/section[2]/div/div[2]/section[1]/h4/label/span[1]
    
    # katsotaan kirjautumishistoria
    Click button   xpath:/html/body/div[1]/div[1]/div/div/main/div[2]/div[2]/div[1]/button
    
    # kirjaudutaan ulos
    Click element   css:html.js.app-ready.ready body div#app div.sc-pdu87j-2.fKyBA-D.app div.sc-pdu87j-1.bBaYUE.app__content div.sc-pdu87j-0.gFTWAp main#main.page.page--account div.heading-wrapper div.sc-18qrc7-1.jTDpjO span.sc-18qrc7-2.eHwPep
    Page should contain   Kirjaudu

# +
#JENNA HAKKARAINEN, AMANDA KARJALAINEN, TONI NURMI, ANNA-MARIA PALM
