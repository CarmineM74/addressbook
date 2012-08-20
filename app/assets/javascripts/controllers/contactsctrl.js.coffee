class @ContactsCtrl
  @inject : ['$scope','dmContactsSvc']
  constructor : (@$scope, @dmContactsSvc,@$log) ->
    @$scope.contacts = []
    @$scope.fetching = false
    @$scope.fetchAll = angular.bind(this, @fetchAll)

  fetchAll : ->
    @$scope.fetching = true
    @$scope.contacts = @dmContactsSvc.all( (res) =>
      @$log.log(res)
      @$scope.fetching = false
     , =>
        @$scope.fetching = false
        alert('Error while fetching contacts!')
    )
