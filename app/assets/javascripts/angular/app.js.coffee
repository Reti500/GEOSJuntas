@app = angular.module('App', ["ngResource", "ngRoute", "ui.bootstrap", "ngTagsInput"])

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

# @app.directive('tag', ($http) ->
# 	return {
# 		restrict: 'E',
# 		templateUrl: 'tag.html',
# 		link: (scope, el) ->
# 			scope.tags = [
# 				{ text: 'Tag1' },
# 				{ text: 'Tag2' },
# 				{ text: 'Tag3' }
# 			]

# 			test = [{ "text": "Tag9" },{ "text": "Tag10" }]
# 			scope.loadTags = test;
# 		}
# )

@app.directive('tag', ($http, $q, User) ->
	return {
		restrict: 'E',
		templateUrl: '../templates/tag.html',
		link: (scope, el) ->
			scope.tags = []
        
			scope.loadTags = (query) ->
        		# test = [{ text: 'Tag9' },{ text: 'Tag10' }]
        		# test = $http.get('/users?search=' + query)
        		# test = []
        		# console.log(query)
        		# User.index({search:query}, ($data) ->
        		# 	console.log($data)
        		# 	test = $data.users
        		# 	console.log(test)
        		# )
        		# test = $http.get('/users?search=' + query)
        		# 	.success(($data)->
        		# 		console.log($data.users)
        		# 		return $data.users
        		# 	)
        		# console.log(test)
        		# return test.$promise
				
				@deferred = $q.defer()
				
				User.get({search:query}, (data) ->
					@deferred.resolve([
						{ text: 'Tag9' },
						{ text: 'Tag10' }
					])
				)
				
				@deferred.promise
		}
)


# @app.config((tagsInputConfigProvider) ->
# 	tagsInputConfigProvider
# 		.setDefaults('tagsInput', {
# 			placeholder: 'New tag',
# 			addOnEnter: false
# 		})
# 		.setDefaults('autoComplete', {
# 			maxResultsToShow: 20,
# 			debounceDelay: 1000
# 		})
# 		.setActiveInterpolation('tagsInput', {
# 			placeholder: true,
# 			addOnEnter: true,
# 			removeTagSymbol: true
# 		})
# )