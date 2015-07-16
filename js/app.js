// Generated by CoffeeScript 1.6.2
$(function() {
  var control, startPos,
    _this = this;

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
  control = new control_for_loop_();
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
  return $("#button_run").click(function() {
    return control.run();
  });
});
