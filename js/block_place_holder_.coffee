class @block_place_holder_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="extra">
			TBD
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		alert "Place holder block, no run function!"
		console.log "Place holder block, no run function"