@app.controller 'NotificationsCtrl', ['$scope', '$modal', '$log', ($scope, $modal, $log) ->
	$scope.notificaciones = []

	$scope.dialog_new = () ->
			$scope.event_show = null
			@modalInstance = $modal.open({
				templateUrl: '../templates/eventos/new.html',
				controller: 'ModalInstanceNewCtrl',
				size: "lg",
				resolve: {
				}
			})

			@modalInstance.result.then(
				($newItem) ->
					$scope.eventos.push($newItem)
					$scope.create_list_eventos($scope.eventos)
					# $scope.lista_eventos.push($newItem)
				() ->
					# $log.error($scope.evento)
					# $scope.lista_eventos.push($scope.evento)
			)
]