app.controller 'StoriesIndexCtrl', ($scope, $location, Story) ->
  $scope.stories = Story.index()

  $scope.new = ->
    $location.path '/stories/new'
