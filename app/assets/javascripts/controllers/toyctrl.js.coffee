class @ToyCtrl
  constructor: (@$scope,@$resource) ->
    @$scope.greetings = () ->
      alert("I'm angularized!")

ToyCtrl.$inject(['$scope','ngResource'])
