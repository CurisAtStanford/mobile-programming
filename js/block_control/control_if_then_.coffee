class @control_if_then_

	constructor: ($target)->
		css = """
			#this-drop-zone {
				left: 25px;
			}
			#then-text {
				left: 115px;
			}
			#that-drop-zone {
				left: 200px;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		append_to_this = null
		if $target?
			append_to_this = $target
		else append_to_this = '.drop-zone'

		@counter_id = window.counter;
		window.counter = @counter_id + 1;

		$("""
		<div id='if-text' class='text'>IF</div>
		<div id='this-drop-zone' class='droppable steps droppable-#{@counter_id}' role='condition'>THIS</div>
		<div id='then-text' class='text'>THEN</div>
		<div id='that-drop-zone' class='droppable steps droppable-#{@counter_id}' role='action'>THAT</div>
		""").appendTo append_to_this


		# block bank ui
		items = $(".drag-wrap")
		onScroll = () =>
			i=0
			while i < items.length
				pos = items[i].getBoundingClientRect()
				s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
				s2 = 1 - Math.abs(s2)

				$(items[i]).css
					'-webkit-transform': "scale(#{s2})"
				++i
			return

		# This is for telling whether something is a duplicate
		# index 0 is the condition, index 1 is the action
		# The action will go away if something is dragged into it
		@spot_filled = [false, false]


		# still double fillable
		#interact('.droppable:not(.caught--it)').dropzone
		interact(".droppable-#{@counter_id}").dropzone
			accept: '.draggable'
			overlap: .1

			ondropactivate: (event) ->
				$target = $ event.target
				# $target.addClass 'can--drop'

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
				# dropzoneElement.classList.add 'can--catch'
				# $draggableElement.addClass 'drop--me'

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

				if $target.attr('role') is 'condition'
					block_name = $related_target.attr "name"
					@condition = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					block_name = $related_target.attr "name"
					if block_name is "ifthen"
						@transform_action_area $target, $related_target, false
					else if block_name is "forloop"
						@transform_action_area $target, $related_target, true
					else
						@action = window["block_#{block_name}"]
				$target.attr "filled", "true"
				$target.addClass 'caught--it'

				# Clone block and remove from drag zone
				if $related_target.hasClass('drag-wrap')
					# clone block and append to drop zone
					$clone = $related_target.detach()
					$clone.removeClass('drag-wrap')
					$clone.removeClass('getting--dragged')
					$clone.appendTo('.drop-zone')

					# update the position attributes
					x = $target.position().left + 5
					y = $target.position().top
					$clone.css
						'-webkit-transform': "translate(#{x}px, #{y}px)"
						'position': 'absolute'
					$clone.attr 'data-x', x
					$clone.attr 'data-y', y

					items = $(".drag-wrap")
					onScroll()

			ondropdeactivate: (event) ->
				$target = $ event.target
				# $target.removeClass 'can--drop', 'can--catch'

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
			control_condition = new control_for_loop_($target)
			new draggable_control_for_loop_()
		else
			control_condition = new control_if_then_($target)
			new draggable_control_if_then_()
		@action = control_condition

	run: (outer_cb, element)=>
		@condition.run (true_or_false) =>
			if true_or_false
				@action.run(outer_cb, element)
			else
				if outer_cb?
					outer_cb()
