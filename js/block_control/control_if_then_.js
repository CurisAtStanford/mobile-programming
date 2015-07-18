// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.control_if_then_ = (function() {
  function control_if_then_($target) {
    this.run = bind(this.run, this);
    var append_to_this, css;
    css = "		";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    append_to_this = null;
    if ($target != null) {
      append_to_this = $target;
    } else {
      append_to_this = '.drop-zone';
    }
    console.log(append_to_this);
    this.counter_id = window.counter;
    window.counter = this.counter_id + 1;
    $("<div class='text'>IF</div>\n<div class='droppable steps droppable-" + this.counter_id + "' role='condition'>THIS</div>\n<div class='text'>THEN</div>\n<div class='droppable steps droppable-" + this.counter_id + "' role='action'>THAT</div>").appendTo(append_to_this);
    this.spot_filled = [false, false];
    console.log("Got em in $target");
    interact(".droppable-" + this.counter_id).dropzone({
      accept: '.draggable',
      overlap: .1,
      ondropactivate: function(event) {
        $target = $(event.target);
        return $target.addClass('can--drop');
      },
      ondragenter: function(event) {
        var $draggableElement, dropCenter, dropRect, dropzoneElement;
        $draggableElement = $(event.relatedTarget);
        dropzoneElement = event.target;
        dropRect = interact.getElementRect(dropzoneElement);
        dropCenter = {
          x: dropRect.left + dropRect.width / 2,
          y: dropRect.top + dropRect.height / 2
        };
        event.draggable.draggable({
          snap: {
            targets: [dropCenter]
          }
        });
        dropzoneElement.classList.add('can--catch');
        return $draggableElement.addClass('drop--me');
      },
      ondragleave: function(event) {
        var $relatedTarget;
        $target = $(event.target);
        $relatedTarget = $(event.relatedTarget);
        $target.removeClass('can--catch');
        $relatedTarget.removeClass('caught--it');
        return $relatedTarget.removeClass('drop--me');
      },
      ondrop: (function(_this) {
        return function(event) {
          var $related_target, block_name;
          $target = $(event.target);
          $related_target = $(event.relatedTarget);

          /* This checks to see if there's a duplicate */
          if ($target.attr('role') === 'condition') {
            console.log("condition dropped");
            block_name = $related_target.attr("name");
            _this.condition = window["block_" + block_name];
          }
          if ($target.attr('role') === 'action') {
            console.log("action dropped");
            block_name = $related_target.attr("name");
            if (block_name === "ifthen") {
              _this.transform_action_area($target, $related_target, false);
            } else if (block_name === "forloop") {
              _this.transform_action_area($target, $related_target, true);
            } else {
              _this.action = window["block_" + block_name];
            }
          }
          $target.attr("filled", "true");
          $target.addClass('caught--it');
          return $related_target.removeClass('drag-wrap');
        };
      })(this),
      ondropdeactivate: function(event) {
        $target = $(event.target);
        return $target.removeClass('can--drop', 'can--catch');
      }
    });
  }

  control_if_then_.prototype.transform_action_area = function($target, $block, isLoop) {
    var control_condition;
    $block.remove();
    $target.html(" ");
    $target.removeClass();
    $target.css({
      "width": "auto",
      "height": "auto"
    });
    $target.attr({
      "role": "whatever"
    });
    control_condition = null;
    if (isLoop) {
      console.log("Is a for loop");
      control_condition = new control_for_loop_($target);
      new draggable_control_for_loop_();
    } else {
      console.log("Is an if condition");
      control_condition = new control_if_then_($target);
      new draggable_control_if_then_();
    }
    return this.action = control_condition;
  };

  control_if_then_.prototype.run = function(outer_cb, element) {
    if (this.condition.run()) {
      console.log("Running");
      console.log(this.action);
      return this.action.run(outer_cb, element);
    } else {
      if (outer_cb != null) {
        return outer_cb();
      }
    }
  };

  return control_if_then_;

})();
