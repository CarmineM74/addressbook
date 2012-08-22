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
      .otherwise(redirectTo: '/about')
  ])

class @AddressbookCtrl
  @inject : ['$scope','$log','$http',]
  constructor : (@$scope,@$log,@$http) ->
    @$log.log('Bootstrapping application ...')
    @setupXhr()

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

