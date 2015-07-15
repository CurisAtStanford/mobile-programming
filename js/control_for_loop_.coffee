class @control_for_loop_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class='text'>FOR EACH</div>
		<div class='droppable steps' role='array'>LIST</div>
		<div class='text'>DO</div>
		<div class='droppable steps' role='action'>THIS</div>
		""").appendTo ".drop-zone"

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
				block_name = _.trim $related_target.text().toLowerCase()

				if $target.attr('role') is 'array'
					block_name = $related_target.attr "name"
					@array = window["block_#{block_name}"]

				if $target.attr('role') is 'action'
					block_name = $related_target.attr "name"
					@action = window["block_#{block_name}"]

				$target.addClass 'caught--it'

			ondropdeactivate: (event) ->
				# remove active dropzone feedback
				$target = $ event.target
				$target.removeClass 'can--drop', 'can--catch'

	run: () =>
		@array = window["block_instagram"]
		@action = window["block_display_image"]

		console.log @array

		a = @array.run()
		i=0
		t = doAndRepeat 3000, =>
			@action.run a[i]
			if i == a.length
				clearTimeout t
			i++