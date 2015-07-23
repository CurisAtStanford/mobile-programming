$ ->
	window.counter = 0 # this is to separate logic between conditions

	# -----------------------------
	# BLOCKS (bank layout 9-8-9)
	# -----------------------------
	# Row 1
	window.block_true = new block_true_()
	window.block_sound = new block_sound_()
	window.block_display_image = new block_display_image_()
	window.block_display_image_fade = new block_display_image_fade_()
	window.block_time = new block_time_()
	window.block_pizza = new block_pizza_()
	window.block_donut = new block_donut_()
	window.block_background_color = new block_background_color_()
	window.block_block_color = new block_block_color_()

	# Row 2
	window.block_instagram = new block_instagram_()
	window.block_youtube = new block_youtube_()
	window.block_text_to_speech = new block_text_to_speech_()
	window.block_background_image = new block_background_image_()
	window.block_array = new block_array_()
	window.block_weather = new block_weather_()
	window.block_temp8 = new block_place_holder_()
	window.block_temp9 = new block_place_holder_()

	# Row 3
	window.block_beyonce = new block_beyonce_()
	window.block_drake = new block_drake_()
	window.block_kimkardashian = new block_kimkardashian_()
	window.block_rihanna = new block_rihanna_()
	window.block_selenagomez = new block_selenagomez_()
	window.block_taylorswift = new block_taylorswift_()
	window.block_nlp = new block_nlp_()
	window.block_spotify = new block_spotify_()
	window.block_tinder = new block_tinder_()
	# window.block_display_text = new block_display_text_()
	# window.block_text = new block_text_()

	# Control statements
	# control = new control_if_then_()
	control = new control_for_loop_()


	# NOT WORKING
	# window.block_for_loop = new draggable_control_for_loop_()
	# window.block_if_then = new draggable_control_if_then_()
	# window.block_nlp = new block_nlp_()
	# window.block_map = new block_map_()
	# window.block_camera = new block_camera_()
	# window.block_vibrate = new block_vibrate_()

	# IN PROGRESS
	# phone block
	# top 40
	# image_recognition
	# orientation (accelerometer)
	# pic recognition
	# color senser

	# FUTURE BLOCKS?
	# twitter
	# text messagnig
	# urban dictionary
		# - speak back the definition to you
		# really cool idea but it would be hard to understand it
		# you are actually programming and not that someone is doing it for you
		# want the user to have the power to make it feel like it is there
	# voice recording

	# STILL DOING?
	# window.block_text = new block_text_()


	# ---------------------------
	# APPLE WATCH UI BLOCK BANK
	# ---------------------------
	items = $(".drag-wrap")

	h = window.innerHeight
	w = window.innerWidth

	# center
	c = items[Math.round(items.length / 2)]
	cr = c.getBoundingClientRect()

	onScroll = () =>
		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (w / 2)) / (w/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css
				'-webkit-transform': "scale(#{s2})"
			++i
		return

	# set up ui on load
	onScroll cr.left - (w / 2) + cr.width / 2, cr.top - (h / 2) + cr.height / 2


	# ---------------------------------
	# DRAGGABLE GRID (BUBBLE SCROLLING)
	# ---------------------------------
	interact('.drag-zone').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					left: 0.70
					right: 0.30
		onstart: (event) ->
		onmove: (event) =>
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			# y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px)"
				# '-webkit-transform': "translate(#{x}px, #{y}px)"

			$target.attr 'data-x', x
			# $target.attr 'data-y', y

			items = $(".drag-wrap")
			onScroll()


	# ---------------------------
	# DRAGGABLE BLOCKS
	# ---------------------------
	startPos = null
	interact('.draggable').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					top: 0
					left: 0
					bottom: 1
					right: 1
			axis: 'xy'
		snap:
			targets: [ startPos ]
			relativePoints: [ {
				x: 0.5
				y: 0.5
			} ]
			range: 100
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


	# ---------------------------
	# BUTTONS
	# ---------------------------
	cb = () =>
		console.log "RUN"
	$("#button_run").click =>
		control.run(cb)

	$("#button_reset").click =>
		location.reload()


	# ---------------------------
	# SPEECH RECOGNITION LOGIC
	# ---------------------------
	put_text_in_block = (text, block_name) ->
		$("##{block_name}").val(text)

	commands =
		'put *text in :block_name block': put_text_in_block
		'run': control.run
	annyang.addCommands commands
	annyang.start
		continuous: true