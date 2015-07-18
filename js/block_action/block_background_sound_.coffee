class @block_background_image_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="background_image">
			<input id="background_image_input" type="text""/>
		</div>
		""").appendTo ".drag-zone"

		interact("[name=background_image]")
		.on 'tap', (event) ->
			$("#background_image_input").focus()

	run: (cb)=>
		url = $("#background_image_input").val()
		$("body").css
			backgroundImage: "url(#{url})"
			backgroundSize: 'cover'
			backgroundPosition: 'center'
			backgroundColor: 'white'

		cb()