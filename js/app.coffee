$ ->
	window.global_block_width = window.global_block_height = 290

	# blocks
	# block_ding = new block_ding_()
	# block_siren = new block_siren_()
	# block_camera = new block_camera_()
	# block_time = new block_time_()
	# block_image_recognition = new block_image_recognition_()
	# block_map = new block_map_()
	# block_my_time = new block_my_time_()
	# block_my_location = new block_my_location_()
	# block_my_weather = new block_my_weather_()
	# block_text = new block_text_()
	# block_weather = new block_weather_()
	# block_array_test = new block_array_test_()
	# block_if_then = new draggable_control_if_then_()
	# block_youtube = new block_youtube_()

	block_instagram = new block_instagram_()
	# operators
	#operator_equals = new operator_equals_()

	# control statements
	control_if_then = new control_for_loop()
	#control_if_then = new control_if_then_()

	###
	triggers is a JS object broken up like the following:
	first: the first condition given
	operator: the type of operator
	second: second condition given
	action: thing to do next
	###

	IS_IN = 6
	IS_NOT_IN = 7

	MY_AREA = 0
	MY_LOCATION = 1
	WEATHER = 2

	# This will run with given parameters
	run = (triggers, action) =>
		console.log "Got in run"
		if for_loop is false
			if_condition triggers, action
		else #not a for loop, thus is an if then statement
			array = triggers.array
			if array is MY_ARRAY
				console.log "BOOOYAAAH"
				list = block_array_test.run()
				for element in list
					console.log "HERE"
					console.log element
					if_condition triggers,action

	if_condition = (triggers, action) ->
		console.log "TRIGGERS"
		console.log triggers.first_block
		console.log triggers.second_block
		console.log triggers.operator
		action() if (triggers.first_block is undefined) or (triggers.first_block is null)
		first_block = triggers.first_block
		operator = triggers.operator
		second_block = triggers.second_block

		if (first_block is MY_TIME and second_block is TIME) or (first_block is TIME and second_block is MY_TIME)
			if block_time.run() == block_my_time.run()
				action()

		else if (first_block is MY_IMAGE and second_block is MY_TEXT) or (first_block is MY_TEXT and second_block is MY_IMAGE)
			tags = block_image_recognition.run()
			text = block_my_text.run()
			if text in tags
				action()

		else if (first_block is MY_WEATHER and second_block is WEATHER) or (first_block is WEATHER and second_block is MY_WEATHER)
			weather = block_weather.run()
			my_weather = block_my_weather.run()
			if weather == my_weather
				action()

		else if (first_block is MY_LOCATION and second_block is MY_AREA) or (first_block is MY_AREA and second_block is MY_LOCATION)
			console.log "GOT IN HERE WHICH IS COOL"
			block_map.run action




	# else console.log "An error ocurred unfortunately"
	## gray our run button if everything is not filled

	MAP = 3
	BUZZ = 4
	SIREN = 10
	TIME = 8
	MY_TIME = 9
	MY_IMAGE = 100
	MY_TEXT = 150
	MY_WEATHER = 12
	YOUTUBE = 120
	MY_ARRAY = 11

	# This shows what the corresponding id's are for the blocks
	block_ids =
		drag1: MY_LOCATION
		drag2: WEATHER #not used
		drag3: IS_IN #==
		drag4: BUZZ #action
		drag5: MY_AREA #map block
		drag6: SIREN
		drag7: TIME
		drag8: MY_TIME
		drag9: YOUTUBE
		drag10: MY_IMAGE
		drag11: MY_TEXT
		drag15: MY_WEATHER
		drag16: MY_ARRAY

	$("#reset").click =>
		location.reload()

	for_loop = true
	$("#run").click =>
		
		triggers = {}
		action = null
		console.log "GOT IN HERE BITCHES"

		elements_in_environment = $ ".drop_over.draggable"
		#both for loop and an if else statement
		
		first_block_accounted_for = false
		for element in elements_in_environment
			cur_id = element.id
			if cur_id is "drag3"
				triggers.operator = block_ids[cur_id]
			else if cur_id is "drag4"
				action = block_ding.run
			else if cur_id is "drag6"
				action = block_siren.run
			else if cur_id is "drag13"
				action = block_camera.run
			else if cur_id is "drag9"
				action = block_youtube.run
			else if cur_id is "drag16"
				triggers.array = block_ids[cur_id]
			else
				if first_block_accounted_for is not true
					first_block_accounted_for = true
					triggers.first_block = block_ids[cur_id]
				else
					console.log "hello"
					console.log "cur_id #{cur_id}"
					triggers.second_block = block_ids[cur_id]
		console.log triggers
		console.log action
		run triggers, action