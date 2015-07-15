class @block_my_location_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag1' class='draggable block1'>MY LOCATION</div>
		""").appendTo ".block_bank_wrapper"

	run: ()=>
