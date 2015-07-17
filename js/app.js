// Generated by CoffeeScript 1.9.3
$(function() {
  var commands, control, images, put_text_in_block, startPos, swiper_hor, swiper_reg, swiper_ver;
  window.block_time = new block_time_();
  window.block_array = new block_array_();
  window.block_ding = new block_ding_();
  window.block_siren = new block_siren_();
  window.block_true = new block_true_();
  window.block_display_image = new block_display_image_();
  window.block_display_text = new block_display_text_();
  window.block_map = new block_map_();
  window.block_instagram = new block_instagram_();
  window.block_camera = new block_camera_();
  window.block_text_to_speech = new block_text_to_speech_();
  window.block_taylorswift = new block_taylorswift_();
  window.block_selenagomez = new block_selenagomez_();
  window.block_kimkardashian = new block_kimkardashian_();
  window.block_beyonce = new block_beyonce_();
  window.block_drake = new block_drake_();
  window.block_rihanna = new block_rihanna_();
  images = {
    one: 1,
    two: 2,
    three: 3,
    four: 4
  };
  async.forEachOfSeries(images, function(key, value, cb) {
    console.log(key);
    console.log(value);
    wait(1000, (function(_this) {
      return function() {
        return cb();
      };
    })(this));
  }, function(err) {
    return console.log('iterating done');
  });
  control = new control_if_then_();
  startPos = null;
  interact('.draggable').draggable({
    snap: {
      targets: [startPos],
      relativePoints: [
        {
          x: 0.5,
          y: 0.5
        }
      ],
      range: 200,
      endOnly: true
    },
    onstart: function(event) {
      var rect;
      rect = interact.getElementRect(event.target);
      startPos = {
        x: rect.left + rect.width / 2,
        y: rect.top + rect.height / 2
      };
      return event.interactable.draggable({
        snap: {
          targets: [startPos],
          range: 200
        }
      });
    },
    onmove: function(event) {
      var $target, x, y;
      $target = $(event.target);
      x = (parseFloat($target.attr('data-x')) || 0) + event.dx;
      y = (parseFloat($target.attr('data-y')) || 0) + event.dy;
      $target.css({
        '-webkit-transform': "translate(" + x + "px, " + y + "px)"
      });
      $target.attr('data-x', x);
      $target.attr('data-y', y);
      return $target.addClass('getting--dragged');
    },
    onend: function(event) {
      var $target;
      $target = $(event.target);
      return $target.removeClass('getting--dragged');
    }
  });
  put_text_in_block = function(text, block_name) {
    return $("#" + block_name).val(text);
  };
  commands = {
    'put *text in :block_name block': put_text_in_block,
    'run': control.run
  };
  annyang.addCommands(commands);
  annyang.start({
    continuous: true
  });
  $("#button_run").click((function(_this) {
    return function() {
      return control.run();
    };
  })(this));
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
    swiper_hor.slideNext();
    return console.log("BOOM");
  });
  return interact(".swiper-button-prev").on('tap', function() {
    swiper_reg.slidePrev();
    swiper_ver.slidePrev();
    swiper_hor.slidePrev();
    return console.log("BAM");
  });
});
