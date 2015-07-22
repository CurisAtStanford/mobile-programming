// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_spotify_ = (function() {
  function block_spotify_() {
    this.run = bind(this.run, this);
    var css;
    css = "#youtube_celeb {\n	background-image: url(img/spotify.png);\n	background-size: cover;\n}\n\n#spotify_input {\n	position: absolute;\n	top: 50px;\n	left: 10px;\n	right: 10px;\n	width: 80%;\n	text-align: center;\n	font-size: 10px;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id=\"youtube_celeb\" class=\"drag-wrap draggable\" name=\"spotify\">\n	<input id=\"spotify_input\" type=\"text\">\n	<div id=\"video_frame\"></div>\n</div>").appendTo(".drag-zone");
    interact("#spotify_input").on('tap', function(event) {
      return $("#spotify_input").focus();
    });
    this.track = "";
    this.image = null;
    this.entries = [];
    $("#spotify_input").on('input propertychange', (function(_this) {
      return function(event) {
        var artist;
        artist = $("#spotify_input").val();
        return $.ajax({
          url: "https://api.spotify.com/v1/search?q=" + artist + "&type=track",
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR);
            console.log(textStatus);
            return console.log(errorThrown);
          },
          success: function(json, textStatus, z) {
            _this.entries = json.tracks.items;
            _this.track = json.tracks.items[0];
            return _this.image = _this.track.album.images[0].url;
          }
        });
      };
    })(this));
  }

  block_spotify_.prototype.run = function(element) {
    $("#spotify_input").hide();
    console.log(this.track);
    $("#youtube_celeb").html("<img style='width: 115px; height: 115px' src=" + this.image + ">");

    /*audio = new Audio()
    		console.log @track.preview_url
    		audio.src = @track.preview_url
    		audio.play()
     */
    return this.entries;
  };

  return block_spotify_;

})();
