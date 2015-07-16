// Generated by CoffeeScript 1.6.2
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_camera_ = (function() {
  function block_camera_() {
    this.run = __bind(this.run, this);
    var css,
      _this = this;

    css = "#camera_video {\n	left: -47px;\n	transform: scaleX(-1);\n	# widt: scaleX(-1);\n}\n\n#camera_photo {\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"camera\">\n	<video id='camera_video' autoplay>Video stream not available.</video>\n	<canvas id='camera_canvas'></canvas>\n	<img id='camera_photo'>\n</div>").appendTo(".drag-zone");
    this.video = $("#camera_video")[0];
    this.photo = $('#camera_photo')[0];
    this.canvas = $("#camera_canvas")[0];
    this.canvas.width = 385;
    this.canvas.height = 290;
    this.context = this.canvas.getContext('2d');
    navigator.getMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
    navigator.getMedia({
      video: true,
      audio: false
    }, function(stream) {
      return _this.video.src = window.URL.createObjectURL(stream);
    }, function(error) {
      console.log('Camera blocked - the following error occurred: ' + error);
    });
  }

  block_camera_.prototype.run = function() {
    var data;

    this.context.drawImage(this.video, 0, 0, 385, 290);
    data = this.canvas.toDataURL('image/png');
    return this.photo.setAttribute('src', data);
  };

  return block_camera_;

})();
