@app.factory('dmSessionSvc',['$resource','$log','$location','appConfig', ($resource,$log,$location,appConfig) ->
	new SessionSvc($resource,$log,$location,appConfig) 
])
@app.factory('testInterceptor',['$rootScope','$q','$log',($rootScope,$q,$log) ->
    i = new TestInterceptor($rootScope,$q,$log)
    return i.interceptor
])
@app.config(['$httpProvider',($httpProvider) ->
    $httpProvider.responseInterceptors.push('testInterceptor')
])
  

class TestInterceptor
  constructor: (@$rootScope, @$q, @$log) ->
    @$log.log('Instantiating TestInterceptor ...')

  interceptor: (promise) =>
    @$log.log('Returning a new interceptor with promise ...')
    promise.then(@success,@error)

  success: (response) =>
    @$log.log('Success case: ' + JSON.stringify(response))
    response

  error: (response) =>
    @$log.log('Error case: ' + JSON.stringify(response))
    if response.status == 401
      deferred = @$q.defer()
      @$log.log('Broadcasting event:testInterceptor-ERROR')
      @$rootScope.$broadcast('event:testInterceptor-ERROR')
      return deferred.promise
    else
      @$q.reject(response)

class SessionSvc
  constructor: ($resource,@$log,@$location,@appConfig) ->
    @$log.log('Initializing Session Service ...')
    @current_user = undefined
    @sessions = $resource('http://:serverAddress:port/:path/:user_id'
      ,{serverAddress: appConfig.serverAddress, port: appConfig.serverPort, path: 'sessions'}
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
