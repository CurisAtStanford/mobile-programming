class @block_background_image_

	constructor: ()->
		css = """
		#background_image_input {
			position: absolute;
			top: 55%;
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
		<div class="drag-wrap draggable" name="background_image">
			BACKGROUND
			<input id="background_image_input" type="text" value="IMAGE URL">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=background_image]")
		.on 'tap', (event) =>
			$("#background_image_input").val ""
			$("#background_image_input").focus()

	run: (cb)=>
		url = $("#background_image_input").val()
		$("body").css
			backgroundImage: "url(#{url})"
			backgroundSize: 'cover'
			backgroundPosition: 'center'
			backgroundColor: 'white'

		cb()