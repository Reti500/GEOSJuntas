@app = angular.module('App', ["ngResource", "ngRoute", "ui.bootstrap"])

# @app.config(['$routeProvider', ($routeProvider) ->
# 	$routeProvider
# 		.when("/home", {templateUrl: "../templates/home/index.html", controller: 'HomeCtrl'})
# 		.when("/login", {templateUrl: "../templates/sessions/login.html", controller: 'SessionCtrl'})
# 		.when("/eventos", {templateUrl: "../templates/eventos/index.html", controller: 'EventosCtrl'})
# 		.when("/eventos/new", {templateUrl: "../templates/eventos/new.html", controller: 'EventosCtrl'})
# 		.when("/calendario", {templateUrl: "../templates/calendario/index.html", controller: 'CalendarioCtrl'})
# 		.when("/otros", {templateUrl: "../templates/otros/index.html", controller: 'EventosCtrl'})
# ])

@app.config(['$httpProvider', ($httpProvider) -> 
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

# // var app = angular.module('App', ['ngResource', 'ngRoute', 'ui.bootstrap']);

# // app.config(function($routeProvider){
# // 	$routeProvider
# // 		.when("/home", {templateUrl: "../templates/home/index.html", controller: 'HomeCtrl'})
# // 		.when("/login", {templateUrl: "../templates/sessions/login.html", controller: 'SessionCtrl'})
# // 		.when("/eventos", {templateUrl: "../templates/eventos/index.html", controller: 'EventosCtrl'})
# // 		.when("/eventos/new", {templateUrl: "../templates/eventos/new.html", controller: 'EventosCtrl'})
# // 		.when("/calendario", {templateUrl: "../templates/calendario/index.html", controller: 'CalendarioCtrl'})
# // });

# // app.config(function($httpProvider){
# // 	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
# // });

@app.filter('searchUser', [ () ->
    return (items, searchText) ->
        filtered = []
        searchText = String(searchText).toLowerCase()
        angular.forEach(items, (item) ->
            if (item.email.toLowerCase().indexOf(searchText) >= 0)
            	filtered.push(item)
        )
        return filtered
])