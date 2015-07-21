class @block_true_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="true">
			TRUE
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		cb true
