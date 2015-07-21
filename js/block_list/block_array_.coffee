class @block_array_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="array">
			ARRAY [1, 2, 3, 4]
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		['yas', 'hey', 'yo', 'swag']