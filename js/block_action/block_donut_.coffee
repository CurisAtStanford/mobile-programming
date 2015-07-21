class @block_donut_

	constructor: ()->
		css = """
			#drag_donut {
				background-image: url(img/dunkin-donuts.jpg);
				background-size: cover;

			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="drag_donut" class="drag-wrap draggable" name="donut">
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		window.open "http://shop.dunkindonuts.com/coffee-k-cup_1997-4294959632_p01_01/#url=%2Fall_4294959632_p01_01%2F48%2Fbestselling%2F"
		cb()