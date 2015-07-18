class @control_for_loop_

	constructor: ($target)->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		append_to_this = null
		if $target?
			append_to_this = $target
		else append_to_this = '.drop-zone'

		@counter_id = window.counter
		window.counter = @counter_id + 1

		$("""
		<div class='text'>FOR EACH</div>
		<div class='droppable steps droppable-#{@counter_id}' role='array'>LIST</div>
		<div class='text'>DO</div>
		<div class='droppable steps droppable-#{@counter_id}' role='action'>THIS</div>
		""").appendTo append_to_this

		# still double fillable
		# interact('.droppable:not(.caught--it)').dropzone
		# TODO Change dropzone to have different classes
		interact(".droppable-#{@counter_id}").dropzone
			accept: '.draggable'
			overlap: .1

			ondropactivate: (event) ->
				$target = $ event.target
				$target.addClass 'can--drop'

			ondragenter: (event) ->
				$draggableElement = $ event.relatedTarget
				dropzoneElement = event.target
				dropRect = interact.getElementRect dropzoneElement
				dropCenter =
					x: dropRect.left + dropRect.width / 2
					y: dropRect.top + dropRect.height / 2
				event.draggable.draggable
					snap:
						targets: [ dropCenter ]

				# feedback the possibility of a drop
				dropzoneElement.classList.add 'can--catch'
				$draggableElement.addClass 'drop--me'

			ondragleave: (event) ->
				# remove the drop feedback style
				$target = $ event.target
				$relatedTarget = $ event.relatedTarget
				$target.removeClass 'can--catch'
				$relatedTarget.removeClass 'caught--it'
				$relatedTarget.removeClass 'drop--me'

			ondrop: (event) =>
				$target = $ event.target
				$related_target = $ event.relatedTarget
				block_name = _.trim $related_target.text().toLowerCase()

				if $target.attr('role') is 'array'
					block_name = $related_target.attr "name"
					@array = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					block_name = $related_target.attr "name"
					if block_name is "ifthen"
						@transform_action_area $target, $related_target, false
					else if block_name is "forloop"
						@transform_action_area $target, $related_target, true
					else
						@action = window["block_#{block_name}"]

				$target.addClass 'caught--it'

				# remove block from drag zone! (NEEDS WORK)
				$related_target.removeClass 'drag-wrap'

			ondropdeactivate: (event) ->
				# remove active dropzone feedback
				$target = $ event.target
				$target.removeClass 'can--drop', 'can--catch'

	transform_action_area: ($target, $block, isLoop) ->
		$block.remove()
		$target.html " "
		$target.removeClass()
		$target.css
			"width":"auto"
			"height":"auto"
		$target.attr
			"role":"whatever"
		control_condition = null
		if isLoop
			console.log "Is a for loop"
			control_condition = new control_for_loop_($target)
			new draggable_control_for_loop_()
		else
			console.log "Is an if consition"
			control_condition = new control_if_then_($target)
			new draggable_control_if_then_()
		@action = control_condition

	run: (outer_cb) =>
		console.log @array
		console.log "GOT IN FOR LOOP RUN"
		console.log @action
		#	for element in @array.run()
		#		@action.run element
		async.forEachOfSeries @array.run(), (element, i, cb) =>
			console.log "Element: #{element}"
			console.log "Value: #{i}"
			# call the music here, return option, 0 synchronous
			@action.run cb, element
			# cb()
			return
		, (err) ->
			if outer_cb?
				outer_cb()
