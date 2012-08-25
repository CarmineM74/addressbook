class @UsersCtrl
  @inject : ['$scope','dmUsersSvc']
  constructor : (@$scope, @dmUsersSvc,@$log) ->
    @$scope.users = []
    @$scope.fetching = false
    @$scope.selectedUser = {}
    @$scope.formCaption = ''
    @$scope.formTitle = ''
    @$scope.formSubmitCaption = ''

    @$scope.newUser = angular.bind(this, @newUser)
    @$scope.fetchAll = angular.bind(this, @fetchAll)
    @$scope.selectUser = angular.bind(this, @selectUser)
    @$scope.saveUser = angular.bind(this, @saveUser)
    @$scope.deleteUser = angular.bind(this, @deleteUser)
    @$scope.exportToPDF = angular.bind(this, @exportToPDF)

  exportToPDF : ->
    @$log.log('Exporting users to PDF ...')
    @dmUsersSvc.toPdf()

  deleteUser : (user) ->
    @$log.log('Removing user from backend ...')
    @dmUsersSvc.destroy(user,
      => alert('Removed'),
      => alert('Not removed')
    )

  saveUser : (user) ->
    @$log.log('Pushing edited user to backend ...')
    @dmUsersSvc.save(user,
      => alert('Success'),
      => alert('Failure')
    )

  newUser : ->
    @$log.log('New user')
    @$scope.formCaption = 'New user'
    @$scope.formTitle = 'Creating new user'
    @$scope.formSubmitCaption = 'Create'
    @$scope.selectedUser = {}
    
  selectUser : (user) ->
    @$log.log('Selecting user: ' + JSON.stringify(user))
    @$scope.formCaption = 'Existing user'
    @$scope.formTitle = 'Showing existing user'
    @$scope.formSubmitCaption = 'Save'
    @$scope.selectedUser = user

  fetchAll : ->
    @$scope.formCaption = ''
    @$scope.fetching = true
    @$scope.users = @dmUsersSvc.all( (res) =>
      @$log.log(res)
      @$scope.fetching = false
     , (response) =>
        @$scope.fetching = false
        @$log.log(JSON.stringify(response)) 
        alert('Error while fetching users!')
    )
