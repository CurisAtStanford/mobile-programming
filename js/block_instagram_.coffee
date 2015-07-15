class @block_instagram_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="instagram">
			INSTAGRAM
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"


		feed = new Instafeed
			get: 'tagged'
			tagName: 'awesome'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		@images