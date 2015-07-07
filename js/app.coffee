$ ->
	#TODO fix map block bug (still has drop over class when
	# it is dragged out)
	# checks to see if block is in correct area
	check_area = (block, area) ->
		# console.log area
		areaType = area.attr("id").toString()
		blockTypes = block.attr("class").toString().split(' ')
		# console.log areaType
		# console.log blockTypes

		#first is value, second is array
		# console.log $.inArray areaType, blockTypes
		if parseInt($.inArray areaType, blockTypes) isnt -1
			# console.log "#{areaType} is in the array"
			return true
		return false

	#variables to keep track of previous positions
	previousLeft = 0
	previousUp = 0

	# drag_move
	# --------
	# Implements dragging functionality, called by the onMovevent in Interact.draggable
	drag_move = (event) ->
		target = event.target

		# Change position
		x = (parseFloat(event.target.getAttribute('data-x')) or 0) + event.dx
		y = (parseFloat(event.target.getAttribute('data-y')) or 0) + event.dy

		# Transform element
		target.style.webkitTransform =
		target.style.transform = "translate(#{x}px, #{y}px)"

		# Update position
		target.setAttribute 'data-x', x
		target.setAttribute 'data-y', y

		# target.css
		# 	'zIndex': 10

	# snap_to
	# ------
	# Takes in x and y coordinates and creates an object to be a target in snap function
	snap_to = (drop_x, drop_y) ->
		x: drop_x + 10
		y: drop_y + 10
		range: 400

	#ARRAY that shows what areas are filled
	#              block1  operator block2 dothis
	areasFilled = [false, false, false, false]
	areaBlockInfo = {}

	checkAreasFilled = (target) ->
		# console.log target
		targetID = target.attr("id")
		switch targetID
			when "block1" #first
				return areasFilled[0]
			when "block2" #second
				return areasFilled[2]
			when "block3" #action
				return areasFilled[3]
			when "operator" #operator
				return areasFilled[1]
			else
				# console.log "ojsL"
				return false

	toggleArea = (target) ->
		targetID = target.attr("id")
		switch targetID
			when "block1" #first
				if areasFilled[0]
					areasFilled[0] = false
				else areasFilled[0] = true
			when "block2" #second
				if areasFilled[2]
					areasFilled[2] = false
				else areasFilled[2] = true
			when "block3" #action
				if areasFilled[3]
					areasFilled[3] = false
				else areasFilled[3] = true
			when "operator" #operator
				if areasFilled[1]
					areasFilled[1] = false
				else areasFilled[1] = true
			else
				console.log "error on toggle"



	# setup_dropzone
	# -------------
	# Implements dropzone functionality by adding and removing classes to elements
	setup_dropzone = (el, accept) ->
		interact(el)
		#changing accept
		.dropzone
			accept: accept
			###
			ondropactivate: (event) ->
				$(event.relatedTarget).addClass 'drop_possible'

			ondropdeactivate: (event) ->
				$(event.relatedTarget).removeClass 'drop_possible'
			###
		.on 'dropactivate', (event) ->

			target = $ event.target
			related_target = $ event.relatedTarget

			return if check_area(related_target, target) is false

			if related_target.hasClass "in_zone"
				related_target.removeClass "in_zone"
				toggleArea target


			target.prop 'dropzoneName', target.text()
			target.addClass 'drop_possible'
			related_target.addClass 'drop_possible'
			target.text 'Drop here!'

		.on 'dropdeactivate', (event) ->
			target = $ event.target
			$(event.target).removeClass 'drop_possible'
			$(event.relatedTarget).removeClass 'drop_possible'
			target.text target.prop 'dropzoneName'

		#changes the areas, not the actual block, to solid grey
		.on 'dragenter', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			return if check_area(related_target, target) is false
			return if checkAreasFilled target
			target.addClass 'drop_over'

		.on 'dragleave', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			return if checkAreasFilled target
			target.removeClass 'drop_over'
			related_target.removeClass 'drop_over'

		.on 'drop', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			related_target.removeClass 'drop_over'

			result = checkAreasFilled target

			if check_area(related_target, target) && (result is false)
				# console.log "CORRECT!"
				related_target.addClass 'drop_over'
				related_target.addClass 'in_zone'
				toggleArea target

			else
				# console.log "WRONG"
				# Transform element
				x = 0
				y = 0
				related_target[0].style.webkitTransform =
				related_target[0].style.transform = "translate(#{x}px, #{y}px)"

				# Update position
				related_target[0].setAttribute 'data-x', x
				related_target[0].setAttribute 'data-y', y

	# elements in dropzone class can accept elements in draggable class
	setup_dropzone '.dropzone', '.draggable'


	# make an array of objects representing the x and y coordinates of each dropzone
	zones = []
	for dropzone in $('.dropzone')
		zones.push
			x: dropzone.getBoundingClientRect().left
			y: dropzone.getBoundingClientRect().top

	for draggable in $('.draggable')
		$(draggable).css
			zIndex: 0

	interact('.draggable').draggable
		onmove: (event) ->
			drag_move event
		onstart: (event) ->
			target = $ event.target
			target.css
				zIndex: 10
				webkitTransform: "translate3d(0px, 0px, 0px)"
		onend: (event) ->
			target = $ event.target
			target.css
				zIndex: 0
				webkitTransform: "translate3d(0px, 0px, 0px)"
		snap:
			targets: [
				snap_to zones[0].x, zones[0].y
				snap_to zones[1].x, zones[1].y
				snap_to zones[2].x, zones[2].y
				snap_to zones[3].x, zones[3].y
			]
			# TODO: Fix snapping to top left corner HERE?
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
	weather_icons = ["wi wi-umbrella", "wi wi-cloudy", "wi wi-day-sunny"]
	weather_block_count = 0

	interact('#drag2')
		.on 'tap', (event) ->
			previous_icon = weather_icons[weather_block_count]
			weather_block_count++
			weather_block_count = 0 if weather_block_count is weather_icons.length
			icon = weather_icons[weather_block_count]
			$("#weather").removeClass previous_icon
			$("#weather").addClass icon

	# block_map
	# --------
	# Todo: Code needs work - Brad
	$("#google_map").bind 'touchstart mousedown' ,->
		$("#drag5").removeClass("draggable").addClass "not_draggable"

	$("body").bind 'touchend mouseup', ->
		$("#drag5").removeClass("not_draggable").addClass "draggable"