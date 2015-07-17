class @draggable_control_for_loop_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="forloop">
			FOR LOOP
		</div>
		""").appendTo ".drag-zone"

	run: ()=>