class @block_text_

	constructor: ()->
		css = """
		#text_field{
			font-size: 90px;
			position: absolute;
			top: -40px;
			left: 30px;
		}

		#text_input {
			position: absolute;
			top: 150px;
			left: 40px;
			width: 200px;
			font-size: 25px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="drag11" class="draggable block2">
			<div id="text_field">TEXT</div>
			<input id="text_input" type="text" name="image" ><br>
		</div>
		""").appendTo ".block_bank_wrapper"

		interact("#drag11")
		.on 'tap', (event) ->
			$("#text_input").focus()

	run: ()=>
		console.log $("#text_input").val()
		$("#text_input").val()