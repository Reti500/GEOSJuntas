@app.controller 'SessionCtrl', ['$scope', '$location', '$log', 'Session', ($scope, $location, $log, Session) ->
	$scope.alerts = []

	$scope.login = (params) ->
		$scope.session = new Session(params)
		Session.create($scope.session, ($data) ->
			if $data.state == "Logged"
				$location.path("/eventos")
			else
				$scope.addAlert("danger", "Error en los datos")
				$scope.session = angular.copy({})
		)

	$scope.logout = () ->
		Session.destroy({ id: "1" }, ($data) ->
			$log.info($data)
		)

	$scope.addAlert = (tipo, msj) ->
    	$scope.alerts.push({type: tipo, msg: msj})

	$scope.closeAlert = (index) ->
    	$scope.alerts.splice(index, 1)
]