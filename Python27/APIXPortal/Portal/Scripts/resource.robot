*** Settings ***
Documentation   Resource file with reusable keywords and variables import Selenium2Library
Library     Selenium2Library
Library     OperatingSystem
Library     DateTime
#pybot -d

*** Variables ***
${BaseURL}      localhost/index.php
${Browser}    gc
${Delay}    2
${username}     admin
${password}     admin
${HomeURL}      http://${BaseURL}
${Environments}  http://${BaseURL}/environments
${Api}           http://${BaseURL}/apis
${Products}     http://${BaseURL}/products
${Subscriptions}   http://${BaseURL}/subscriptions/requests
${Applications}     http://${BaseURL}/applications
${Script}       document.getElementsByClassName("upload-element")[0].childNodes[1].style.visibility= "visible"
${Inc}          5
${TargetEnv}    TargetEnv
${ProdEnv}      ProductionEnvironment
${BQJsonName}   BQ_API
${ProductName}  ProductP
${PlanName}     PlanA
${Gateway}      Gateway
${ApplicationName}  Application
${ButtonCSSname}    .btn.new-recorder.pull-left
${ApplyButton}      #row-fluid > div.pull-right > button
${SaveButton}       #adminForm > div:nth-child(1) > div > button:nth-child(1)

*** Keywords ***
Open Browser To Home
    Open Browser    ${HomeURL}  ${Browser}
    Set Selenium Speed  ${Delay}
    Home Should Be Open

Home Should Be Open
    Title Should Be  Home

Click On Sign In
    ${SignInElem}=  Get WebElement  id=login-action-button
    Click Button  ${SignInElem}

Input Username
    #[Arguments] ${username}
    Input Text  id=modlgn-username     ${username}

Input Password
#    [Arguments] ${password}
    Input Text  id=modlgn-passwd  ${password}

Submit Credentials
    Click Button    name=Submit
    #css=button[type ='submit']

Hi Administrator Should Be Displayed
    Page Should Contain     	Hi Host Administrator


Go To Environments Page
    Go To   ${Environments}
    Set Selenium Speed  3
    Wait Until Element Is Visible   css=${ButtonCSSname}
    #Create New Environment Should Be Displayed

#Create New Environment Should Be Displayed
    #Page Should Contain     Create New Environment

Create Environment
    ${GetClickEnvButton}=   Get WebElement  css=${ButtonCSSname}
    Click Button    ${GetClickEnvButton}
    Input Text  id=jform_title    ${ProdEnv}
    Select From List By Index   id=form_field_list_13   2
    Input Text  name=jform[fields][14][1][url]    localhost:9222
    Click Button    css=#adminForm > div:nth-child(1) > div > button:nth-child(1)
    #Set Selenium Speed  4
    #button[onclick='Joomla.submitbutton('form.save');']
    #adminForm > div:nth-child(1) > div > button:nth-child(1)


Add Gateway To Environment
    Wait Until Element Is Visible  css=a[class='btn btn-small']
    #Go To   ${Environments}
    #Click Element   css=a[class='btn btn-small']
    #Click Button    xpath=.//*[@id='dd-k3faa4775b79faaf511e55875e7cf87ff']/a
    ${AddGateway}=      Get WebElement  css=a[class='btn btn-small']
    Click Element   ${AddGateway}
    #a[class='btn btn-small']
    #dd-k3faa4775b79faaf511e55875e7cf87ff > a
    #xpath=.//*[@id='dd-k3faa4775b79faaf511e55875e7cf87ff']/a
    Create A New Gateway

Create A New Gateway
    Input Text  name=jform[title]     ${Gateway}
    Input Text  name=jform[fields][89][1][url]    localhost:9222
    Click Button    css=#adminForm > div:nth-child(1) > div > button:nth-child(1)

Create Target Environment
    Wait Until Element Is Visible  css=a[class='btn btn-small']
    #Wait Until Element Is Visible   css=a[href *='environments']
    Go To Environments Page
    ${GetClickEnvButton}=   Get WebElement  css=${ButtonCSSname}
    Click Button    ${GetClickEnvButton}
    Input Text  id=jform_title    ${TargetEnv}
    Select From List By Index   id=form_field_list_13   3
    Input Text  name=jform[fields][14][1][url]    localhost:7910
    Click Button    id=bool-n132
    Clear Element Text  id=field_134
    Clear Element Text  id=field_135
    Click Button    css=#adminForm > div:nth-child(1) > div > button:nth-child(1)
    #xpath = //*[@id='adminForm']/div[1]/div/button[1]
    #Wait Until Element Is Visible  css=a[href *='apis']
    Set Selenium Speed  2

Go To API Page
    Go To   ${Api}
    Create New API

Create New API
    ${GetClickAPIButton}=   Get WebElement  css=${ButtonCSSname}
    #log     ${GetClickAPIButton}
    Click Button    ${GetClickAPIButton}
    Input Text      id=jform_title    ${BQJsonName}
    Execute JavaScript      ${Script}

