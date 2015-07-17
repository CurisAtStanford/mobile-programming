class @block_siren_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="siren">
			SIREN
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		audio = new Audio "sound/Siren.mp3"
		$(audio).bind 'ended', ->
			console.log "FINSIHED AUDIO"
			cb()
		audio.play()