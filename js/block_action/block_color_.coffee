class @block_color_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="color">
			<input id="text_input" type="color" value="simple color" name="image"/>
		</div>
		""").appendTo ".drag-zone"

	run: (cb)=>
		$("body").css
			backgroundColor: $("#text_input").val()

		cb()