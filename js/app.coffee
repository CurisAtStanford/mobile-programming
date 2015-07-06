$ ->
	# checks to see if block is in correct area
	checkArea = (block, area) ->
		areaType = area.attr("id").toString()
		blockTypes = block.attr("class").toString().split(' ')
		console.log areaType
		console.log blockTypes

		#first is value, second is array
		console.log $.inArray areaType, blockTypes
		if parseInt($.inArray areaType, blockTypes) isnt -1
			console.log "#{areaType} is in the array"
			return true
		return false

	#variables to keep track of previous positions
	previousLeft = 0
	previousUp = 0

	# dragMove
	# --------
	# Implements dragging functionality, called by the onMovevent in Interact.draggable
	dragMove = (event) ->
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

	# setupDropzone
	# -------------
	# Implements dropzone functionality by adding and removing classes to elements
	setupDropzone = (el, accept) ->
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

			if checkArea(related_target, target) is false
				target.addClass 'rejectzone'
				interact(".rejectzone").unset()
				return



			target.prop 'dropzoneName', target.text()
			target.addClass 'drop_possible'
			related_target.addClass 'drop_possible'
			target.text 'Drop here!'
			
		.on 'dropdeactivate', (event) ->
			target = $ event.target
			#checkArea target
			$(event.target).removeClass 'drop_possible'
			$(event.relatedTarget).removeClass 'drop_possible'
			target.text target.prop 'dropzoneName'

		#changes the areas, not the actual block, to solid grey
		.on 'dragenter', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			return if checkArea(related_target, target) is false
			target.addClass 'drop_over'

		.on 'dragleave', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			# console.log "Target: #{target[0]}"
			# console.log "related_target: #{related_target[0]}"
			target.removeClass 'drop_over'
			related_target.removeClass 'drop_over'

		.on 'drop', (event) ->
			target = $ event.target
			related_target = $ event.relatedTarget
			console.log target[0] #area
			console.log related_target[0] #draggable block
			target.removeClass 'drop_over'
			if checkArea related_target, target
				console.log "CORRECT!"
				related_target.addClass 'drop_over'
			else 
				console.log "WRONG"

	# elements in dropzone class can accept elements in draggable class
	setupDropzone '.dropzone', '.draggable'

	# make an array of objects representing the x and y coordinates of each dropzone
	zones = []
	for dropzone in $('.dropzone')
		zones.push
			x: dropzone.getBoundingClientRect().left
			y: dropzone.getBoundingClientRect().top

	interact('.draggable').draggable
		onmove: (event) ->
			dragMove event
		snap:
			targets: [
				# TODO: clean up redundant code?
				# for dropzone in zones
				(x, y) ->
					x: zones[0].x
					y: zones[0].y
					range: 400
				(x, y) ->
					x: zones[1].x
					y: zones[1].y
					range: 400
				(x, y) ->
					x: zones[2].x
					y: zones[2].y
					range: 400
				(x, y) ->
					x: zones[3].x
					y: zones[3].y
					range: 400
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
			#console.log $("#weather").attr('class')

	# block_map
	# --------
	# Todo: Code needs work - Brad
	$("#google_map").bind 'touchstart mousedown' ,-> 
		$("#drag5").removeClass("draggable").addClass "not_draggable"

	$("body").bind 'touchend mouseup', -> 
		$("#drag5").removeClass("not_draggable").addClass "draggable"