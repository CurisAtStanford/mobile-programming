# $ ->
# 	###
# 	Must divide logic among blocks
# 	Divide so I can get location with anything

# 	Notes: my location will always go first, no matter what
# 	###

# 	###
# 	triggers is a JS object broken up like the following:
# 	first: the first condition given
# 	operator: the type of operator
# 	second: second condition given

# 	actions is an array of the action indicators
# 	###

# 	IS_IN = 6
# 	IS_NOT_IN = 7

# 	MY_AREA = 0
# 	MY_LOCATION = 1
# 	WEATHER = 2
# 	###
# 	operators: and operator ID
# 	is in: 
# 	is not in:

# 	###
# 	#Any potential globals that need to be passed
# 	polygonArea = null
# 	myLat = null
# 	myLng = null

# 	#This has all the weather information
# 	###
# 	weatherInfo = 
# 		"0": "tornado"
# 		"1": "tropical storm"
# 		"2": "hurricane"
# 		"3": "severe thunderstorms"
# 		"4": "thunderstorms"
# 		"5": mixed rain and snow
# 		6: mixed rain and sleet
# 		7: mixed snow and sleet
# 		8: freezing drizzle
# 		9: drizzle
# 		10: freezing rain
# 		11: showers
# 		12: showers
# 		13: snow flurries
# 		14: light snow showers
# 		15: blowing snow
# 		16: snow
# 		17: hail
# 		18: sleet
# 		19: dust
# 		20: foggy
# 		21: haze
# 		22: smoky
# 		23: blustery
# 		24: windy
# 		25: cold
# 		26: cloudy
# 		27: mostly cloudy (night)
# 		28: mostly cloudy (day)
# 		29: partly cloudy (night)
# 		30: partly cloudy (day)
# 		31: clear (night)
# 		32: sunny
# 		33: fair (night)
# 		34: fair (day)
# 		35: mixed rain and hail
# 		36: hot
# 		37: isolated thunderstorms
# 		38: scattered thunderstorms
# 		39: scattered thunderstorms
# 		40: scattered showers
# 		41: heavy snow
# 		42: scattered snow showers
# 		43: heavy snow
# 		44: partly cloudy
# 		45: thundershowers
# 		46: snow showers
# 		47: isolated thundershowers
# 		3200: "not available"
# 	###

# 	# This will run with given parameters
# 	run = (triggers, actions) ->
# 		console.log triggers
# 		firstBlock = triggers.firstBlock
# 		operator = triggers.operator
# 		secondBlock = triggers.secondBlock
# 		action = actions

# 		if (firstBlock is MY_LOCATION and secondBlock is MY_AREA) or (firstBlock is MY_AREA and secondBlock is MY_LOCATION)
# 			#return check_if_contains() if operator is IS_IN
# 			#return not check_if_contains()
# 			# "GOT HERE SO IT SHOULD WORK"

# 			bounds = map.getBounds()
# 			rectangle = get_rectangle_coords bounds
# 			polygonArea = new google.maps.Polygon
# 					paths: rectangle
# 					strokeColor: '#FF0000'
# 					strokeOpacity: 0.8
# 					strokeWeight: 3
# 					fillColor: '#FF0000'
# 					fillOpacity: 0.35
# 			polygonArea.setMap map


# 			check_if_contains action

# 			# interval = doAndRepeat 7000, ->
# 			interval = setInterval ->
# 				check_if_contains action
# 			,7000

# 		else if firstBlock is secondBlock
# 			#return true if operator is IS_IN
# 			#return false
# 			action()
# 		else if (firstBlock is MY_LOCATION and secondBlock is WEATHER) or
# 		(firstBlock is WEATHER and secondBlock is MY_LOCATION)
# 			#CALL ON WEATHER WITH MY LOCATION
# 			promise = myLocation()
# 			promise.done ->
# 				load_weather "#{myLat},#{myLng}",action
# 		else if (firstBlock is MY_TIME and secondBlock is CLOCK) or 
# 		(firstBlock is CLOCK and secondBlock is MY_TIME)
# 			if block_clock.run()
# 				action()
# 				return
# 			interval = setInterval ->
# 				if block_clock.run()
# 					action()
# 					clearInterval(interval)
# 			, 7000
# 		else if (firstBlock is MY_IMAGE and secondBlock is MY_TEXT) or
# 			(firstBlock is MY_TEXT and secondBlock is MY_IMAGE)
# 				get_tags(image_url, checkIfEqual, action)
# 		else console.log "An error ocurred unfortunately"

