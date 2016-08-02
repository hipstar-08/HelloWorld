*** Settings ***
Documentation   Test Case with Home Page Open and signIn

Resource   resource.robot

*** Test Cases ***
Home Screen
    Open Browser To Home
    Click On Sign In
    Input Username
    Input Password
    Submit Credentials

Create Environment in Environments Page
    Go To Environments Page
    Create Environment
    Add Gateway To Environment
    Create Target Environment

Create And Upload API
    Go To API Page
    Upload JSON File
    Choose Production Environment
    Choose Target Environment
    Save API

Create Product
    Go To Products Page
    Create A Product
    Add API To Product
    Save Product

Choose Path In Product
    Go To Products Page
    Select Created Product
    Choose Base Path

Create Plan
    Add Plan To Product
    Click On Request Subscription

Approve The Subscription
    Go to Subscriptions Requests Page

Create An Applicaton
    Go To Applications Page
    Click On Register Application
    Save The Application
    Request A Key

Go To API Explorer And Request API
    Go To API Explorer In Products Page
    Click The Product
    Click API Explorer
    Expand Books List
    Select Auhor API
    Enter Author Name
    Send A Request

    #[Teardown]  Close Browser