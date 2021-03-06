// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_orientation_ = (function() {
  function block_orientation_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"orientation\">\n	ORIENTATION\n</div>").appendTo(".drag-zone");
  }

  block_orientation_.prototype.run = function() {
    var POSITION_NAMES, checkMatchingPosition, get_desired_position, get_device_position;
    POSITION_NAMES = {
      TANNING: "Tanning",
      FACE_PLANT: "Face Plant",
      STANDING: "Standing",
      HEAD_STAND: "Head Stand",
      NAPPING: "Napping",
      OTHER_POS: "Other Position"
    };
    checkMatchingPosition = function() {
      var desired_position, device_position;
      console.log("In checkMatchingPosition");
      device_position = get_device_position();
      desired_position = get_desired_position();
      return device_position === desired_position;
    };
    get_device_position = function() {
      var position, tolerance;
      tolerance = 15;
      position = POSITION_NAMES.OTHER_POS;
      if (tiltLR >= -tolerance && tiltLR <= tolerance && tiltFB >= -tolerance && tiltFB <= tolerance) {
        position = POSITION_NAMES.TANNING;
      } else if (tiltLR >= -tolerance && tiltLR <= tolerance && tiltFB >= -tolerance - 180 && tiltFB <= tolerance - 180) {
        position = POSITION_NAMES.FACE_PLANT;
      } else if (tiltFB >= -tolerance + 90 && tiltFB <= tolerance + 90) {
        position = POSITION_NAMES.STANDING;
      } else if (tiltFB >= -tolerance - 90 && tiltFB <= tolerance - 90) {
        position = POSITION_NAMES.HEAD_STAND;
      } else if (((tiltLR >= -tolerance + 90 && tiltLR <= tolerance + 90) || (tiltLR >= -tolerance - 90 && tiltLR <= tolerance - 90)) && (tiltFB >= -tolerance && tiltFB <= tolerance)) {
        position = POSITION_NAMES.NAPPING;
      }
      console.log("get_device_position returns with " + position);
      return position;
    };
    get_desired_position = function() {
      var $active_position, position;
      console.log("In get_desired_position()");
      $active_position = $(".real-active-slide");
      position = null;
      if ($active_position.hasClass("tanning")) {
        position = POSITION_NAMES.TANNING;
      } else if ($active_position.hasClass("face_plant")) {
        position = POSITION_NAMES.FACE_PLANT;
      } else if ($active_position.hasClass("standing")) {
        position = POSITION_NAMES.STANDING;
      } else if ($active_position.hasClass("head_stand")) {
        position = POSITION_NAMES.HEAD_STAND;
      } else if ($active_position.hasClass("napping")) {
        position = POSITION_NAMES.NAPPING;
      } else {

      }
      position = POSITION_NAMES.OTHER_POS;
      console.log("get_desired_position returns with " + position);
      $("#messages").text(position);
      return position;
    };
    window.addEventListener('deviceorientation', (function(eventData) {
      var dir, tiltFB, tiltLR;
      tiltLR = eventData.gamma;
      tiltFB = eventData.beta;
      return dir = eventData.alpha;
    }), false);
    return console.log("End of startup");
  };

  return block_orientation_;

})();
