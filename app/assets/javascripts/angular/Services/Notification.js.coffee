@app.factory("Notification", ['$resource', ($resource) -> 
	return $resource('/api/notifications/:id', { },
		{
			'create':  { method: 'POST' },
			'index':   { method: 'GET', isArray: false},
			'show':    { method: 'GET', isArray: false },
			'update':  { method: 'PUT' },
			'destroy': { method: 'DELETE' }
		}
	)
])