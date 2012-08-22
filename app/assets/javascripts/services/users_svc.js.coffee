@app.factory('dmUsersSvc',['$resource','$log', ($resource,$log) ->
	new UsersSvc($resource,$log) 
])

class UsersSvc
  constructor: ($resource,@$log) ->
    @$log.log('Initializing Userss Service ...')
    @users = $resource('http://192.168.1.95:port/:path/:user_id'
      ,{port: ':3000', path: 'users'}
      ,{index: {method: 'GET', isArray: true}
      ,create: {method: 'POST'}
      ,update: {method: 'PUT'}
      ,destroy: {method: 'DELETE'}}
    )

  destroy: (user, success, error) ->
    user.$destroy({user_id: user.id},
      (res,deleteResponseHeaders) -> success(res,deleteResponseHeaders),
      -> error()
    )

  save: (user, success, error) ->
    if user.id?
      user.$update({user_id: user.id},
        (res,putResponseHeaders) -> success(res,putResponseHeaders),
        -> error()
      )
    else
      c = new @users(user)
      c.$save(
        (res,putResponseHeaders) ->
          if typeof success == 'function'
            success(res,putResponseHeaders)
        , ->
          if typeof error == 'function'
            error()
      )  

  all: (success, error) ->
    @$log.log('Fetching users from backend ...')
    @users.index((response, getResponseHeaders) ->  
      if typeof success == 'function'
        success(response, getResponseHeaders)
     , ->
       if typeof error == 'function'
         error()
    )
