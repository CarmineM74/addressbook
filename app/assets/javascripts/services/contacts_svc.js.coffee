@app.factory('dmContactsSvc',['$resource','$log', ($resource,$log) ->
	new ContactsSvc($resource,$log) 
])

class ContactsSvc
  constructor: ($resource,@$log) ->
    @$log.log('Initializing Contacts Service ...')
    @contacts = $resource('http://192.168.1.95:port/:path'
      ,{port: ':3000', path: 'contacts.json'}
      ,{index: {method: 'GET', isArray: true}}
    )
  
  all: ->
    @$log.log('Fetching contacts from backend ...')
    @contacts.index()
