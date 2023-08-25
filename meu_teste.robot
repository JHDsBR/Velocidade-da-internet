*** Settings ***
Documentation       Verificar velocidade da internet
Library             SeleniumLibrary

*** Variables ***
${input_search}         id:APjFqb
${BROWSER}              chrome
${BASE_URL}             https://www.google.com/
${valor_atributo}       fast.com.br

*** Test Cases ***
Buscar no google
    Carregar o site
    Inserir busca
    Clicar em buscar

Escolher site
    Escolher site Fast.com
    # Clicar no site

Verificar velocidade
    Esperar calcular velocidade
    Pegar resultado
    Mostrar resultado

*** Keywords ***

Carregar o site
    Open Browser        ${BASE_URL}    ${BROWSER}

Inserir busca
    Wait Until Page Contains Element        ${input_search}     timeout=10s
    Input Text                              ${input_search}     Teste

Clicar em buscar
    Press Key                               ${input_search}     \\13
    # Sleep                                   10s

Escolher site Fast.com
    Clicar em Fast.com


Clicar em Fast.com
    Esperar Carregar

    ${elementos}    Get WebElements    css=a[jscontroller="M9mgyc"]
    
    FOR    ${elemento}    IN    @{elementos}
        
        ${valor_atributo}    Get Element Attribute    ${elemento}    href
        
        IF    'fast.com' in '${valor_atributo}'
            Click Element    ${elemento}
            Return From Keyword
        END
    END



Esperar Carregar
    Wait Until Page Contains Element    css=body    timeout=10s

Esperar calcular velocidade
    Wait Until Element Is Visible   css=.speed-progress-indicator.circle.succeeded      timeout=60

Pegar resultado 
    ${elemento_speed}       Get WebElement      xpath=//*[@id="speed-value"]
    ${elemento_units}       Get WebElement      xpath=//*[@id="speed-units"]

    ${speed_value}          Get Text            ${elemento_speed}
    ${speed_units}          Get Text            ${elemento_units}

    ${speed_result}         Catenate            ${speed_value}  ${speed_units}  
    Set Test Variable       ${speed_result}     # permite que essa variável seja acessada em outras keywords

Mostrar resultado
    Log     Sua velocidade é: ${speed_result}

