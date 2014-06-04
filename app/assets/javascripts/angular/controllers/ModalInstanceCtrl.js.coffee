@app.controller 'ModalInstanceCtrl', ['$scope', '$modalInstance', '$timeout', '$log', 'evento', 
	($scope, $modal_instance, $timeout, $log, evento) ->
		$scope.evento = evento

		@timeout = null

		$scope.cont = 0
		$scope.onTimeout = () ->
			$scope.cont++
			$log.info($scope.cont)
			# @mytimeout = $timeout($scope.onTimeout, 1000)

		@mytimeout = $timeout($scope.onTimeout, 1000)
	]