class @block_text_to_speech_

	constructor: ()->
		css = """
		#text_to_speech_input {
			position: absolute;
			top: 60%;
			width: 90%;
			left: 5%;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="text_to_speech">
			SPEAK TO ME
			<input id="text_to_speech_input" value="ENTER TEXT">
		</div>
		""").appendTo ".drag-zone"

		@$input = $ "#text_to_speech_input"

		interact("[name=text_to_speech]")
		.on 'tap', (event) =>
			@$input.val ""
			@$input.focus()

	run: (cb)=>
		text = @$input.val()
		responsiveVoice.speak text

		cb()