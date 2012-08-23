@app = angular.module('addressbook',['ngResource','ui','addressbookFilters'])
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when('/contacts', 
        {controller: ContactsCtrl, templateUrl: 'assets/contacts.html'}
      )
      .when('/about',
        {controller: ToyCtrl, templateUrl: 'assets/about.html'}
      )
      .when('/users',
        {controller: UsersCtrl, templateUrl: 'assets/users.html'}
      )
      .when('/login',
        {controller: AddressbookCtrl, templateUrl: 'assets/login.html'}
      )
      .otherwise(redirectTo: '/about')
  ])

class @AddressbookCtrl
  @inject : ['$scope','$log','$http','$location','dmSessionSvc']
  constructor : (@$scope,@$log,@$http,@$location,@dmSessionSvc) ->
    @$log.log('Bootstrapping application ...')
    @setupXhr()
    @$scope.loginInfo = {email: '', password: ''}
    @$scope.login = angular.bind(this,@login)
    @$scope.logout = angular.bind(this,@logout)

  login : ->
    @$log.log('Logging in ...')
    @dmSessionSvc.login(@$scope.loginInfo,
      (user) => @loginSuccessful(user),
      (failure) => @loginFailed(failure))
  
  loginSuccessful : (user) ->
    @$location.path('/contacts')

  loginFailed : (failure) ->
    alert(JSON.stringify(failure.data.error))
    @$location.path('/login')

  logout : ->
    @$log.log('Logging out ...')
    @dmSessionSvc.logout((failure) -> alert(failure))

  setupXhr : ->
    @$log.log('setup HTTP default headers ...')
    @$http.defaults.headers.common['Content-Type'] = 'application/json'
    @$http.defaults.headers.post['Content-Type'] = 'application/json'
    @$http.defaults.headers.put['Content-Type'] = 'application/json'
    if token = $("meta[name='csrf-token']").attr("content")
      @$http.defaults.headers.post['X-CSRF-Token'] = token
      @$http.defaults.headers.put['X-CSRF-Token'] = token
      @$http.defaults.headers.delete ||= {}
      @$http.defaults.headers.delete['X-CSRF-Token'] = token

