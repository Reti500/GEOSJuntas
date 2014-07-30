@app.controller 'NotificationsCtrl', ['$scope', '$modal', '$log', 'Notification', ($scope, $modal, $log, Notification) ->
	$scope.notificaciones = []
	$scope.num_notify = 0

	$scope.init = () ->
		Notification.index({}, ($data) ->
			$scope.notificaciones = $data.notifications
			for n in $scope.notificaciones
				if n.status != "visto"
					$scope.num_notify += 1
			
		)

	$scope.dialog_new = () ->
		$scope.event_show = null
		@modalInstance = $modal.open({
			templateUrl: '../templates/events/new.html',
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