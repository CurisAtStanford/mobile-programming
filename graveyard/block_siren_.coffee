class @block_siren_

	constructor: ()->
		css = """
		#siren-image {
			position: relative;
			width: 40%;
			top: 20%;
		}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="siren">
			<img id="siren-image" src="img/siren.png">
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		audio = new Audio "sound/Siren.mp3"
		$(audio).bind 'ended', ->
			console.log "FINSIHED AUDIO"
			cb()
		audio.play()