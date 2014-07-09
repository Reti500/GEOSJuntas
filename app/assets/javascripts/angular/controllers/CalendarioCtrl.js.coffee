@app.controller 'CalendarioCtrl', ['$scope', '$log', 'Evento', ($scope, $log, Evento) ->
    $scope.init = () ->
        Evento.index({dia:$scope.dt.getDate(), mes:$scope.dt.getMonth()}, ($data) ->
            $scope.eventos = $data.eventos
        )

    $scope.today = () ->
        $scope.dt = new Date()

    $scope.today()

    $scope.clear = () ->
        $scope.dt = null

    $scope.disabled = (date, mode) ->
        return ( mode == 'day' && ( date.getDay() == 0 || date.getDay() == 6 ) )

    $scope.toggleMin = () ->
        $scope.minDate = $scope.minDate ? null : new Date()
  
    $scope.toggleMin()

    $scope.open = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()

        $scope.opened = true

    $scope.selectDay = () ->
        $log.info("calculate date")
        Evento.index({dia:$scope.dt.getDate(), mes:$scope.dt.getMonth()}, ($data) ->
            $scope.eventos = $data.eventos
        )

    $scope.dateOptions = {
        formatYear: 'yy',
        startingDay: 1
    }

    $scope.initDate = new Date()
    $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate']
    $scope.format = $scope.formats[0]
]