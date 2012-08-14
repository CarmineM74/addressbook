class @ToyCtrl
  constructor: (@$scope) ->
    @$scope.greetings = () ->
      alert("I'm angularized!")

ToyCtrl.$inject(['$scope'])
