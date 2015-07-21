class @draggable_control_if_then_

	constructor: ()->
		css = """
		#this-drop-zone {
				left: 25px;
			}
		#then-text {
				left: 115px;
			}
		#that-drop-zone {
				left: 200px;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="ifthen">
			IF THEN BLOCK
			<div id='if-text' class='text'>IF</div>
			<div id='this-drop-zone' class='droppable steps droppable-#{@counter_id}' role='condition'>THIS</div>
			<div id='then-text' class='text'>THEN</div>
			<div id='that-drop-zone' class='droppable steps droppable-#{@counter_id}' role='action'>THAT</div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>