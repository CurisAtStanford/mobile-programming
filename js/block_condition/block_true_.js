// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_true_ = (function() {
  function block_true_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"true\">\n	TRUE\n</div>").appendTo(".drag-zone");
  }

  block_true_.prototype.run = function(cb, element) {
    return cb(true);
  };

  return block_true_;

})();
