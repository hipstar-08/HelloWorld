*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library

*** Variables ***
${SERVER}         localhost
${BROWSER}        Firefox
${DELAY}          1000
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/index.html


*** Keywords ***
Open Browser to Home
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    wait until page contains element