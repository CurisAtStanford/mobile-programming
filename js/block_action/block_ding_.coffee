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

	run: (cb, element)=>
		audio = new Audio "sound/Ding.mp3"
		$(audio).bind 'ended', ->
			console.log "FINSIHED AUDIO"
			cb()
		audio.play()