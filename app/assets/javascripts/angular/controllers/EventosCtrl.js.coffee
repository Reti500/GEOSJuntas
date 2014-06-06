@app.controller 'EventosCtrl', ['$scope', '$location', '$modal', '$log', 'Evento', 
	($scope, $location, $modal, $log, Evento) ->
		$scope.eventos = []
		$scope.lista_eventos = []
		@modalInstance = null

		$scope.init = () ->
			Evento.index({}, ($data) ->
				if($data.meta == "ok")
					$scope.eventos = $data.eventos
				else if($data.state == "user-error")
					$location.path("/login")
				else
					$scope.eventos = []
				$scope.create_list_eventos($scope.eventos)
			)

		$scope.editar = () ->
			

		$scope.create_list_eventos = ($array) ->
			num_init = 0
			$scope.lista_eventos = []
			list = []
			for item in $array
				list.push(item)
				if Math.floor(item / 3) > num_init
					num_init += 1
					$scope.lista_eventos.push(list)
					list = []
				else if item == $array[$array.length - 1]
					$scope.lista_eventos.push(list)

		$scope.open = ($event) ->
			$event.preventDefault()
			$event.stopPropagation()

			$scope.opened = true

		$scope.dialog_show = ($item) ->
			$scope.event_show = null
			$scope.id = $item.id
			@modalInstance = $modal.open({
				templateUrl: '../templates/eventos/show.html',
				controller: 'ModalInstanceCtrl',
				size: "lg",
				resolve: {
					evento: () ->
						$item
				}
			})

			@modalInstance.result.then(
				($selectedItem) ->
					$log.info("wey")
				() ->
					$log.info("marica")
			)

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
					$log.info("wey")
					$scope.eventos.push($newItem)
					$scope.create_list_eventos($scope.eventos)
					# $scope.lista_eventos.push($newItem)
				() ->
					# $log.error($scope.evento)
					# $scope.lista_eventos.push($scope.evento)
			)
	]

@app.controller 'ModalInstanceNewCtrl', ['$scope', '$modalInstance', '$log', 'Evento', ($scope, $modalInstance, $log, Evento) ->
	
	$scope.dt = new Date()

	$scope.crear = ($evento) ->
		$scope.evento = new Evento($evento)
		Evento.create($scope.evento, ($data) ->
			$log.info($data)
			$modalInstance.close($data.evento)
		)

	$scope.open_calendar = ($event) ->
		# $event.preventDefault()
		$event.stopPropagation()

		$scope.opened = true

	$scope.disabled = (date, mode) ->
		$scope.opened = false
		(mode == 'day' && ( date.getDay() == 0 || date.getDay() == 6 ))
]