@app.controller 'ComentariosCtrl', ['$scope', '$log', 'Comentario', ($scope, $log, Comentario, Session) ->
	$scope.comentarios = null
	$scope.evento_id = null
	$scope.user = "ric"

	$scope.init = ($event_id) ->
		$scope.evento_id = $event_id

		Comentario.index({evento_id: $event_id}, ($data) ->
			$log.info($data)
			$scope.comentarios = $data.comentarios
		)

	$scope.crear = ($comment, $event_id) ->
		$comment.evento_id = $scope.evento_id
		$log.error($comment)
		$scope.comentario = new Comentario($comment)
		Comentario.create($scope.comentario, ($data) ->
			$log.info($data)
			$scope.comentarios.push($data.comentario)
		)
		$scope.form = angular.copy({})
]