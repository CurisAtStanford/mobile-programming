// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_weather_ = (function() {
  function block_weather_() {
    this.run = bind(this.run, this);
    var css, swiper_hor, swiper_reg, swiper_ver;
    css = ".swiper-slide img {\n	width: 150px;\n	height: 150px;\n}\n\n.swiper-container {\n	width: 100%;\n	height: 100%;\n	margin-left: auto;\n	margin-right: auto;\n	position: relative;\n}\n\n.swiper-container-reg {\n	position: absolute;\n	width: 500px;\n	height: 200px;\n	left: -110px;\n	top: 45px;\n}\n\n.swiper-container-reg-cpy {\n	position: absolute;\n	width: 500px;\n	height: 200px;\n	left: -100px;\n	top: 45px;\n}\n\n.swiper-slide {\n	text-align: center;\n	display: -webkit-box;\n	display: -webkit-flex;\n	display: flex;\n	-webkit-box-pack: center;\n	-webkit-justify-content: center;\n	justify-content: center;\n	-webkit-box-align: center;\n	-webkit-align-items: center;\n	align-items: center;\n}\n\n.swiper-container-ver {\n	top: 0px;\n	left: 0px;\n	position: absolute;\n}\n\n.swiper-container-hor {\n	top: 0px;\n	left: 0px;\n	position: absolute;\n}\n\n.swiper-container-par {\n	top: 0px;\n	left: 0px;\n	position: absolute;\n}\n\n#vertical-frame {\n	opacity:0.5;\n	border-style:solid;\n	width:270px;\n	height:270px;\n	border-width:1px;\n	border-radius: 10px;\n	border:1px solid rgba(0,0,0,.2);\n	background:rgba(0,0,0,.25);\n}\n\n#horizontal-frame {\n	opacity:1;\n	border-style:solid;\n	width:240px;\n	height:240px;\n	border-width:1px;\n	border-radius: 10px;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div id=\"drag2\" class=\"draggable block2\">\n\n	<!-- this is for the vertical container, which \n	shades up and down -->\n	<div class=\"swiper-container swiper-container-ver\">\n		<div class=\"swiper-wrapper\">\n			<div class=\"swiper-slide stop-swiping\">\n				<div id=\"vertical-frame\"></div>\n			</div>\n		</div>\n	</div>\n\n	<!-- this is for the border that glides horizontally -->\n	<div class=\"swiper-container swiper-container-hor\">\n		<div class=\"swiper-wrapper\">\n			<div class=\"swiper-slide stop-swiping\">\n				<div id=\"horizontal-frame\"></div>\n			</div>\n		</div>\n	</div>\n\n	<!-- this is for the actual pictures -->\n	<div id=\"swiper-container-reg\" class=\"swiper-container swiper-container-reg\">\n		<!-- NOTE: the pictures are repeated because they perfrom better\n		like this, there used to be lag -->\n		<div class=\"swiper-wrapper\">\n			<div class=\"swiper-slide stop-swiping sunny-icon\">\n				<img src=\"img/sunny.png\">\n			</div>\n			<div class=\"swiper-slide stop-swiping cloudy-icon\">\n				<img src=\"img/cloudy2.png\">\n			</div>\n			<div class=\"swiper-slide stop-swiping rainy-icon\">\n				<img src=\"img/rainy.png\">\n			</div>\n			<div class=\"swiper-slide stop-swiping sunny-icon\">\n				<img src=\"img/sunny.png\">\n			</div>\n			<div class=\"swiper-slide stop-swiping cloudy-icon\">\n				<img src=\"img/cloudy2.png\">\n			</div>\n			<div class=\"swiper-slide stop-swiping rainy-icon\">\n				<img src=\"img/rainy.png\">\n			</div>\n		</div>\n\n		<!-- Add Arrows -->\n		<!-- the logic for this can be found in swiper.css -->\n		<div class=\"swiper-button-next\"><i class=\"fa fa-chevron-right fa-2x\"></i></div>\n		<div class=\"swiper-button-prev\"><i class=\"fa fa-chevron-left fa-2x\"></i></div>\n	</div>\n</div>").appendTo(".block_bank_wrapper");
    swiper_reg = new Swiper('.swiper-container-reg', {
      pagination: '.swiper-pagination',
      nextButton: '.swiper-button-next',
      prevButton: '.swiper-button-prev',
      effect: 'coverflow',
      slideActiveClass: 'fake-active-slide',
      slideNextClass: 'real-active-slide',
      noSwiping: true,
      noSwipingClass: 'stop-swiping',
      slidesPerView: 3,
      spaceBetween: 30,
      speed: 800,
      loop: true,
      coverflow: {
        rotate: 50,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows: false
      }
    });
    swiper_ver = new Swiper('.swiper-container-ver', {
      noSwiping: true,
      noSwipingClass: 'stop-swiping',
      effect: 'coverflow',
      slidesPerView: 1,
      spaceBetween: 30,
      loop: true,
      direction: 'vertical',
      speed: 800,
      coverflow: {
        rotate: 50,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows: false
      }
    });
    swiper_hor = new Swiper('.swiper-container-hor', {
      effect: 'coverflow',
      noSwiping: true,
      noSwipingClass: 'stop-swiping',
      slidesPerView: 1,
      spaceBetween: 30,
      speed: 800,
      loop: true,
      coverflow: {
        rotate: 50,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows: false
      }
    });
    interact(".swiper-button-next").on('tap', function() {
      swiper_reg.slideNext();
      swiper_ver.slideNext();
      return swiper_hor.slideNext();
    });
    interact(".swiper-button-prev").on('tap', function() {
      swiper_reg.slidePrev();
      swiper_ver.slidePrev();
      return swiper_hor.slidePrev();
    });
  }

  block_weather_.prototype.run = function(action) {
    var $active_weather;
    $active_weather = $(".real-active-slide");
    if ($active_weather.hasClass('rainy-icon')) {
      return 'rainy';
    }
    if ($active_weather.hasClass('cloudy-icon')) {
      return 'cloudy';
    }
    if ($active_weather.hasClass('sunny-icon')) {
      return 'sunny';
    }
  };

  return block_weather_;

})();
