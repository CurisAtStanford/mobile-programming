class @block_weather_

	constructor: ()->
		css = """
		.swiper-slide img {
			width: 150px;
			height: 150px;
		}

		.swiper-container {
			width: 100%;
			height: 100%;
			margin-left: auto;
			margin-right: auto;
			position: relative;
		}

		.swiper-container-reg {
			position: absolute;
			width: 500px;
			height: 200px;
			left: -110px;
			top: 45px;
		}

		.swiper-container-reg-cpy {
			position: absolute;
			width: 500px;
			height: 200px;
			left: -100px;
			top: 45px;
		}

		.swiper-slide {
			text-align: center;
			display: -webkit-box;
			display: -webkit-flex;
			display: flex;
			-webkit-box-pack: center;
			-webkit-justify-content: center;
			justify-content: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
		}

		.swiper-container-ver {
			top: 0px;
			left: 0px;
			position: absolute;
		}

		.swiper-container-hor {
			top: 0px;
			left: 0px;
			position: absolute;
		}

		.swiper-container-par {
			top: 0px;
			left: 0px;
			position: absolute;
		}

		#vertical-frame {
			opacity:0.5;
			border-style:solid;
			width:270px;
			height:270px;
			border-width:1px;
			border-radius: 10px;
			border:1px solid rgba(0,0,0,.2);
			background:rgba(0,0,0,.25);
		}

		#horizontal-frame {
			opacity:1;
			border-style:solid;
			width:240px;
			height:240px;
			border-width:1px;
			border-radius: 10px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div id="drag2" class="draggable block2">

			<!-- this is for the vertical container, which 
			shades up and down -->
			<div class="swiper-container swiper-container-ver">
				<div class="swiper-wrapper">
					<div class="swiper-slide stop-swiping">
						<div id="vertical-frame"></div>
					</div>
				</div>
			</div>

			<!-- this is for the border that glides horizontally -->
			<div class="swiper-container swiper-container-hor">
				<div class="swiper-wrapper">
					<div class="swiper-slide stop-swiping">
						<div id="horizontal-frame"></div>
					</div>
				</div>
			</div>

			<!-- this is for the actual pictures -->
			<div id="swiper-container-reg" class="swiper-container swiper-container-reg">
				<!-- NOTE: the pictures are repeated because they perfrom better
				like this, there used to be lag -->
				<div class="swiper-wrapper">
					<div class="swiper-slide stop-swiping sunny-icon">
						<img src="img/sunny.png">
					</div>
					<div class="swiper-slide stop-swiping cloudy-icon">
						<img src="img/cloudy2.png">
					</div>
					<div class="swiper-slide stop-swiping rainy-icon">
						<img src="img/rainy.png">
					</div>
					<div class="swiper-slide stop-swiping sunny-icon">
						<img src="img/sunny.png">
					</div>
					<div class="swiper-slide stop-swiping cloudy-icon">
						<img src="img/cloudy2.png">
					</div>
					<div class="swiper-slide stop-swiping rainy-icon">
						<img src="img/rainy.png">
					</div>
				</div>

				<!-- Add Arrows -->
				<!-- the logic for this can be found in swiper.css -->
				<div class="swiper-button-next"><i class="fa fa-chevron-right fa-2x"></i></div>
				<div class="swiper-button-prev"><i class="fa fa-chevron-left fa-2x"></i></div>
			</div>
		</div>
		""").appendTo ".block_bank_wrapper"


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

		interact(".swiper-button-prev").on 'tap', ->
			swiper_reg.slidePrev()
			swiper_ver.slidePrev()
			swiper_hor.slidePrev()

	run: (action)=>
		$active_weather = $ ".real-active-slide"
		return 'rainy' if $active_weather.hasClass 'rainy-icon'
		return 'cloudy' if $active_weather.hasClass 'cloudy-icon'
		return 'sunny' if $active_weather.hasClass 'sunny-icon'