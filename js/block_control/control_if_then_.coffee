class @control_if_then_

	constructor: ($target)->
		css = """
		"""

		$("<style type='text/css'></style>").html(css).appendTo "head"

		append_to_this = null
		if $target?
			append_to_this = $target
		else append_to_this = '.drop-zone'

		console.log append_to_this

		@counter_id = window.counter;
		window.counter = @counter_id + 1;

		$("""
		<div class='text'>IF</div>
		<div class='droppable steps droppable-#{@counter_id}' role='condition'>THIS</div>
		<div class='text'>THEN</div>
		<div class='droppable steps droppable-#{@counter_id}' role='action'>THAT</div>
		""").appendTo append_to_this

		# This is for telling whether something is a duplicate
		# index 0 is the condition, index 1 is the action
		# The action will go away if something is dragged into it
		@spot_filled = [false, false]

		# still double fillable
		#if not $target?
		console.log "Got em in $target"
		#interact('.droppable:not(.caught--it)').dropzone
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

				### This checks to see if there's a duplicate ###
				# if $target.attr("filled") is "true"
				# 	console.log "FILLED"
				# 	$related_target.
				# 	return

				if $target.attr('role') is 'condition'
					console.log "condition dropped"
					block_name = $related_target.attr "name"
					@condition = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					console.log "action dropped"
					block_name = $related_target.attr "name"
					if block_name is "ifthen"
						@transform_action_area $target, $related_target, false
					else if block_name is "forloop"
						@transform_action_area $target, $related_target, true
					else
						@action = window["block_#{block_name}"]
				$target.attr "filled", "true"

				# if $target.attr('role') is 'array'
				# 	console.log "array dropped"
				# 	block_name = $related_target.attr "name"
				# 	@array = window["block_#{block_name}"]

				$target.addClass 'caught--it'

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
			console.log "Is an if condition"
			control_condition = new control_if_then_($target)
			new draggable_control_if_then_()
		@action = control_condition

	run: (outer_cb, element)=>
		if @condition.run()
			console.log "Running"
			console.log @action #the new action is siren: it's overwritten
			@action.run(outer_cb, element)
		else
			if outer_cb?
				outer_cb()
class @control_if_then_

	constructor: ($target)->
		css = """
		"""

		$("<style type='text/css'></style>").html(css).appendTo "head"

		append_to_this = null
		if $target?
			append_to_this = $target
		else append_to_this = '.drop-zone'

		console.log append_to_this

		@counter_id = window.counter;
		window.counter = @counter_id + 1;

		$("""
		<div class='text'>IF</div>
		<div class='droppable steps droppable-#{@counter_id}' role='condition'>THIS</div>
		<div class='text'>THEN</div>
		<div class='droppable steps droppable-#{@counter_id}' role='action'>THAT</div>
		""").appendTo append_to_this

		# This is for telling whether something is a duplicate
		# index 0 is the condition, index 1 is the action
		# The action will go away if something is dragged into it
		@spot_filled = [false, false]

		# still double fillable
		#if not $target?
		console.log "Got em in $target"
		#interact('.droppable:not(.caught--it)').dropzone
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

				### This checks to see if there's a duplicate ###
				# if $target.attr("filled") is "true"
				# 	console.log "FILLED"
				# 	$related_target.
				# 	return

				if $target.attr('role') is 'condition'
					console.log "condition dropped"
					block_name = $related_target.attr "name"
					@condition = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					console.log "action dropped"
					block_name = $related_target.attr "name"
					if block_name is "ifthen"
						@transform_action_area $target, $related_target, false
					else if block_name is "forloop"
						@transform_action_area $target, $related_target, true
					else
						@action = window["block_#{block_name}"]
				$target.attr "filled", "true"

				# if $target.attr('role') is 'array'
				# 	console.log "array dropped"
				# 	block_name = $related_target.attr "name"
				# 	@array = window["block_#{block_name}"]

				$target.addClass 'caught--it'

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
			console.log "Is an if condition"
			control_condition = new control_if_then_($target)
			new draggable_control_if_then_()
		@action = control_condition

	run: (outer_cb, element)=>
		if @condition.run()
			console.log "Running"
			console.log @action #the new action is siren: it's overwritten
			@action.run(outer_cb, element)
		else
			if outer_cb?
				outer_cb()
