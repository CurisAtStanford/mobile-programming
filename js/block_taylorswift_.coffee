class @block_taylorswift_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="taylorswift">
			Taylor Swift
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"

		taylorswift = 11830955

		feed = new Instafeed
			get: 'user'
			# tagName: 'awesome'
			userId: taylorswift
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		audio = new Audio "sound/blankspace.mp3"
		audio.play()
		@images
