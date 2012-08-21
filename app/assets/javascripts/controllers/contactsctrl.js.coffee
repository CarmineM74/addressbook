class @ContactsCtrl
  @inject : ['$scope','dmContactsSvc']
  constructor : (@$scope, @dmContactsSvc,@$log) ->
    @$scope.contacts = []
    @$scope.fetching = false
    @$scope.selectedContact = {}
    @$scope.formCaption = ''
    @$scope.formTitle = ''
    @$scope.formSubmitCaption = ''

    @$scope.newContact = angular.bind(this, @newContact)
    @$scope.fetchAll = angular.bind(this, @fetchAll)
    @$scope.selectContact = angular.bind(this, @selectContact)
    @$scope.saveContact = angular.bind(this, @saveContact)
    @$scope.deleteContact = angular.bind(this, @deleteContact)
    @$scope.exportToPDF = angular.bind(this, @exportToPDF)

  exportToPDF : ->
    @$log.log('Exporting contacts to PDF ...')
    @dmContactsSvc.toPdf()

  deleteContact : (contact) ->
    @$log.log('Removing contact from backend ...')
    @dmContactsSvc.destroy(contact,
      => alert('Removed'),
      => alert('Not removed')
    )

  saveContact : (contact) ->
    @$log.log('Pushing edited contact to backend ...')
    @dmContactsSvc.save(contact,
      => alert('Success'),
      => alert('Failure')
    )

  newContact : ->
    @$log.log('New contact')
    @$scope.formCaption = 'New contact'
    @$scope.formTitle = 'Creating new contact'
    @$scope.formSubmitCaption = 'Create'
    @$scope.selectedContact = {}
    
  selectContact : (contact) ->
    @$log.log('Selecting contact: ' + JSON.stringify(contact))
    @$scope.formCaption = 'Existing contact'
    @$scope.formTitle = 'Showing existing contact'
    @$scope.formSubmitCaption = 'Save'
    @$scope.selectedContact = contact

  fetchAll : ->
    @$scope.formCaption = ''
    @$scope.fetching = true
    @$scope.contacts = @dmContactsSvc.all( (res) =>
      @$log.log(res)
      @$scope.fetching = false
     , =>
        @$scope.fetching = false
        alert('Error while fetching contacts!')
    )
