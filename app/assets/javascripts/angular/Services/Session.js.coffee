@app.factory("Session", ['$resource', ($resource) -> 
	return $resource('./api/sessions/:id', { },
		{
			'create':  { method: 'POST' },
			'destroy': { method: 'DELETE' },
			'index':   { method: 'GET' }
		}
	)
])