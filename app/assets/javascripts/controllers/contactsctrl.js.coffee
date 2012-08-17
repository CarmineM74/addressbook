class @ContactsCtrl
  @inject : ['$scope','dmContactsSvc']
  constructor : (@$scope, @dmContactsSvc) ->
    @$scope.contacts = []
    @$scope.fetchAll = angular.bind(this, @fetchAll)

  fetchAll : ->
    @dmContactsSvc.all()
