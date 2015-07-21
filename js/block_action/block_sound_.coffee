class @block_sound_

	constructor: ()->
		css = """
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="sound-block" class="drag-wrap draggable" name="sound">
			<div id="ding-icon">
				<img src="img/bell.png">
			</div>
			<div id="siren-icon">
				<img src="img/siren.png">
			</div>
			<div id="drum-icon">
				<img src="img/drum.png">
			</div>
		</div>
		""").appendTo ".drag-zone"

		@sound_block = new block_animation_ "sound-block"


	run: (cb, element)=>
		active = @sound_block.get_active_slide()
		if active is 'ding-icon'
			audio = new Audio "sound/Ding.mp3"
			$(audio).bind 'ended', ->
				cb()
			audio.play()
		else if active is 'siren-icon'
			audio = new Audio "sound/Siren.mp3"
			$(audio).bind 'ended', ->
				cb()
			audio.play()
		else if active is 'drum-icon'
			audio = new Audio "sound/drum-fill.mp3"
			$(audio).bind 'ended', ->
				cb()
			audio.play()
		else
			console.log 'error - no active icon'