class @ContactsCtrl
  @inject : ['$scope','dmContactsSvc']
  constructor : (@$scope, @dmContactsSvc,@$log) ->
    @$scope.contacts = []
    @$scope.fetchAll = angular.bind(this, @fetchAll)

  fetchAll : ->
    @$scope.contacts = @dmContactsSvc.all()
