*** Settings ***
Documentation    Test suite for OrangeHRM login functionality
Library          SeleniumLibrary
Test Setup       Open Browser To OrangeHRM
Test Teardown    Close Browser
Resource         ../resources/common_keywords.robot

*** Variables ***
${BROWSER}          Chrome
${URL}              https://opensource-demo.orangehrmlive.com/
${VALID_USERNAME}   Admin
${VALID_PASSWORD}   admin123
${INVALID_USERNAME}    invalidUser
${INVALID_PASSWORD}    invalidPass
${LOGIN_PAGE_TITLE}    OrangeHRM
${DASHBOARD_URL}    https://opensource-demo.orangehrmlive.com/web/index.php/dashboard/index
${ERROR_MESSAGE}    Invalid credentials
${SCREENSHOTS_DIR}    ../screenshots

*** Keywords ***
Open Browser To OrangeHRM
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    css=input[name="username"]    timeout=10s
    Title Should Be    ${LOGIN_PAGE_TITLE}

Input Login Credentials
    [Arguments]    ${username}    ${password}
    Input Text    css=input[name="username"]    ${username}
    Input Text    css=input[name="password"]    ${password}
    Click Button    css=button[type="submit"]

*** Test Cases ***
TC01 - Valid Login
    Input Login Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Wait Until Location Is    ${DASHBOARD_URL}    timeout=10s
    Location Should Be    ${DASHBOARD_URL}
    Capture Page Screenshot    ${SCREENSHOTS_DIR}/valid_login.png
    Wait Until Page Contains Element    css=.oxd-topbar-header-title   timeout=10s

TC02 - Invalid Username
    Input Login Credentials    ${INVALID_USERNAME}    ${VALID_PASSWORD}
    Wait Until Page Contains Element    css=.oxd-alert-content-text    timeout=10s
    Element Text Should Be    css=.oxd-alert-content-text    ${ERROR_MESSAGE}

TC03 - Invalid Password
    Input Login Credentials    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Wait Until Page Contains Element    css=.oxd-alert-content-text    timeout=10s
    Element Text Should Be    css=.oxd-alert-content-text    ${ERROR_MESSAGE}

TC04 - Empty Username
    Input Login Credentials    ${EMPTY}    ${VALID_PASSWORD}
    Wait Until Page Contains Element    css=.oxd-input-field-error-message    timeout=10s
    Element Text Should Be    css=.oxd-input-field-error-message    Required

TC05 - Empty Password
    Input Login Credentials    ${VALID_USERNAME}    ${EMPTY}
    Wait Until Page Contains Element    css=.oxd-input-field-error-message    timeout=10s
    Element Text Should Be    css=.oxd-input-field-error-message    Required

TC06 - Empty Username and Password
    Input Login Credentials    ${EMPTY}    ${EMPTY}
    Wait Until Page Contains Element    css=.oxd-input-field-error-message    timeout=10s
    Element Text Should Be    css=.oxd-input-field-error-message    Required