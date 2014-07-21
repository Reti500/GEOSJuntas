@app.factory("Evento", ['$resource', ($resource) -> 
	return $resource('/api/eventos/:id', { },
		{
			'create':  { method: 'POST' },
			'index':   { method: 'GET', isArray: false},
			'show':    { method: 'GET', isArray: false },
			'update':  { method: 'PUT' },
			'destroy': { method: 'DELETE' }
		}
	)
])