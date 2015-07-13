// Generated by CoffeeScript 1.6.2
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_youtube_ = (function() {
  function block_youtube_() {
    this.run = __bind(this.run, this);
    var css, extract_video_id,
      _this = this;

    css = "#youtube_pic{\n	position: absolute;\n	left:0px;\n	top: 0px;\n}\n\n#youtube_input {\n	position: absolute;\n	top: 150px;\n	left: 40px;\n	width: 200px;\n	font-size: 25px;\n}\n\n#youtube_player {\n	position: absolute;\n	top: 0px;\n	left: 0px;\n	width: 100%;\n	height: 100%;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div id=\"drag9\" class=\"draggable block3\">\n		<div id=\"youtube_player\"></div>\n		<img id=\"youtube_pic\" src=\"img/youtube-logo.png\">\n		<input id=\"youtube_input\" type=\"text\">\n</div>").appendTo(".block_bank_wrapper");
    interact("#drag9").on('tap', function(event) {
      return $("#youtube_input").focus();
    });
    extract_video_id = function(url) {
      var match;

      match = url.match(/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/);
      if (match && match[7].length === 11) {
        return match[7];
      } else {
        return alert("Could not extract video ID.");
      }
    };
    $("#youtube_input").on('input propertychange', function(event) {
      var youtube_url;

      youtube_url = $("#youtube_input").val();
      _this.youtube_id = extract_video_id(youtube_url);
      $("#youtube_input").remove();
      $("#youtube_pic").remove();
      return $("#drag9").css({
        backgroundImage: "url(https://i1.ytimg.com/vi/" + _this.youtube_id + "/default.jpg)",
        backgroundSize: 'cover',
        backgroundRepeat: 'no-repeat',
        backgroundPosition: 'center center'
      });
    });
  }

  block_youtube_.prototype.run = function() {};

  return block_youtube_;

})();
