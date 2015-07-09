$ ->
	#yay
	# transform
	# ---------
	# Takes an HTML object and applies a CSS transformation (position and scale)
	# To shrink, set scale_ratio < 1
	transform = (element, x, y, scale_ratio) ->
		element.style.webkitTransform =
		element.style.transform = "translate(#{x}px, #{y}px) scale(#{scale_ratio})"

	# drag_move
	# --------
	# Implements dragging functionality, called by the onMovevent in Interact.draggable
	drag_move = (event) ->
		target = event.target

		# Change position
		x = (parseFloat(target.getAttribute('data-x')) or 0) + event.dx
		y = (parseFloat(target.getAttribute('data-y')) or 0) + event.dy

		# Transform element
		transform target, x, y, 1

		# Update position
		target.setAttribute 'data-x', x
		target.setAttribute 'data-y', y

	# snap_to
	# ------
	# Takes in x and y coordinates and creates an object to be a target in snap function
	snap_to = (drop_x, drop_y) ->
		x: drop_x + 8
		y: drop_y + 8
		range: 400

	# check_zone
	# ----------
	# Checks to see if block is in correct area
	check_zone = (block, area) ->
		areaType = area.attr("id").toString()
		blockTypes = block.attr("class").toString().split(' ')

		# first is value, second is array
		if parseInt($.inArray areaType, blockTypes) isnt -1
			return true
		return false

	# Array of booleans representing which dropzones are filled
				# block1  operator  block2  dothis
	areasFilled = [false, false, false, false]
	areaBlockInfo = {}

	# check_zones_filled
	# ------------------
	# Checks if dropzone is filled to prevent double dropping
	check_zones_filled = (target) ->
		targetID = target.attr("id")
		switch targetID
			when "block1" # first
				return areasFilled[0]
			when "block2" # second
				return areasFilled[2]
			when "block3" # action
				return areasFilled[3]
			when "operator" # operator
				return areasFilled[1]
			else
				return false

	# toggle_area
	# -----------
	# Marks dropzone as filled (true) or not filled (false)
	toggle_area = (target) ->
		targetID = target.attr("id")
		switch targetID
			when "block1" # first
				if areasFilled[0]
					areasFilled[0] = false
				else areasFilled[0] = true
			when "block2" # second
				if areasFilled[2]
					areasFilled[2] = false
				else areasFilled[2] = true
			when "block3" # action
				if areasFilled[3]
					areasFilled[3] = false
				else areasFilled[3] = true
			when "operator" # operator
				if areasFilled[1]
					areasFilled[1] = false
				else areasFilled[1] = true
			else
				console.log "error on toggle"

	# setup_dropzone
	# -------------
	# Implements dropzone functionality
	setup_dropzone = (el, accept) ->
		interact(el)
		#changing accept
		.dropzone
			accept: accept

		.on 'dropactivate', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget

			return if check_zone(related_target, target) is false
			if related_target.hasClass "in_zone"
				related_target.removeClass "in_zone"
				toggle_area target
			target.prop 'dropzoneName', target.text()
			target.text 'Drop here!'
			target.addClass 'drop_possible'
			related_target.addClass 'drop_possible'

		.on 'dropdeactivate', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget

			target.text target.prop 'dropzoneName'
			target.removeClass 'drop_possible'
			related_target.removeClass 'drop_possible'

		.on 'dragenter', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget

			return if check_zone(related_target, target) is false
			return if check_zones_filled target
			target.addClass 'drop_over'

		.on 'dragleave', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget

			return if check_zones_filled target
			target.removeClass 'drop_over'
			related_target.removeClass 'drop_over'

		.on 'drop', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget

			result = check_zones_filled target
			if check_zone(related_target, target) && (result is false)
				related_target.addClass 'drop_over'
				related_target.addClass 'in_zone'
				toggle_area target
				# SHRINK
				# x = related_target[0].getAttribute('data-x')
				# y = related_target[0].getAttribute('data-y')
				# transform related_target[0], x, y, 0.7
			else
				# Wrong dropzone, snap back
				x = 0
				y = 0
				transform related_target[0], x, y, 1

				# Update position
				related_target[0].setAttribute 'data-x', x
				related_target[0].setAttribute 'data-y', y

	# Elements in dropzone class can accept elements in draggable class
	setup_dropzone '.dropzone', '.draggable'

	# Array of objects representing the x and y coordinates of each dropzone
	zones = []
	for dropzone in $('.dropzone')
		zones.push
			x: dropzone.getBoundingClientRect().left
			y: dropzone.getBoundingClientRect().top

	interact('.draggable').draggable
		onmove: (event) ->
			drag_move event
		onstart: (event) ->
			target = $ event.target
			target.css
				zIndex: 10
		onend: (event) ->
			target = $ event.target
			target.css
				zIndex: 0
		snap:
			targets: [
				snap_to zones[0].x, zones[0].y
				snap_to zones[1].x, zones[1].y
				snap_to zones[2].x, zones[2].y
				snap_to zones[3].x, zones[3].y
			]
			relativePoints: [
				x: 0
				y: 0
			]
			endOnly: true
		restrict:
			restriction: 'body'
			endOnly: true
			elementRect:
				top: 0
				left: 0
				bottom: 1
				right: 1
		axis: 'xy'
		inertia: true
		max: Infinity
		maxPerElement: 2

	# block_weather
	# --------
	# Implements dragging functionality, called by the onMove event in Interact.draggable
	#weather_icons = ["wi wi-umbrella", "wi wi-cloudy", "wi wi-day-sunny"]
	weather_block_count = 0

	$cloudy = $("#cloudy")
	$sunny = $("#sunny")
	$rainy = $("#weather")

	get_previous_class = ->
		previous = weather_block_count - 1
		previous = weather_icons.length - 1 if previous < 0
		return weather_icons[previous]

	get_next_class = ->
		next = weather_block_count + 1
		next = 0 if next >= weather_icons.length
		return weather_icons[next]

	# -> current goes to previous which goes to next
	weather_icons = [$rainy, $cloudy, $sunny]
	#$rainy.velocity
	#	scale: 4.5
	boolTest = true
	boolTest2 = true
	boolTest3 = true
	interact('#drag2')
		.on 'tap', (event) ->
			#this icon will shrink and move to the right
			$old_icon = weather_icons[0]
			#this one will just move to the left
			$shifted = weather_icons[2]
			#this one will enlarge and move to the right
			$new_icon = weather_icons[1]

			ymove = 70
			xmove = 90
			scale = 1.0

			if $old_icon.hasClass "wi-umbrella"
				ymove = 370
				scale = 1/4.5
				xmove = 610


			$old_icon.velocity
				scale: "#{scale}"
				translateX: "+=#{xmove}"
				translateY: "-=#{ymove}"
			, 100

			xmove_shifted = 180
			xmove_shifted = 800 if $shifted.hasClass "wi-umbrella"

			$shifted.velocity
				translateX: "-=#{xmove_shifted}"
			, 100

			ymove_new = 70
			scale_new = 4.5
			xmove_new = 90
			if $new_icon.hasClass "wi-umbrella"
				ymove_new = 370
				scale_new = 1.0
				xmove_new = 190


			$new_icon.velocity
				translateY: "+=#{ymove_new}"
				translateX: "+=#{xmove_new}"
				scale: "#{scale_new}"
			, 100

			$info = $("#info")
			$info.removeClass()
			$info.addClass $new_icon.attr('class').split(' ')[1]

			end_icon = weather_icons.shift()
			weather_icons.push end_icon

	#clock logic
	$hours = $("#hours")
	$minutes = $("#minutes")
	$time = $("#time")


	hours_counter = 12
	minutes_counter = 0
	morning = true

	interact('.arrowUp')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			console.log block
			switch block
				when "hoursBlock"
					hours_counter++
					hours_counter = 1 if hours_counter > 12
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter++
					minutes_counter = 0 if minutes_counter > 59
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "BIG ERROR NOOOOOO"

	interact('.arrowDown')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlock"
					hours_counter--
					hours_counter = 12 if hours_counter <= 0
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter--
					minutes_counter = 59 if minutes_counter < 0
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "BIG ERROR NOOOOOO"

	# block_map
	# --------
	# Implements non-dragging functionality for map block
	$("#google_map").bind 'touchstart mousedown' ,->
		$("#drag5").removeClass("draggable").addClass "not_draggable"

	$("body").bind 'touchend mouseup', ->
		$("#drag5").removeClass("not_draggable").addClass "draggable"