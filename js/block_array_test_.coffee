class @block_array_test_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag16' class='draggable block4'>ARRAY_TEST</div>
		""").appendTo ".block_bank_wrapper"

	run: ()=>
		[31, 32, 33, 34, 36, 69, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]