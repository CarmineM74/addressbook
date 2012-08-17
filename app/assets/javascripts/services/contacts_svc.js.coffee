@app.factory('dmContactsSvc',['$resource','$log', ($resource,$log) ->
	new ContactsSvc($resource,$log) 
])

class ContactsSvc
  constructor: ($resource,$log) ->
    $log.log('Initializing Contacts Service ...')
  
  all: ->
    alert('Fetching all contacts from backend!')