Upload JSON File
    #Check this code $$("input[id *='tbxFile0']")
    #${UploadFileURL}=   Get WebElement  xpath = //*[contains(@id,'tbxFile0')]
    #Log     ${UploadFileURL}
    Choose File     xpath=//*[contains(@id,'tbxFile0')]   D:\\BookQuery12.json
    Click Button    css=button[id *='btnbStart']
    #//*[contains(@id,'btnbStart')]

Choose Production Environment
    #Create Production Envrionment
    ${ChooseEnvButton}=     Get WebElement  css=a[href *='modal26']
    #xpath = //*[contains(@href,'modal26')]
    Click Button    ${ChooseEnvButton}
    ${ProdEnvFrame}=    Get WebElement  css=div[id ='modal26'] > div:nth-child(2) > iframe
    #xpath = //*[@id='modal26']/div[2]/iframe
    Select Frame    ${ProdEnvFrame}
    ${SelectProductionEnvironment} =    Get Webelement  css=a[onclick *='${ProdEnv}']
    #xpath = //*[contains(text(),'${ProdEnv}')]
    Click Element    ${SelectProductionEnvironment}
    Click Button    css=#row-fluid > div.pull-right > button
    #${ApplyButton}

    #//*[@id='row-fluid']/div[2]/button
    Unselect Frame

Choose Target Environment
    #Select Target Environment
    ${ChooseTargetEnvButton}=   Get WebElement  css=a[href *='modal147']
    #xpath = //*[contains(@href,'modal147')]
    Click Button    ${ChooseTargetEnvButton}
    ${TargetEnvFrame}=  Get WebElement  css=div[id ='modal147'] > div:nth-child(2) > iframe
    Select Frame    ${TargetEnvFrame}
    ${SelectTargetEnvironment} =    Get Webelement  css=a[onclick *='${TargetEnv}']
    #xpath = //*[contains(text(),'${TargetEnv}')]
    Click Button    ${SelectTargetEnvironment}
    Click Button    css=#row-fluid > div.pull-right > button
    Unselect Frame

Save API
    Click Button    css=#adminForm > div:nth-child(1) > div > button:nth-child(1)
    Set Selenium Speed  ${Delay}

Go To Products Page
    Go To   ${Products}

Create A Product
    ${CreateNewProductElement}=     Get WebElement  css = ${ButtonCSSname}
    Click Button    ${CreateNewProductElement}
    Input Text  id=jform_title     ${ProductName}
    Select Frame  css=div[id ='mceu_24'] > div > div:nth-child(3) > iframe
    #//*[@id='mceu_45']/iframe
    Input Text  id=tinymce  ${ProductName}
    #//*[@id='tinymce']  ${ProductName}
    Unselect Frame
    Select From List By Index   id=jformcategory   0
    # Select APIn

Add API To Product
    ${ChooseAPI}=   Get WebElement  css=a[class='btn btn-small btn-warning']
    #xpath = //*[contains(@href,'modal7')]
    Click Button    ${ChooseAPI}
    ${APIFrame}=  Get WebElement  css=div[id='modal7'] > div:nth-child(2) > iframe
    #xpath = //*[@id='modal7']/div[2]/iframe
    Select Frame    ${APIFrame}
    ${SelectAPI} =    Get Webelement  css=a[onclick *='${BQJsonName}']
    #xpath = //*[contains(text(),'${BQJsonName}')]
    Click Element    ${SelectAPI}
    Click Button    css=#row-fluid > div.pull-right > button
    #//*[@id='row-fluid']/div[2]/button
    Unselect Frame

Save Product
    Click Button    xpath = //*[@id='adminForm']/div[3]/div/button[1]
    Set Browser Implicit Wait   15
    Wait Until Element is Visible   css=a[href *='tab-api-explorer']
    #css=a[href *='tab-api-explorer']
    #xpath = //*[@id='adminForm']/div[3]/div/button[1]
    #Reload Page
    #Wait Until Element is Visible   css=a[href *='tab-api-explorer']

Select Created Product
    #Reload Page
    wait until element is visible   css=#asg-view-by-cats > div > ul > li:nth-child(1) > div.description > a > h4
    #xpath=//*[contains(text(),'Prodtest')]
    Click Element   css=#asg-view-by-cats > div > ul > li:nth-child(1) > div.description > a > h4
    ##asg-view-by-cats > div > ul > li > div.description > a > h4
    ##asg-view-by-cats > div > ul > li:nth-child(1) > div.description > a > h4
    ##ReferenceData > ul > li > div.description > a > h4

