// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_array_ = (function() {
  function block_array_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable\" name=\"array\">\n	ARRAY [1, 2, 3, 4]\n</div>").appendTo(".drag-zone");
  }

  block_array_.prototype.run = function() {
    return ['yas', 'hey', 'yo', 'swag'];
  };

  return block_array_;

})();