# 	image_url = null
# 	top_tags = []
# 	matched = false
# 	NMAX_TAGS = 5
# 	get_tags = (img_url, callback, action) =>
# 		console.log "got here hehe"
# 		$.ajax
# 			url: "https://api.clarifai.com/v1/tag/?url=" + encodeURI(img_url)
# 			headers:
# 				Authorization: "Bearer 1uFnHTSieI3VcXsQR23Vtkivo8vYEq"
# 			error: (x, textStatus, z)->
# 				alert "error"
# 			success: (json,textStatus, z)=>
# 				top_tags = json.results[0].result.tag.classes[0...NMAX_TAGS]
# 				top_probs = json.results[0].result.tag.probs[0...NMAX_TAGS]
# 				callback action

# 	$("#image_input")[0].oninput = =>
# 		image_url = $("#image_input").val()
# 		$("#drag10").css
# 			backgroundImage: "url(#{image_url})"
# 			backgroundSize: 'cover'

# 		$("#image_input").remove()
# 		$("#image_pic").remove()

# 	checkIfEqual = (action)->
# 		text = $("#text_input").val()
# 		console.log text
# 		if text in top_tags
# 			action()

# 	myLocation = ->
# 		defObject = $.Deferred()
# 		navigator.geolocation.getCurrentPosition (position) ->
# 			myLat = position.coords.latitude
# 			myLng = position.coords.longitude
# 			# "Latitude: #{position.coords.latitude}"
# 			# "Longitude: #{position.coords.longitude}"
# 			defObject.resolve()
# 			return
# 		defObject.promise()

# 	get_rectangle_coords = (bounds) ->
# 		northEast = bounds.getNorthEast()
# 		southWest = bounds.getSouthWest()
# 		southWestLat = southWest.lat()
# 		southWestLng = southWest.lng()
# 		northEastLat = northEast.lat()
# 		northEastLng = northEast.lng()
# 		southEastLat = northEast.lat()
# 		southEastLng = southWest.lng()
# 		northWestLng = northEast.lng()
# 		northWestLat = southWest.lat()
# 		[
# 			new google.maps.LatLng(southWestLat, southWestLng)
# 			new google.maps.LatLng(northWestLat, northWestLng)
# 			new google.maps.LatLng(northEastLat, northEastLng)
# 			new google.maps.LatLng(southEastLat, southEastLng)
# 		]

# 	audio = null
# 	map = null
# 	#TODO only put one marker at a time
# 	google.maps.event.addDomListener window,'load',->
# 		promise = myLocation()
# 		promise.done ->

# 			mapProp =
# 				center: new google.maps.LatLng(myLat,myLng)
# 				zoom: 17
# 				mapTypeId: google.maps.MapTypeId.ROADMAP
# 				disableDefaultUI: true
# 				minZoom: 17
# 				maxZoom: 17

# 			map = new google.maps.Map document.getElementById("google_map"),mapProp

			
# 			###
# 			google.maps.event.addListener map,'click',(event)->
# 				obj = 
# 					position: event.latLng
# 					map: map
# 				marker = new google.maps.Marker obj
# 				# map.getBounds().getSouthWest().lat()
# 				# event.latLng.lat()
# 				bounds = map.getBounds()
# 				rectangle = get_rectangle_coords bounds
# 				polygonArea = new google.maps.Polygon
# 					paths: rectangle
# 					strokeColor: '#FF0000'
# 					strokeOpacity: 0.8
# 					strokeWeight: 3
# 					fillColor: '#FF0000'
# 					fillOpacity: 0.35
# 				polygonArea.setMap map
# 			###
# 	count = 0

# 	check_if_contains = (callback) ->
# 		# callback
# 		count++
# 		myLoc = myLocation()
# 		myLoc.done -> 
# 			myLatLng = new google.maps.LatLng(myLat, myLng)

# 			if google.maps.geometry.poly.containsLocation(myLatLng, polygonArea)
# 				$("#message").text "You re in #{count}!"
# 				callback()
# 				return true
# 			else
# 				$("#message").text "You are not in #{count}"
# 				return false

# 	rain_codes = [3, 4, 5, 6, 8, 9, 10, 11, 12, 35, 37, 38, 39, 40, 45, 47]
# 	cloudy_codes = [26, 27, 28, 29, 30, 44]
# 	sunny_codes = [32, 34, 36]
# 	#Loads the weather
# 	load_weather = (location, callback)->
# 		#curClass = ($(".wi").attr("class").toString().split(' '))[1]
# 		#curClass = $("#info").attr('class').toString()
# 		#console.log curClass
# 		$active_weather = $(".real-active-slide")
# 		# if child.hasClass("sunny-icon")
# 		# 	console.log "YAAAAY"
# 		# else if child.hasClass("rainy-icon")
# 		# 	console.log "rain"
# 		# else if child.hasClass("cloudy-icon")
# 		# 	console.log "cloud"
# 		$.simpleWeather
# 			location: location 
# 			unit: 'f'
# 			success: (weather) ->
# 				code = parseInt weather.todayCode
# 				console.log "WEATHER CODE"
# 				console.log code
# 				if $active_weather.hasClass "rainy-icon" 
# 					callback() if $.inArray(code, rain_codes) isnt -1
# 				else if $active_weather.hasClass "cloudy-icon"
# 					callback() if $.inArray(code, cloudy_codes) isnt -1
# 				else if $active_weather.hasClass "sunny-icon"
# 					callback() if $.inArray(code, sunny_codes) isnt -1
# 				else # "DIDN'T MATCH"
# 					return
# 			error: (error) ->
# 				$("#message").text "Error"
# 				# "ERROR on WEATHER"
# 				return

