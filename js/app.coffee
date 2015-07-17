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
	window.block_camera = new block_camera_()
	window.block_text_to_speech = new block_text_to_speech_()
	window.block_taylorswift = new block_taylorswift_()
	window.block_selenagomez = new block_selenagomez_()
	window.block_kimkardashian = new block_kimkardashian_()
	window.block_beyonce = new block_beyonce_()
	window.block_drake = new block_drake_()
	window.block_rihanna = new block_rihanna_()
	
	# window.block_image_recognition = new block_image_recognition_()
	# window.block_my_weather = new block_my_weather_()
	# window.block_text = new block_text_()
	# window.block_weather = new block_weather_()
	# window.block_youtube = new block_youtube_()
	# window.block_accelerometer


	# async.series [
	# 	(cb) => 
	# 		console.log "start 1"
	# 		wait 2000, =>
	# 			console.log "stop 1"
	# 			cb()

	# 	(cb) => 
	# 		console.log "start 2"
	# 		wait 2000, =>
	# 			console.log "stop 2"
	# 			cb()
	# ]

	images = 
		one: 1
		two: 2
		three: 3
		four: 4

	async.forEachOfSeries images, (key, value, cb) ->
		console.log key
		console.log value
		wait 1000, =>
			cb()
		return
	, (err) ->
		console.log 'iterating done'



# twitter
# text messagnig
# urban dictionary - speak back th edefinition to you
# really cool idea but it would be hard to understand it
# you are actually programming and not that someone is doing it for you
# want the user to have the power to make it feel like it si there
# voice recording


	# control statements
	control = new control_if_then_()
	# control = new control_for_loop_()

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

	put_text_in_block = (text, block_name) ->
		$("##{block_name}").val(text)

	commands =
		'put *text in :block_name block': put_text_in_block
		'run': control.run
	annyang.addCommands commands
	annyang.start
		continuous: true

	$("#button_run").click =>
		control.run()

	# Swiper logic
	swiper_reg = new Swiper '.swiper-container-reg',
		pagination: '.swiper-pagination'
		nextButton: '.swiper-button-next'
		prevButton: '.swiper-button-prev'
		effect: 'coverflow'
		slideActiveClass: 'fake-active-slide'
		slideNextClass: 'real-active-slide'
		noSwiping: true
		noSwipingClass: 'stop-swiping'
		slidesPerView: 3
		spaceBetween: 30
		speed: 800
		loop: true
		coverflow:
			rotate: 50
			stretch: 0
			depth: 100
			modifier: 1
			slideShadows : false

	swiper_ver = new Swiper '.swiper-container-ver',
		noSwiping: true
		noSwipingClass: 'stop-swiping'
		effect: 'coverflow'
		slidesPerView: 1
		spaceBetween: 30
		loop: true
		direction: 'vertical'
		speed: 800
		coverflow:
			rotate: 50
			stretch: 0
			depth: 100
			modifier: 1
			slideShadows : false

	swiper_hor = new Swiper '.swiper-container-hor',
		effect: 'coverflow'
		noSwiping: true
		noSwipingClass: 'stop-swiping'
		slidesPerView: 1
		spaceBetween: 30
		speed: 800
		loop: true
		coverflow:
			rotate: 50
			stretch: 0
			depth: 100
			modifier: 1
			slideShadows : false

	interact(".swiper-button-next").on 'tap', ->
		swiper_reg.slideNext()
		swiper_ver.slideNext()
		swiper_hor.slideNext()
		console.log "BOOM"

	interact(".swiper-button-prev").on 'tap', ->
		swiper_reg.slidePrev()
		swiper_ver.slidePrev()
		swiper_hor.slidePrev()
		console.log "BAM"
