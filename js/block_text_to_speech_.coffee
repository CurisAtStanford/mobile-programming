class @block_text_to_speech_

	constructor: ()->
		css = """
		#text_to_speech_input {
			top: 30px;
			left: 10px;
			width: 80px;
			font-size: 12px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="text_to_speech">
			SPEAK TO ME
			<input id="text_to_speech_input" type="text" name="image" value="Enter Text"><br>
		</div>
		""").appendTo ".drag-zone"


		@$input = $ "#text_to_speech_input"

		interact("#drag16")
		.on 'tap', (event) =>
			@$input.focus()

	run: ()=>
		console.log @$input.val()
		text = @$input.val()
		responsiveVoice.speak text