*** Settings ***
Library   WhiteLibrary
Library   String
Library   Collections
Library   OperatingSystem
Library   robotkernel.whiteLibraryCompanion

*** Test Cases ***
Open application
    Launch application   C:/Users/jenna/Documents/CRM/MyCRM.exe
    Attach application by name   MyCRM
    Sleep   2s
    @{win}=   Get application windows
    Attach window   ${win}[0]
    
Clear fields
    Click menu button   text:File
    Click menu button   text:Clear Fields
    ${textField}=   Get text from textbox   text:First:
    Should be empty   ${textField}
    
Read data from text file
    ${path}=   Set variable   C:/Users/jenna/Documents/CRM/crm_data.txt
    ${output}=   Get file   ${path}
    @{wordList}=   Split string   ${output}
    Set global variable   ${wordList}
    
Insert info from list
    #Name fields
    Input text to textbox   id:textBoxPeopleFirstName   ${wordList}[0]
    Input text to textbox   id:textBoxPeopleLastName   ${wordList}[1]
    Click item   text:${wordList}[2]
    
    #Address fields
    Input text to textbox   id:textBoxPeopleAddLine1   ${wordList}[3]
    Input text to textbox   id:textBoxPeopleAddLine2   ${wordList}[4]
    Input text to textbox   id:textBoxPeopleAddressCity   ${wordList}[5]
    Click item   id:DropDown
    Click item   text:${wordList}[6]
    
    #Zip-code and comparing it to the value in list
    Input text to textbox   id:textBoxPeopleAddressZip   ${wordList}[7]
    ${zip}=   Get text from textbox   id:textBoxPeopleAddressZip
    Should be equal   ${zip}   ${wordList}[7]
    
    #Phone Fields
    Input text to textbox   id:textBoxPeopleHomePhone   ${wordList}[8]
    Input text to textbox   id:textBoxPeopleWorkPhone   ${wordList}[9]
    Input text to textbox   id:textBoxPeopleMobilePhone   ${wordList}[10]
    
    #Email fields
    Input text to textbox   id:textBoxPeoplePersonalEmail  ${wordList}[11]
    Input text to textbox   id:textBoxPeopleWorkEmail   ${wordList}[12]
    
    #Click Zip verify box
    Click button   id:btnZip
    
    #Click Active checkbox
    Click item   id:checkBox1
    
Switch to Other tab to Save and Browse
    Click item   text:Other
    
    #Click Save button and OK
    Click button   id:button1
    Click button   text:OK
    
    #Click Browse button and OK
    Click button   id:button2
    Click button   text:OK
    
Disable and Enable All
    #Disable
    Click menu button   text:File
    Click menu button   text:Disable All
    Item should be disabled   id:tabControl1
    
    #Enable
    Click menu button   text:File
    Click menu button   text:Enabled All
    Item should be enabled   id:tabControl1
    
    Close application
   


