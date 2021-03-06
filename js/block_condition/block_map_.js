// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_map_ = (function() {
  function block_map_() {
    this.run = bind(this.run, this);
    var css, get_rectangle_coords;
    css = "#google_map{\n	width: 100px;\n	height: 100px;\n	left: 7px;\n	top: 7px;\n	line-height: 0px;\n	border-radius: 50%\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"map\">\n	<div id='google_map'></div>\n</div>").appendTo(".drag-zone");
    $("#google_map").bind('touchstart mousedown', function() {
      return $("#google_map").parent().removeClass("draggable").addClass("not_draggable");
    });
    $("body").bind('touchend mouseup', function() {
      return $("#google_map").parent().removeClass("not_draggable").addClass("draggable");
    });
    get_rectangle_coords = (function(_this) {
      return function(bounds) {
        var northEast, northEastLat, northEastLng, northWestLat, northWestLng, southEastLat, southEastLng, southWest, southWestLat, southWestLng;
        northEast = bounds.getNorthEast();
        southWest = bounds.getSouthWest();
        southWestLat = southWest.lat();
        southWestLng = southWest.lng();
        northEastLat = northEast.lat();
        northEastLng = northEast.lng();
        southEastLat = northEast.lat();
        southEastLng = southWest.lng();
        northWestLng = northEast.lng();
        northWestLat = southWest.lat();
        return [new google.maps.LatLng(southWestLat, southWestLng), new google.maps.LatLng(northWestLat, northWestLng), new google.maps.LatLng(northEastLat, northEastLng), new google.maps.LatLng(southEastLat, southEastLng)];
      };
    })(this);
    google.maps.event.addDomListener(window, 'load', (function(_this) {
      return function() {
        return navigator.geolocation.getCurrentPosition(function(position) {
          var map_prop;
          _this.my_lat = position.coords.latitude;
          _this.my_lng = position.coords.longitude;
          map_prop = {
            center: new google.maps.LatLng(_this.my_lat, _this.my_lng),
            zoom: 17,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true,
            minZoom: 17,
            maxZoom: 17
          };
          return _this.map = new google.maps.Map(document.getElementById("google_map"), map_prop);
        });
      };
    })(this));
  }

  block_map_.prototype.run = function() {
    return true;
  };

  return block_map_;

})();
