$ ->
	# window.global_block_width = window.global_block_height = 290

	# blocks
	window.block_time = new block_time_()
	window.block_array = new block_array_()
	window.block_ding = new block_ding_()
	window.block_siren = new block_siren_()
	window.block_true = new block_true_()
	window.block_display_image = new block_display_image_()
	window.block_display_text = new block_display_text_()
	window.block_map = new block_map_()
	window.block_instagram = new block_instagram_()

	# window.block_camera = new block_camera_()
	# window.block_image_recognition = new block_image_recognition_()
	# window.block_my_weather = new block_my_weather_()
	# window.block_text = new block_text_()
	# window.block_weather = new block_weather_()
	# window.block_youtube = new block_youtube_()
	# window.block_accelerometer

	# control statements
	# control = new control_if_then_()
	control = new control_for_loop_()

	startPos = null
	interact('.draggable').draggable
		snap:
			targets: [ startPos ]
			relativePoints: [ {
				x: 0.5
				y: 0.5
			} ]
			range: 200
			endOnly: true

		onstart: (event) ->
			rect = interact.getElementRect event.target
			# record center point when starting the very first a drag
			startPos =
				x: rect.left + rect.width / 2
				y: rect.top + rect.height / 2
			event.interactable.draggable
				snap:
					targets: [ startPos ]
					range: 200

		onmove: (event) ->
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px, #{y}px)"

			# update the posiion attributes
			$target.attr 'data-x', x
			$target.attr 'data-y', y
			$target.addClass 'getting--dragged'

		onend: (event) ->
			$target = $ event.target
			$target.removeClass 'getting--dragged'

	$("#button_run").click =>
		control.run()