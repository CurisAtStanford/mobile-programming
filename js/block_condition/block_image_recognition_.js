// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_image_recognition_ = (function() {
  function block_image_recognition_() {
    this.run = bind(this.run, this);
    var $image_input, css;
    css = "#image_pic {\n	position: absolute;\n	width: 140px;\n	top: 30px;\n	left: 70px;\n	height: 100px;\n}\n#image_input {\n	position: absolute;\n	top: 150px;\n	left: 40px;\n	width: 200px;\n	font-size: 25px;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div id=\"drag10\" class=\"draggable block1\">\n	<img src = \"img/image_placeholder.png\" id=\"image_pic\">\n	<input id=\"image_input\" type=\"text\" name=\"image\" >\n</div>").appendTo(".block_bank_wrapper");
    $image_input = $("#image_input");
    interact("#drag10").on('tap', function(event) {
      return $("#image_input").focus();
    });
    $image_input.on('input propertychange', (function(_this) {
      return function(event) {
        _this.image_url = $image_input.val();
        $("#drag10").css({
          backgroundImage: "url(" + _this.image_url + ")",
          backgroundSize: 'cover'
        });
        $image_input.remove();
        $("#image_pic").remove();
        return $.ajax({
          url: "https://api.clarifai.com/v1/tag/?url=" + encodeURI(_this.image_url),
          headers: {
            Authorization: "Bearer 80mKPxFRKzN2APnVMJJGnOMRxHLiRj"
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
            return alert("error");
          },
          success: function(json, textStatus, z) {
            var NMAX_TAGS, top_probs;
            NMAX_TAGS = 5;
            _this.top_tags = json.results[0].result.tag.classes.slice(0, NMAX_TAGS);
            return top_probs = json.results[0].result.tag.probs.slice(0, NMAX_TAGS);
          }
        });
      };
    })(this));
  }

  block_image_recognition_.prototype.run = function() {
    return this.top_tags;
  };

  return block_image_recognition_;

})();