# 	make_audio_sound = ->
# 		audio.play()

# 	# play_youtube = ->
# 	# 	video_name = $("#youtube_input").val()[32...]
# 	# 	$("#drag9").html "<iframe id='youtube_video' width='100%' height='100%'
# 	# 			src='https://www.youtube.com/embed/" + video_name + "?modestbranding=1&showinfo=0&iv_load_policy=3&controls=0&autoplay=0"+
# 	# 			" frameborder='0' allowfullscreen=1></iframe>"

# 	MAP = 3
# 	BUZZ = 4
# 	SIREN = 10
# 	CLOCK = 8
# 	MY_TIME = 9
# 	MY_IMAGE = 100
# 	MY_TEXT = 150
# 	YOUTUBE = 120
# 	# This shows what the corresponding id's are for the blocks
# 	blockIDs =
# 		drag1: MY_LOCATION #ME
# 		drag2: WEATHER #not used
# 		drag3: IS_IN #==
# 		drag4: BUZZ #action
# 		drag5: MY_AREA #map block
# 		drag6: SIREN
# 		drag7: CLOCK
# 		drag8: MY_TIME
# 		drag9: YOUTUBE
# 		drag10: MY_IMAGE
# 		drag11: MY_TEXT
# 	#This is when the user runs
	
# 	$("#reset").click ->
# 		location.reload()

# 	$("#run").click ->
# 		triggers = {}
# 		actions = null

# 		elementsInEnvironment = document.querySelectorAll(".drop_over.draggable");
# 		# elementsInEnvironment.length
# 		firstBlockAccountedFor = false
# 		for element in elementsInEnvironment
# 			console.log element
# 			curID = element.id
# 			# curID

# 			#IS_IN or == 
# 			if curID is "drag3"
# 				triggers.operator = blockIDs[curID]
# 				# triggers.operator
# 			else if curID is "drag4"
# 				actions = make_audio_sound
# 				audio = new Audio "sound/Ding.mp3"
# 				audio.play()
# 				audio.pause()
# 			else if curID is "drag6"
# 				actions = make_audio_sound
# 				audio = new Audio "sound/Siren.mp3"
# 				audio.play()
# 				audio.pause()
# 			else if curID is "drag12"
# 				actions = take_picture
# 			# else if curID = "drag9"
# 			# 	actions = play_youtube
# 			else
# 				#console.log "ID: BELOW"
# 				#console.log curID
# 				if firstBlockAccountedFor is not true
# 					firstBlockAccountedFor = true
# 					triggers.firstBlock = blockIDs[curID]
# 				else 
# 					triggers.secondBlock = blockIDs[curID]

# 		result = run triggers, actions

# 	##########################################
# 	########## CAMERA FUNCTIONALITY ##########
# 	##########################################
# 	width = 290
# 	height = 0
# 	streaming = false

# 	startup = ->
# 		video = document.getElementById('video')
# 		canvas = document.getElementById('canvas')
# 		photo = document.getElementById('photo')
# 		# run = document.getElementById('run')

# 		navigator.getMedia = navigator.getUserMedia or navigator.webkitGetUserMedia

# 		navigator.getMedia {
# 			video: true
# 			audio: false
# 		},((stream) ->
# 			video = document.querySelector('video')
# 			video.src = window.URL.createObjectURL(stream)
# 			video.onloadedmetadata = (e) ->
# 				# do something with the video here
# 				video.play()
# 				return
# 			return
# 		),(error) ->
# 			console.log 'Camera blocked - the following error occurred: ' + error
# 			return

# 		video.addEventListener 'canplay', ((event) ->
# 			if !streaming
# 				height = video.videoHeight / (video.videoWidth / width) # compute height based on width & stream
# 				video.setAttribute 'width', width
# 				video.setAttribute 'height', height
# 				canvas.setAttribute 'width', width
# 				canvas.setAttribute 'height', height
# 				streaming = true
# 			return
# 		), false

# 	# Draw video into a canvas, then converting it to a PNG format data URL.
# 	take_picture = ->
# 		context = canvas.getContext('2d')
# 		if width and height
# 			canvas.width = width
# 			canvas.height = height
# 			context.drawImage video, 0, 0, width, height
# 			data = canvas.toDataURL('image/png')
# 			photo.setAttribute 'src', data
# 		return

# 	# Set up our event listener to run the startup process once loading is complete.
# 	window.addEventListener 'load', startup, false

