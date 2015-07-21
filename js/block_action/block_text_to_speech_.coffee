class @block_text_to_speech_

	constructor: ()->
		css = """
		#speak_pic {
			position: absolute;
			width: 40%;
			top: 3%;
			left: 28%;
			opacity: 0.2;
		}

		#speak_text {
			position: absolute;
			top: 10%;
			left: 13%;
		}

		#text_to_speech_input {
			position: absolute;
			top: 60%;
			width: 80%;
			left: 6%;
			text-align: center;
			font-size: 11px;
			background: #ACF0F2;
			opacity: 0.4;
		}

		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="text_to_speech">
			<img id="speak_pic" src="img/speak.png">
			<div id="speak_text">SPEAK TO ME</div>
			<input id="text_to_speech_input" type="text" value="TEXT">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=text_to_speech]")
		.on 'tap', (event) =>
			$("#text_to_speech_input").val ""
			$("#text_to_speech_input").focus()

	run: (cb)=>
		text =$("#text_to_speech_input").val()
		responsiveVoice.speak text

		cb()