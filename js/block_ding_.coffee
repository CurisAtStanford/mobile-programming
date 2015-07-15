class @block_ding_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""

		<div class="drag-wrap draggable" name="ding">
			DING
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		audio = new Audio "sound/Ding.mp3"
		audio.play()