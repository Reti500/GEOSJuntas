@app.controller 'EventosCtrl', ['$scope', '$location', '$log', 'Evento', 
	($scope, $location, $log, Evento) ->
		$scope.lists = []
		$scope.data = [1,2,3,4,5,6,7,8,9,10]
		num_init = 0
		@saco = []
		for index in $scope.data
			$log.info(index)
			@saco.push(index)
			$log.error(@saco)
			if Math.floor(index / 3) > num_init
				$log.info("otro array")
				num_init += 1
				$scope.lists.push(@saco)
				@saco.splice(0, @saco.length)
			if index == $scope.data[$scope.data.length - 1]
				$scope.lists.push(@saco)
			
		$log.info($scope.lists)
	]