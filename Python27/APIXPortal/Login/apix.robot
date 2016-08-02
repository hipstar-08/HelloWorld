*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Manipulate Multiple Windows
    [Tags]    MultiWindow
    Open Browser    http://localhost    firefox    IE
    ${Window1Title}=    Get Title
    Log Title
    Close Browser