Choose Base Path
    #Set Selenium Speed  ${Delay}
    #${BasePath}=    Get WebElement    css=#content > div.contentpaneopen > article > a
    #Wait Until Element is Visible   css=a[href *='tab-api-explorer']
    #Wait Until Element Is Visible  css=#content > div.contentpaneopen > article > a
    #Go to   ${Products}
    #Click Element  h4[class ='newsflash-title products-featured-product']
    Wait Until Element Is Visible  css=#content > div.contentpaneopen > article > a
    Click Element    css=#content > div.contentpaneopen > article > a
    #${BasePath}
    ${BasePathFrame}=  Get WebElement   css=div[id='modal35'] > div:nth-child(2) > iframe
    #xpath=//*[@id='modal35']/div[2]/iframe
    Select Frame    ${BasePathFrame}
    ${SelectBasePath} =    Get Webelement   css=a[onclick *='${ProdEnv}']
    #xpath = //*[contains(text(),'${ProdEnv}')]
    Click Button    ${SelectBasePath}
    Unselect Frame

Add Plan To Product
    #Wait Until Element Is Visible  css=#content > div.contentpaneopen > article > a
    ${AddPlanButton}=   Get WebElement  css=a[class='btn btn-small']
    Click Button    ${AddPlanButton}
    Input Text  id=jform_title     ${PlanName}
    Select From List By Index   id=form_field_list_39     2
    Select Frame  css=div[id ='mceu_24'] > div > div:nth-child(3) > iframe
    Input Text  id=tinymce  ${PlanName}
    Unselect Frame
    Input Text  id=field_80   100
    Click Button    css=#adminForm > div:nth-child(1) > div > button:nth-child(1)
    #Click Button    xpath = //*[@id='adminForm']/div[1]/div/button[1]

Click On Request Subscription
    Wait Until Element Is Visible  css=a[class ='plan-modal pull-right openapi-send-request']
    ${ReqSubscription}=     Get WebElement  css=a[class ='plan-modal pull-right openapi-send-request']

    #xpath=//*[@id='tab-overview']/div/div/div/div[1]/a
    Click Button    ${ReqSubscription}
    Select CheckBox  name=agree_term
    ${ConfirmRequestElement}=   Get WebElement  css=button[class='btn btn-primary submit-plan-request']
    #xpath=//*[@id='request-plan-form-315']/form/div[2]/div[2]/div[3]/button[1]
    #request-plan-form-316 > form > div.modal-body > div.span6.pull-right > div:nth-child(5) > button.btn.btn-primary.submit-plan-request
    Click Button    ${ConfirmRequestElement}

Go to Subscriptions Requests Page
    Go To   ${Subscriptions}
    ${Requests}=     Get WebElement  css=div[class ='span8 pull-right request-tr content'] > div:nth-child(1)
    #//*[@class='span8 pull-right request-tr content']/div[1]
    Click Element    ${Requests}
    Click Button    css=button[data-target *='#approveModal']
    #//*[@class='pull-right span4']/button[1]
    ${SubsDate}=    Get Text   css=div[class ='span8 pull-right request-tr content'] > div:nth-child(1) > div:nth-child(2)
    Input Text  id=jform_publish_up        ${SubsDate}
    #Input Text  jform_publish_down      31 May 2016
    ${Approve}=   Get WebElement  css=div[class='control-group pull-right'] > button:nth-child(1)
    #xpath = //*[contains(text(),'Confirm approval')]
    Click Button    ${Approve}
    #Click Element Have to code ahead
    #$date=  Get

Go To Applications Page
    Go to   ${Applications}

Click On Register Application
    ${RequestApplication}=  Get WebElement  css=${ButtonCSSname}
    Click Element   ${RequestApplication}
    Input Text  id=jform_title     ${ApplicationName}

    Click Element   xpath=//*[contains(text(),'${ProductName}')]
    #Click Element   css=#products-list > div:nth-child(1)
    Click Element   xpath=//*[contains(text(),'${ProductName}')]/../../../div/table/tbody/tr/td[4]/a[1]
                        #products-list > div:nth-child(3) > div > div > table > tbody > tr > td.actions > a.btn.plus

Save The Application
    Click Element   css=#adminForm > div.form-horizontal.asg-create-app-form > div.form-actions > div > button:nth-child(1)

Request A Key
    Click Button   css=#content > div.contentpaneopen > article > div.app-details > div.toolbar > button:nth-child(1)

Go To API Explorer In Products Page
    Go To   ${Products}

Click The Product
    Click Element   css=#asg-view-by-cats > div > ul > li:nth-child(1) > div.description > a > h4

Click API Explorer
    #Wait Until Element Is Visible   css=
    Click Element  css=a[href *='tab-api-explorer']
    #Link=#tab-api-explorer

Expand Books List
    Click Element  id=endpointListTogger_Books

Select Auhor API
    Click Element   css=a[href *='/Books/GetBookByTitle']

Enter Author Name
    Input Text  name=Title     The Power Of Now

Send A Request
    Click Element   css=#Books_GetBookByTitle_content > form > div.sandbox_header > input
    Page Should Contain     "McGraw-Hill", loglevel=INFO