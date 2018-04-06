app.controller 'StoriesEditCtrl', ($scope, $routeParams, $location, Story) ->
  if $routeParams.id
    $scope.story = Story.show(id: $routeParams.id)
  else
    $scope.story = new Story

  $scope.submit = ->
    console.log 'submit'
    success = (response) ->
      console.log 'success', response
      $location.path '/stories'

    failure = (response) ->
      console.log 'failure', response
      _.each response.data, (errors, key) ->
        _.each errors, (e) ->
          $scope.form[key].$dirty = true
          $scope.form[key].$setValidity e, false

    if $routeParams.id
      Story.update($scope.story, success, failure)
    else
      Story.create({story: $scope.story}, success, failure)
