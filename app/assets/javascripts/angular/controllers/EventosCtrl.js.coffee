@app.controller 'EventosCtrl', ['$scope', '$location', '$modal', '$log', '$http', 'Evento', 'User',
	($scope, $location, $modal, $log, $http, Evento, User) ->
		$scope.eventos = []
		$scope.lista_eventos = []
		@modalInstance = null

		$scope.init = () ->
			Evento.index({}, ($data) ->
				if($data.meta == "ok")
					$scope.eventos = $data.eventos
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
				templateUrl: '../templates/otros/show.html',
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
				templateUrl: '../templates/events/new.html',
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

@app.controller 'ModalInstanceNewCtrl', ['$scope', '$modalInstance', '$log', '$q', '$http', 'Evento', 'User', 
($scope, $modalInstance, $log, $q, $http, Evento, User) ->
		User.index({}, ($data) ->
			$scope.users = $data.users
		)

		$scope.tags = []
		$scope.dt = new Date()

		$scope.hstep = 1
		$scope.mstep = 1

		$scope.ismeridian = false

		$scope.selection = []
		$scope.invitados = { invitado: [] }
		
		$scope.toggleMode = () ->
			$scope.ismeridian = !$scope.ismeridian

		$scope.crear = ($evento) ->
			$scope.evento = new Evento($evento)
			$scope.evento.invitados = $scope.invitados
			$scope.evento.hora = $scope.evento.hora.getHours()
			$scope.evento.dia = $scope.evento.fecha.getDate()
			$scope.evento.mes = $scope.evento.fecha.getMonth()+1
			# if not $scope.evento.hora
			# 	$scope.evento.hora = $scope.dt
			
			Evento.create($scope.evento, ($data) ->
				$log.info($data)
				$modalInstance.close($data.evento)
			)

		$scope.update = () ->
	    	d = new Date()
	    	d.setHours( 14 )
	    	d.setMinutes( 0 )
	    	$scope.mytime = d

		$scope.open_calendar = ($event) ->
			# $event.preventDefault()
			$event.stopPropagation()

			$scope.opened = true

		$scope.disabled = (date, mode) ->
			$scope.opened = false
			(mode == 'day' && ( date.getDay() == 0 || date.getDay() == 6 ))

		$scope.changed = () ->
			return true

		$scope.clear = () ->
	    	$scope.mytime = null

	    $scope.toggleSelection = (email) ->
	    	@idx = $scope.selection.indexOf(email)
	    	if @idx > -1
	    		$scope.selection.splice(@idx, 1)
	    	else
	    		$scope.selection.push(email)
]