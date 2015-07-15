class @block_my_time_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id="drag8" class="draggable block1">MY TIME</div>
		""").appendTo ".block_bank_wrapper"

	run: ()=>
		moment().format 'HH:mm'