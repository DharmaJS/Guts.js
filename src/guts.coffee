Guts = {
	types: {
		element: 1
		array: 2
		arrayofarrays: 3
		object: 4
		json: 5
		string: 6
		selector: 7
	}

	isElement: (obj) ->
		try
			#Using W3 DOM2 (works for FF, Opera and Chrom)
			return obj instanceof HTMLElement
		catch e
			#Browsers not supporting W3 DOM2 don't have HTMLElement and
			#an exception is thrown and we end up here. Testing some
			#properties that all elements have. (works on IE7)
			return typeof obj == 'object' and obj.nodeType == 1 and typeof obj.style == 'object' and typeof obj.ownerDocument == 'object'
		return

	isArray: (a) ->
		return (!!a) && (a.constructor == Array)
	
	isArrayOfArrays: (a) ->
		return (!!a) && (a.constructor == Array) && this.isArray(a[0])

	isObject: (a) ->
		return typeof(a) == 'object' && !this.isArray(a)
	
	isJSON: (a) ->
		return this.isObject(a) || (this.isArray(a) && !this.isArrayOfArrays(a))
	
	isString: (a) ->
		return typeof(a) == 'string'
	
	isFunction: (functionToCheck) ->
		getType = {}
		return functionToCheck and getType.toString.call(functionToCheck) == '[object Function]'
	
	getDataType: (a) ->
		# array, object, element or selector
		if this.isString(a)
			return Guts.types.selector
		else if this.isArrayOfArrays(a)
			return Guts.types.arrayofarrays
		else if this.isJSON(a)
			return Guts.types.json
		else
			return null
}
Window.Guts = Guts
