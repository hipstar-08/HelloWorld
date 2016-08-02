*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Manipulate Multiple Windows
    [Tags]    MultiWindow
    Open Browser    http://robotframework.org    firefox
    Maximize Browser Window
    ${Window1Title}=    Get Title
    Wait Until Element Is Visible    css=div.button.orange    10s
    Click Element    css=div.button.orange
    Wait Until Element Is Visible    link=Builtin
    Click Element    link=Builtin
    Comment    This is a new Window
    Sleep    5s
    Select Window    Title=Robot Framework documentation
    Wait Until Element Is Visible    //button[@value='BuiltIn']
    Click Element    //button[@value='BuiltIn']
    Sleep    5s
    Select Window    Title=Builtin
    Comment    Go back to the first window
    Sleep    5s
    Select Window    Title=${Window1Title}
    Page Should Contain Element    link=Builtin
    Close Browser