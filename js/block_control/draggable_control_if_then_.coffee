class @draggable_control_if_then_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="ifthen">
			IF THEN BLOCK
			<!--<div id='if' class="text" >IF</div>
			<div id='block1' class="dropzone">BLOCK1</div>
			<div id='operator' class="dropzone">________</div>
			<div id='block2' class='dropzone'>BLOCK2</div>
			<div id='then' class='text'>THEN</div>
			<div id='block3' class='dropzone'>DO THIS</div>-->
		</div>
		""").appendTo ".drag-zone"

	run: ()=>