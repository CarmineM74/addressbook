@app = angular.module('addressbook',['ngResource'])

class @AddressbookCtrl
  @inject : ['$scope','$log','$http']
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

