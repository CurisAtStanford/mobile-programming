// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_instagram_ = (function() {
  function block_instagram_() {
    this.run = bind(this.run, this);
    var css, feed;
    css = "#instagram_pic {\n	position: absolute;\n	left: 18px;\n	top: 16px;\n	width: 80px;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"instagram\">\n	<img id=\"instagram_pic\" src=\"img/instagram.png\">\n</div>\n<div id=\"instafeed\"></div>").appendTo(".drag-zone");
    feed = new Instafeed({
      get: 'tagged',
      tagName: 'awesome',
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

  block_instagram_.prototype.run = function() {
    return this.images;
  };

  return block_instagram_;

})();
