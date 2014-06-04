@app.controller 'EventosCtrl', ['$scope', '$location', '$modal', '$log', 'Evento', 
	($scope, $location, $modal, $log, Evento) ->
		$scope.lista_eventos = []
		@modalInstance = null+
		@time = new Date()

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

		$scope.tiempoFaltante = ($day, $hour, $min) ->
			
			$scope.dia_f = @time.getDate() - $day

		$scope.create_list_eventos = ($array) ->
			num_init = 0
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

		$scope.dialog = ($item) ->
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

	]