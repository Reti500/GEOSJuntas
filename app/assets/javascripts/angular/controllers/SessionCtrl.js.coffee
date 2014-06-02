@app.controller 'SessionCtrl', ['$scope', '$log', 'Session', ($scope, $log, Session) ->
	$scope.login = (params) ->
		$scope.session = new Session(params)
		Session.create($scope.session, ($data) ->
			$log.info($data)
		)

	$scope.logout = () ->
		Session.destroy({ id: "1" }, ($data) ->
			$log.info($data)
		)
]