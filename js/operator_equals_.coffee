class @operator_equals_

	constructor: ()->
		# css = """
		# """
		# $("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag3' class='draggable operator'>==</div>
		""").appendTo ".block_zone"

	run: ()=>

