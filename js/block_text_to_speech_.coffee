class @block_text_to_speech_

	constructor: ()->
		css = """
		#text_field{
			font-size: 30px;
			text-align: center;
			position: absolute;
			top: -40px;
			left: 40px;
		}

		#text_to_speech_input {
			position: absolute;
			top: 150px;
			left: 40px;
			width: 200px;
			font-size: 25px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div class="">
			<div id="text_field">SPEAK TO ME</div>
			<input id="text_to_speech_input" type="text" name="image" value="Enter Text"><br>
		</div>
		""").appendTo ".block_bank_wrapper"


		@$input = $ "#text_to_speech_input"

		interact("#drag16")
		.on 'tap', (event) =>
			@$input.focus()


	
	run: ()=>
		console.log @$input.val()
		text = @$input.val()
		responsiveVoice.speak text