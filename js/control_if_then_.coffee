class @control_if_then_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class='text'>IF</div>
		<div class='droppable steps' role='condition'>THIS</div>
		<div class='text'>THEN</div>
		<div class='droppable steps' role='action'>THAT</div>
		""").appendTo '.drop-zone'

		# still double fillable
		# interact('.droppable:not(.caught--it)').dropzone
		interact('.droppable').dropzone
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

				if $target.attr('role') is 'condition'
					block_name = $related_target.attr "name"
					@condition = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					block_name = $related_target.attr "name"
					@action = window["block_#{block_name}"]

				$target.addClass 'caught--it'

			ondropdeactivate: (event) ->
				# remove active dropzone feedback
				$target = $ event.target
				$target.removeClass 'can--drop', 'can--catch'

	run: ()=>
		if @condition.run()
			@action.run()