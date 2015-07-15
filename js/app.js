// Generated by CoffeeScript 1.9.3
var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

$(function() {
  var BUZZ, IS_IN, IS_NOT_IN, MAP, MY_AREA, MY_ARRAY, MY_IMAGE, MY_LOCATION, MY_TEXT, MY_TIME, MY_WEATHER, SIREN, TIME, WEATHER, YOUTUBE, block_ids, block_instagram, control_if_then, for_loop, if_condition, run;
  window.global_block_width = window.global_block_height = 290;
  block_instagram = new block_instagram_();
  control_if_then = new control_for_loop();

  /*
  	triggers is a JS object broken up like the following:
  	first: the first condition given
  	operator: the type of operator
  	second: second condition given
  	action: thing to do next
   */
  IS_IN = 6;
  IS_NOT_IN = 7;
  MY_AREA = 0;
  MY_LOCATION = 1;
  WEATHER = 2;
  run = (function(_this) {
    return function(triggers, action) {
      var array, element, i, len, list, results;
      console.log("Got in run");
      if (for_loop === false) {
        return if_condition(triggers, action);
      } else {
        array = triggers.array;
        if (array === MY_ARRAY) {
          console.log("BOOOYAAAH");
          list = block_array_test.run();
          results = [];
          for (i = 0, len = list.length; i < len; i++) {
            element = list[i];
            console.log("HERE");
            console.log(element);
            results.push(if_condition(triggers, action));
          }
          return results;
        }
      }
    };
  })(this);
  if_condition = function(triggers, action) {
    var first_block, my_weather, operator, second_block, tags, text, weather;
    console.log("TRIGGERS");
    console.log(triggers.first_block);
    console.log(triggers.second_block);
    console.log(triggers.operator);
    if ((triggers.first_block === void 0) || (triggers.first_block === null)) {
      action();
    }
    first_block = triggers.first_block;
    operator = triggers.operator;
    second_block = triggers.second_block;
    if ((first_block === MY_TIME && second_block === TIME) || (first_block === TIME && second_block === MY_TIME)) {
      if (block_time.run() === block_my_time.run()) {
        return action();
      }
    } else if ((first_block === MY_IMAGE && second_block === MY_TEXT) || (first_block === MY_TEXT && second_block === MY_IMAGE)) {
      tags = block_image_recognition.run();
      text = block_my_text.run();
      if (indexOf.call(tags, text) >= 0) {
        return action();
      }
    } else if ((first_block === MY_WEATHER && second_block === WEATHER) || (first_block === WEATHER && second_block === MY_WEATHER)) {
      weather = block_weather.run();
      my_weather = block_my_weather.run();
      if (weather === my_weather) {
        return action();
      }
    } else if ((first_block === MY_LOCATION && second_block === MY_AREA) || (first_block === MY_AREA && second_block === MY_LOCATION)) {
      console.log("GOT IN HERE WHICH IS COOL");
      return block_map.run(action);
    }
  };
  MAP = 3;
  BUZZ = 4;
  SIREN = 10;
  TIME = 8;
  MY_TIME = 9;
  MY_IMAGE = 100;
  MY_TEXT = 150;
  MY_WEATHER = 12;
  YOUTUBE = 120;
  MY_ARRAY = 11;
  block_ids = {
    drag1: MY_LOCATION,
    drag2: WEATHER,
    drag3: IS_IN,
    drag4: BUZZ,
    drag5: MY_AREA,
    drag6: SIREN,
    drag7: TIME,
    drag8: MY_TIME,
    drag9: YOUTUBE,
    drag10: MY_IMAGE,
    drag11: MY_TEXT,
    drag15: MY_WEATHER,
    drag16: MY_ARRAY
  };
  $("#reset").click((function(_this) {
    return function() {
      return location.reload();
    };
  })(this));
  for_loop = true;
  return $("#run").click((function(_this) {
    return function() {
      var action, cur_id, element, elements_in_environment, first_block_accounted_for, i, len, triggers;
      triggers = {};
      action = null;
      console.log("GOT IN HERE BITCHES");
      elements_in_environment = $(".drop_over.draggable");
      first_block_accounted_for = false;
      for (i = 0, len = elements_in_environment.length; i < len; i++) {
        element = elements_in_environment[i];
        cur_id = element.id;
        if (cur_id === "drag3") {
          triggers.operator = block_ids[cur_id];
        } else if (cur_id === "drag4") {
          action = block_ding.run;
        } else if (cur_id === "drag6") {
          action = block_siren.run;
        } else if (cur_id === "drag13") {
          action = block_camera.run;
        } else if (cur_id === "drag9") {
          action = block_youtube.run;
        } else if (cur_id === "drag16") {
          triggers.array = block_ids[cur_id];
        } else {
          if (first_block_accounted_for === !true) {
            first_block_accounted_for = true;
            triggers.first_block = block_ids[cur_id];
          } else {
            console.log("hello");
            console.log("cur_id " + cur_id);
            triggers.second_block = block_ids[cur_id];
          }
        }
      }
      console.log(triggers);
      console.log(action);
      return run(triggers, action);
    };
  })(this));
});
