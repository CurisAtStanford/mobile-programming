###
The BlockAnimation class constucts a block that can
perform neat slider animations. The following properties must be
passed in:
@id: this is the id of the div that will be filled
IT'S SO IMPORTANT THAT THIS IS NOT REPEATED

Just put something like this in the index!
<div id="test">
	<div id="siren">
		<img src="src">
	</div>
	<div id="bell">
		<img src="src">
	</div>
	<div id="samjack">
		<img src="src">
	</div>
</div>

and type something like this in js:
block = new BlockAnimation("test");

The id's in the divs that hold the content are for identifying them as active slides.
For example, if the active slide on the block is the div with id="siren", then
get_active_slide will return "siren"
###

class BlockAnimation
	constructor: (@id) ->
		console.log "yay got in blokc animation with #{@id}"
		console.log @id
		@create_HTML()

		@swiper_reg = @make_reg_swiper()
		@swiper_hor = @make_horizontal_swiper()
		@swiper_ver = @make_vertical_swiper()

		console.log @swiper_reg
		console.log @swiper_hor
		console.log @swiper_ver

		@add_interactors(@swiper_reg, @swiper_hor, @swiper_ver)

	### Public Methods ###
	get_active_slide: ->
		active_slide= $("#{@id}-active")
		active_slide.attr 'id'


	# PRIVATE METHODS #
	create_HTML: ->
		$main = $("##{@id}")
		console.log "#{@id}"
		console.log $main[0]
		slide_content = $main.html()
		#Adds the animations to the DOM first
		#overwrites the html content, but we saved it in slide_content
		#This will be added in the html under the @id-content div
		$main.html("""
			<div class="swiper-container swiper-container-ver #{@id}-ver">
				<div class="swiper-wrapper">
					<div class="swiper-slide stop-swiping">
						<div id="vertical-frame"></div>
					</div>
				</div>
			</div>

			<!-- this is for the border that glides horizontally -->
			<div class="swiper-container swiper-container-hor #{@id}-hor">
				<div class="swiper-wrapper">
					<div class="swiper-slide stop-swiping">
						<div id="horizontal-frame"></div>
					</div>
				</div>
			</div>

			<!-- this is for the actual pictures -->
			<div id="swiper-container-reg" class="swiper-container swiper-container-reg #{@id}-reg">
				<div id="#{@id}-content" class="swiper-wrapper">
					#{slide_content}
				</div>
				<!-- Add Arrows -->
				<div class="swiper-button-next #{@id}-next"><i class="fa fa-chevron-right fa-3x"></i></div>
				<div class="swiper-button-prev #{@id}-prev"><i class="fa fa-chevron-left fa-3x"></i></div>
			</div>
		""")

		# Adds classes to the content divs
		#This is for styling
		$("##{@id}-content").children().each ->
			$(this).addClass "swiper-slide stop-swiping"

	add_interactors: ->
		interact(".#{@id}-next").on 'tap', ->
			console.log "got em in next"
			console.log @swiper_reg
			console.log @swiper_hor
			console.log @swiper_ver
			@swiper_reg.slideNext()
			@swiper_ver.slideNext()
			@swiper_hor.slideNext()

		interact(".#{@id}-prev").on 'tap', ->
			console.log "got em in prev"
			console.log @swiper_reg
			console.log @swiper_hor
			console.log @swiper_ver
			@swiper_reg.slidePrev()
			@swiper_ver.slidePrev()
			@swiper_hor.slidePrev()

	make_reg_swiper: ->
		console.log "Got here at least"
		console.log $(".#{@id}-reg")[0]
		new Swiper ".#{@id}-reg",
			nextButton: ".#{@id}-next"
			prevButton: ".#{@id}-prev"
			effect: 'coverflow'
			slideNextClass: "#{@id}-active"
			noSwiping: true
			noSwipingClass: "stop-swiping"
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

	make_vertical_swiper: ->
		console.log "got to ver"
		new Swiper ".#{@id}-ver",
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

	make_horizontal_swiper: ->
		console.log "got to hor"
		new Swiper ".#{@id}-hor",
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