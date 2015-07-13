class @control_if_then_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='if' class="text" >IF</div>
		<div id='block1' class="dropzone">BLOCK1</div>
		<div id='operator' class="dropzone">________</div>
		<div id='block2' class='dropzone'>BLOCK2</div>
		<div id='then' class='text'>THEN</div>
		<div id='block3' class='dropzone'>DO THIS</div>
		""").appendTo ".dropzone_wrapper"

		# check_zones_filled
		# ------------------
		# Checks if dropzone is filled to prevent double dropping
		check_zones_filled = (target) ->
			target_id = target.attr "id"
			switch target_id
				when "block1" # first
					return areas_filled[0]
				when "block2" # second
					return areas_filled[2]
				when "block3" # action
					return areas_filled[3]
				when "operator" # operator
					return areas_filled[1]
				else
					return false

		# Array of booleans representing which dropzones are filled
					# block1  operator  block2  action
		areas_filled = [false, false, false, false]


		# toggle_area
		# -----------
		# Marks dropzone as filled (true) or not filled (false)
		toggle_area = (target) ->
			target_id = target.attr "id"
			switch target_id
				when "block1" # first
					if areas_filled[0]
						areas_filled[0] = false
					else areas_filled[0] = true
				when "block2" # second
					if areas_filled[2]
						areas_filled[2] = false
					else areas_filled[2] = true
				when "block3" # action
					if areas_filled[3]
						areas_filled[3] = false
					else areas_filled[3] = true
				when "operator" # operator
					if areas_filled[1]
						areas_filled[1] = false
					else areas_filled[1] = true
				else
					console.log "error on toggle"

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

		# Implements dropzone functionality
		# Elements in dropzone class can accept elements in draggable class
		interact('.dropzone')
		.dropzone
			accept: '.draggable'

# :not(.caught--it)

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
			draggableElement = event.relatedTarget
			dropzoneElement = event.target
			dropRect = interact.getElementRect dropzoneElement
			dropCenter =
				x: dropRect.left
				y: dropRect.top
				range: 400

			event.draggable.draggable
				snap:
					targets: [dropCenter]
					relativePoints: [
						x: 0
						y: 0
					]
					endOnly: true

			$target = $ event.target
			$related_target = $ event.relatedTarget

			return if check_zone($related_target, $target) is false
			return if check_zones_filled $target
			$target.addClass 'drop_over'

		.on 'dragleave', (event) ->
			$target = $ event.target
			$related_target = $ event.relatedTarget

			return if check_zones_filled $target
			$target.removeClass 'drop_over'
			$related_target.removeClass 'drop_over'

		.on 'drop', (event) ->
			$target = $ event.target
			$related_target = $ event.relatedTarget

			result = check_zones_filled $target
			if check_zone($related_target, $target) && (result is false)
				$related_target.addClass 'drop_over'
				$related_target.addClass 'in_zone'
				toggle_area $target
			else
				# Wrong dropzone, snap back
				x = y = 0
				$related_target.css
					transform: "translate(#{x}px, #{y}px)"

				# Update position
				$related_target.attr 'data-x', x
				$related_target.attr 'data-y', y

		# Array of objects representing the x and y coordinates of each dropzone
		zones = []
		for dropzone in $('.dropzone')
			zones.push
				x: dropzone.getBoundingClientRect().left
				y: dropzone.getBoundingClientRect().top

		interact('.draggable').draggable
			onmove: (event) ->
				$target = $ event.target

				# Change position
				x = (parseFloat($target.attr 'data-x') or 0) + event.dx
				y = (parseFloat($target.attr 'data-y') or 0) + event.dy

				$target.css
					transform: "translate(#{x}px, #{y}px)"

				# Update position
				$target.attr 'data-x', x
				$target.attr 'data-y', y

			onstart: (event) ->
				target = $ event.target
				target.css
					zIndex: 10
			onend: (event) ->
				target = $ event.target
				target.css
					zIndex: 0
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

	run: ()=>
