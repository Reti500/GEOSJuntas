@app = angular.module('App', ["ngResource", "ngRoute", "ui.bootstrap"])

@app.config(['$routeProvider', ($routeProvider) ->
	$routeProvider
		.when("/home", {templateUrl: "../templates/home/index.html", controller: 'HomeCtrl'})
		.when("/login", {templateUrl: "../templates/sessions/login.html", controller: 'SessionCtrl'})
		.when("/eventos", {templateUrl: "../templates/eventos/index.html", controller: 'EventosCtrl'})
		.when("/eventos/new", {templateUrl: "../templates/eventos/new.html", controller: 'EventosCtrl'})
		.when("/calendario", {templateUrl: "../templates/calendario/index.html", controller: 'CalendarioCtrl'})
])

@app.config(['$httpProvider', ($httpProvider) -> 
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])