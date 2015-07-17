class @block_vibrate_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="vibrate">
			VIBRATE
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		window.navigator.vibrate([200,100,200]);