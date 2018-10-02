Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://w7fqa71cuk.execute-api.us-east-1.amazonaws.com/dev/'

* def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken



Scenario: Should return non-authenticated access

Given path 'avengers', 'anyID'
When method get
Then status 401


Scenario: Get Avenger by Id - Not Found

Given path 'avengers', 'avenger-not-found'
And header Authorization = 'Bearer ' + token
When method get
Then status 404
##And match response == {id:'#string', name: '#string', secretIdentity:'#string'}

Scenario: Create new Avenger

Given path 'avengers'
And request {name: 'Iron Fist', secretIdentity:'Dany'}
And header Authorization = 'Bearer ' + token
When method post
Then status 201
And match response == {id:'#string', name: 'Iron Fist', secretIdentity:'Dany'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == savedAvenger

Scenario: Creates a new Avenger whithout the required data

Given path 'avengers'
And request {name: 'Captain America' }
And header Authorization = 'Bearer ' + token
When method post
Then status 400


Scenario: Delete a Avenger

Given path 'avengers'
And request {name: 'Iron Fist', secretIdentity:'Dany'}
And header Authorization = 'Bearer ' + token
When method post
Then status 201
And match response == {id:'#string', name: 'Iron Fist', secretIdentity:'Dany'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404


Scenario: Delete a Avenger Not Found

Given path 'avengers', 'avengerNotFound'
And header Authorization = 'Bearer ' + token
When method delete
Then status 404

Scenario: Updates Avenger
Given path 'avengers'
And request {name: 'Iron Fist', secretIdentity:'Dany'}
And header Authorization = 'Bearer ' + token
When method post
Then status 201
And match response == {id:'#string', name: 'Iron Fist', secretIdentity:'Dany'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And request {  name : 'Black Widow',  secretIdentity : "Natasha Romanov"}
And header Authorization = 'Bearer ' + token
When method put
Then status 200
And match $.id == savedAvenger.id
And match $.name == 'Black Widow'
And match $.secretIdentity == 'Natasha Romanov'

* def alteredAvenger = $

Given path 'avengers', alteredAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == alteredAvenger

Scenario: Updates Avenger - NOT FOUND

Given path 'avengers', 'Avg-not-found'
And request { id:'Avg-not-found', name : 'Black Widow',  secretIdentity : "Natasha Romanov"}
And header Authorization = 'Bearer ' + token
When method put
Then status 404


Scenario: Update Avenger Validation

Given path 'avengers', 'pppp-aaaa-rrrr-eeee'
And request {name : "Black Widow"}
And header Authorization = 'Bearer ' + token
When method put
Then status 400

Scenario: Search Avengers by Name

Given path 'avengers'
And param name = "Black"
And header Authorization = 'Bearer ' + token
When method get
Then status 200
Then match $[*].name contains 'Widow'


Scenario: Delete All Avengers

Given path 'avengers'
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

#Scenario: Create Avenger
#
#Given path 'avengers'
#When method post
#Then status 201