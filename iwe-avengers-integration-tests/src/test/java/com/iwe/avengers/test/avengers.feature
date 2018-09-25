Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://w7fqa71cuk.execute-api.us-east-1.amazonaws.com/dev/'

Scenario: Get Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Get Avenger by Id - Not Found

Given path 'avengers', 'avenger-not-found'
When method get
Then status 404
##And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Create new Avenger

Given path 'avengers'
And request {name: 'Iron Fist', secretIdentity:'Dany'}
When method post
Then status 201
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}


Scenario: Creates a new Avenger whithout the required data

Given path 'avengers'
And request {name: 'Captain America' }
When method post
Then status 400


Scenario: Delete a Avenger

Given path 'avengers', 'IssoFoiGerado'
When method delete
Then status 204


Scenario: Delete a Avenger Not Found

Given path 'avengers', 'aaaa-bbbb-cccc-eeee'
When method delete
Then status 404

Scenario: Updates Avenger

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {  name : 'Black Widow',  secretIdentity : "Natasha Romanov"}
When method put
Then status 200
And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Updates Avenger - NOT FOUND

Given path 'avengers', 'Avg-not-found'
And request { id:'Avg-not-found', name : 'Black Widow',  secretIdentity : "Natasha Romanov"}
When method put
Then status 404


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