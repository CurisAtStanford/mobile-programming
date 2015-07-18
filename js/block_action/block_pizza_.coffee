class @block_pizza_

	constructor: ()->
		css = """
			#pizza {
				background-image: url(img/pizza.jpeg);
				background-size: cover;

			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="pizza" class="drag-wrap draggable" name="pizza">
		</div>
		""").appendTo ".drag-zone"

	run: (cb, element)=>
		window.open "https://order.dominos.com/en/pages/order/#/locations/search/"
		cb()