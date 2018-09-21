Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://w7fqa71cuk.execute-api.us-east-1.amazonaws.com/dev/'

Scenario: Get Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Create new Avenger

Given path 'avengers'
And request {name: 'Captain America', secretIdentity:'Steve Rogers'}
When method post
Then status 201
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}


Scenario: Creates a new Avenger whithout the required data

Given path 'avengers'
And request {name: 'Captain America' }
When method post
Then status 400


Scenario: Delete a Avenger

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method delete
Then status 204


Scenario: Updates Avenger

Given path 'avengers', 'pppp-aaaa-rrrr-eeee'
And request {  name : 'Black Widow',  secretIdentity : "Natasha Romanov"}
When method put
Then status 200
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Update Avenger Validation

Given path 'avengers', 'pppp-aaaa-rrrr-eeee'
And request {name : "Black Widow"}
When method put
Then status 400

#Scenario: Create Avenger
#
#Given path 'avengers'
#When method post
#Then status 201