@app.factory('dmContactsSvc',['$resource','$log','appConfig', ($resource,$log,appConfig) ->
	new ContactsSvc($resource,$log,appConfig) 
])

class ContactsSvc
  constructor: ($resource,@$log,@appConfig) ->
    @$log.log('Initializing Contacts Service ...')
    @contacts = $resource('http://serverAddress:port/:path/:contact_id'
      ,{serverAddress: appConfig.serverAddress, port: appConfig.serverPort, path: 'contacts'}
      ,{index: {method: 'GET', isArray: true}
      ,toPdf: {method: 'GET'}
      ,create: {method: 'POST'}
      ,update: {method: 'PUT'}
      ,destroy: {method: 'DELETE'}}
    )

  toPdf: ->
    @contacts.toPdf({path: 'contacts.pdf'})

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
