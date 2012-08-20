@app.factory('dmContactsSvc',['$resource','$log', ($resource,$log) ->
	new ContactsSvc($resource,$log) 
])

class ContactsSvc
  constructor: ($resource,@$log) ->
    @$log.log('Initializing Contacts Service ...')
    @contacts = $resource('http://192.168.1.95:port/:path/:contact_id'
      ,{port: ':3000', path: 'contacts'}
      ,{index: {method: 'GET', isArray: true}
      ,create: {method: 'POST'}
      ,update: {method: 'PUT'}
      ,destroy: {method: 'DELETE'}}
    )

  destroy: (contact, success, error) ->
    contact.$destroy({contact_id: contact.id},
      (res,deleteResponseHeaders) -> success(res,deleteResponseHeaders),
      -> error()
    )

  save: (contact, success, error) ->
    if contact.id?
      contact.$update({contact_id: contact.id},
        (res,putResponseHeaders) -> success(res,putResponseHeaders),
        -> error()
      )
    else
      c = new @contacts(contact)
      c.$save(
        (res,putResponseHeaders) ->
          if typeof success == 'function'
            success(res,putResponseHeaders)
        , ->
          if typeof error == 'function'
            error()
      )  

  all: (success, error) ->
    @$log.log('Fetching contacts from backend ...')
    @contacts.index((response, getResponseHeaders) ->  
      if typeof success == 'function'
        success(response, getResponseHeaders)
     , ->
       if typeof error == 'function'
         error()
    )
