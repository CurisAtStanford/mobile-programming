// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_selenagomez_ = (function() {
  function block_selenagomez_() {
    this.run = bind(this.run, this);
    var css, feed, selenagomez;
    css = "#instafeed {\n	display: none;\n}\n#selena-image {\n	height:110%;\n	position: relative;\n	left: -60px;\n	bottom:0;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"selenagomez\">\n	<img id=\"selena-image\" src=\"img/selenagomez.jpg\">\n	<div id=\"instafeed\"></div>\n</div>").appendTo(".drag-zone");
    selenagomez = 460563723;
    feed = new Instafeed({
      get: 'user',
      userId: selenagomez,
      accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
      clientId: 'f41df43206564056b252ae8a5cb4019e',
      error: function() {
        return console.log("instagram error");
      },
      success: (function(_this) {
        return function(json) {
          return _this.images = json.data;
        };
      })(this)
    });
    feed.run();
  }

  block_selenagomez_.prototype.run = function() {
    var audio;
    audio = new Audio("sound/goodforyou.mp3");
    audio.play();
    return this.images;
  };

  return block_selenagomez_;

})();