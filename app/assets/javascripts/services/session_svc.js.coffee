@app.factory('dmSessionSvc',['$resource','$log','$location', ($resource,$log,$location) ->
	new SessionSvc($resource,$log,$location) 
])

class SessionSvc
  constructor: ($resource,@$log,@$location) ->
    @$log.log('Initializing Session Service ...')
    @current_user = undefined
    @sessions = $resource('http://192.168.1.95:port/:path/:user_id'
      ,{port: ':3000', path: 'sessions'}
      ,{create: {method: 'POST'}
      ,destroy: {method: 'DELETE'}}
    )

  authenticatedOrRedirect: (path) ->
    @$log.log('Checking authentication ...')
    if @current_user?
      return true
    else
      @$log.log('Not authenticated. Redirecting to: ' + path)
      @$location.path(path)
      return false

  logout: (success, error) ->
    user.$destroy({user_id: @current_user.id},
      -> success(),
      (failure) -> error(failure)
    )
    @current_user = undefined

  login: (user, success, error) ->
    if @current_user?
      success(@current_user)
    else
      @sessions.create({email: user.email, password: user.password},
         (user) => @loginSuccessful(user,success), 
         (failure) => @loginFailed(failure,error)
      )

  loginSuccessful : (user,cb) ->
    @$log.log('Login successful: ' + JSON.stringify(user))
    @current_user = user
    cb(@current_user)

  loginFailed : (failure,cb) ->
    @$log.log('Login failed: ' + JSON.stringify(failure))
    @current_user = undefined
    cb(failure)
