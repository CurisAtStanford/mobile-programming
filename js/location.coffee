$ ->
	###
	Must divide logic among blocks
	Divide so I can get location with anything

	Notes: my location will always go first, no matter what
	###

	###
	triggers is a JS object broken up like the following:
	first: the first condition given
	operator: the type of operator
	second: second condition given

	actions is an array of the action indicators
	###

	IS_IN = 6
	IS_NOT_IN = 7

	MY_AREA = 0
	MY_LOCATION = 1
	WEATHER = 2
	###
	operators: and operator ID
	is in: 
	is not in:

	###
	#Any potential globals that need to be passed
	polygonArea = null
	myLat = null
	myLng = null

	#This has all the weather information
	###
	weatherInfo = 
		"0": "tornado"
		"1": "tropical storm"
		"2": "hurricane"
		"3": "severe thunderstorms"
		"4": "thunderstorms"
		"5": mixed rain and snow
		6: mixed rain and sleet
		7: mixed snow and sleet
		8: freezing drizzle
		9: drizzle
		10: freezing rain
		11: showers
		12: showers
		13: snow flurries
		14: light snow showers
		15: blowing snow
		16: snow
		17: hail
		18: sleet
		19: dust
		20: foggy
		21: haze
		22: smoky
		23: blustery
		24: windy
		25: cold
		26: cloudy
		27: mostly cloudy (night)
		28: mostly cloudy (day)
		29: partly cloudy (night)
		30: partly cloudy (day)
		31: clear (night)
		32: sunny
		33: fair (night)
		34: fair (day)
		35: mixed rain and hail
		36: hot
		37: isolated thunderstorms
		38: scattered thunderstorms
		39: scattered thunderstorms
		40: scattered showers
		41: heavy snow
		42: scattered snow showers
		43: heavy snow
		44: partly cloudy
		45: thundershowers
		46: snow showers
		47: isolated thundershowers
		3200: "not available"
	###

	# This will run with given parameters
	run = (triggers, actions) ->
		console.log triggers
		firstBlock = triggers.firstBlock
		operator = triggers.operator
		secondBlock = triggers.secondBlock
		action = actions

		if (firstBlock is MY_LOCATION and secondBlock is MY_AREA) or (firstBlock is MY_AREA and secondBlock is MY_LOCATION)
			#return check_if_contains() if operator is IS_IN
			#return not check_if_contains()
			# "GOT HERE SO IT SHOULD WORK"

			bounds = map.getBounds()
			rectangle = get_rectangle_coords bounds
			polygonArea = new google.maps.Polygon
					paths: rectangle
					strokeColor: '#FF0000'
					strokeOpacity: 0.8
					strokeWeight: 3
					fillColor: '#FF0000'
					fillOpacity: 0.35
			polygonArea.setMap map


			check_if_contains action

			# interval = doAndRepeat 7000, ->
			interval = setInterval ->
				check_if_contains action
			,7000

		else if firstBlock is secondBlock
			#return true if operator is IS_IN
			#return false
			action()
		else if (firstBlock is MY_LOCATION and secondBlock is WEATHER) or
		(firstBlock is WEATHER and secondBlock is MY_LOCATION)
			#CALL ON WEATHER WITH MY LOCATION
			promise = myLocation()
			promise.done ->
				load_weather "#{myLat},#{myLng}",action
		else if (firstBlock is MY_TIME and secondBlock is CLOCK) or 
		(firstBlock is CLOCK and secondBlock is MY_TIME)
			if checkMatchingTime()
				action()
				return
			interval = setInterval ->
				if checkMatchingTime()
					action()
					clearInterval(interval)
			, 7000
		else console.log "An error ocurred unfortunately"

	checkMatchingTime = ->
		currentTime = new Date()
		return timeMatches(currentTime.getHours(), currentTime.getMinutes())

	timeMatches = (hours, minutes) ->
		console.log "GOT IN HERE!!!!!!!!!"
		clock_hour = $("#hours").text()
		clock_minutes = $("#minutes").text()
		clock_time = $("#time").text()
		console.log clock_hour
		if clock_time is "PM"
			clock_hour = parseInt(clock_hour) + 12

		console.log clock_hour
		console.log(typeof parseInt(clock_minutes))
		hours_match = parseInt(hours) is parseInt(clock_hour)
		minutes_match = parseInt(minutes) is parseInt(clock_minutes)
		console.log hours_match
		console.log minutes_match
		return hours_match && minutes_match

	myLocation = ->
		defObject = $.Deferred()
		navigator.geolocation.getCurrentPosition (position) ->
			myLat = position.coords.latitude
			myLng = position.coords.longitude
			# "Latitude: #{position.coords.latitude}"
			# "Longitude: #{position.coords.longitude}"
			defObject.resolve()
			return
		defObject.promise()


	get_rectangle_coords = (bounds) ->
		northEast = bounds.getNorthEast()
		southWest = bounds.getSouthWest()
		southWestLat = southWest.lat()
		southWestLng = southWest.lng()
		northEastLat = northEast.lat()
		northEastLng = northEast.lng()
		southEastLat = northEast.lat()
		southEastLng = southWest.lng()
		northWestLng = northEast.lng()
		northWestLat = southWest.lat()
		[
			new google.maps.LatLng(southWestLat, southWestLng)
			new google.maps.LatLng(northWestLat, northWestLng)
			new google.maps.LatLng(northEastLat, northEastLng)
			new google.maps.LatLng(southEastLat, southEastLng)
		]

	audio = null
	map = null
	#TODO only put one marker at a time
	google.maps.event.addDomListener window,'load',->
		promise = myLocation()
		promise.done ->

			mapProp =
				center: new google.maps.LatLng(myLat,myLng)
				zoom: 17
				mapTypeId: google.maps.MapTypeId.ROADMAP
				disableDefaultUI: true
				minZoom: 17
				maxZoom: 17

			map = new google.maps.Map document.getElementById("google_map"),mapProp

			
			###
			google.maps.event.addListener map,'click',(event)->
				obj = 
					position: event.latLng
					map: map
				marker = new google.maps.Marker obj
				# map.getBounds().getSouthWest().lat()
				# event.latLng.lat()
				bounds = map.getBounds()
				rectangle = get_rectangle_coords bounds
				polygonArea = new google.maps.Polygon
					paths: rectangle
					strokeColor: '#FF0000'
					strokeOpacity: 0.8
					strokeWeight: 3
					fillColor: '#FF0000'
					fillOpacity: 0.35
				polygonArea.setMap map
			###
	count = 0

	check_if_contains = (callback) ->
		# callback
		count++
		myLoc = myLocation()
		myLoc.done -> 
			myLatLng = new google.maps.LatLng(myLat, myLng)

			if google.maps.geometry.poly.containsLocation(myLatLng, polygonArea)
				$("#message").text "You re in #{count}!"
				callback()
				return true
			else
				$("#message").text "You are not in #{count}"
				return false

	rain_codes = [3, 4, 5, 6, 8, 9, 10, 11, 12, 35, 37, 38, 39, 40, 45, 47]
	cloudy_codes = [26, 27, 28, 29, 30, 44]
	sunny_codes = [32, 34, 36]
	#Loads the weather
	load_weather = (location, callback)->
		#curClass = ($(".wi").attr("class").toString().split(' '))[1]
		curClass = $("#info").attr('class').toString()
		console.log curClass
		$.simpleWeather
			location: location 
			unit: 'f'
			success: (weather) ->
				code = parseInt weather.todayCode
				console.log code
				if curClass is "wi-umbrella"
					# "Got in umbrella"
					callback() if $.inArray(code, rain_codes) isnt -1
				else if curClass is "wi-cloudy"
					callback() if $.inArray(code, cloudy_codes) isnt -1
				else if curClass is "wi-day-sunny"
					callback() if $.inArray(code, sunny_codes) isnt -1
				else # "DIDN'T MATCH"
					return
			error: (error) ->
				$("#message").text "Error"
				# "ERROR on WEATHER"
				return

	make_audio_sound = ->
		audio.play()

	MAP = 3
	BUZZ = 4
	SIREN = 10
	CLOCK = 8
	MY_TIME = 9
	# This shows what the corresponding id's are for the blocks
	blockIDs =
		drag1: MY_LOCATION #ME
		drag2: WEATHER #not used
		drag3: IS_IN #==
		drag4: BUZZ #action
		drag5: MY_AREA #map block
		drag6: SIREN
		drag7: CLOCK
		drag8: MY_TIME
	#This is when the user runs
	
	$("#reset").click ->
		location.reload()

	$("#run").click ->
		triggers = {}
		actions = null

		elementsInEnvironment = document.querySelectorAll(".drop_over.draggable");
		# elementsInEnvironment.length
		firstBlockAccountedFor = false
		for element in elementsInEnvironment
			console.log element
			curID = element.id
			# curID

			#IS_IN or == 
			if curID is "drag3"
				triggers.operator = blockIDs[curID]
				# triggers.operator
			else if curID is "drag4"
				actions = make_audio_sound
				audio = new Audio "sound/Ding.mp3"
				audio.play()
				audio.pause()
			else if curID is "drag6"
				actions = make_audio_sound
				audio = new Audio "sound/Siren.mp3"
				audio.play()
				audio.pause()
			else
				#console.log "ID: BELOW"
				#console.log curID
				if firstBlockAccountedFor is not true
					firstBlockAccountedFor = true
					triggers.firstBlock = blockIDs[curID]
				else 
					triggers.secondBlock = blockIDs[curID]

		result = run triggers, actions
