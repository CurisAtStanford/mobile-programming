class @block_ding_

	constructor: ()->
		css = """
		#ding-image {
			position: relative;
			width: 50%;
			top: 20%;
		}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="ding">
			<img id="ding-image" src="img/bell.png">
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		console.log "DING run"
		audio = new Audio "sound/Ding.mp3"
		$(audio).bind 'ended', ->
			console.log "FINSIHED AUDIO"
			cb()
		audio.play()