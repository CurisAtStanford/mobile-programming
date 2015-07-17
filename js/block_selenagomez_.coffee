class @block_selenagomez_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="selenagomez">
			Selena Gomez
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"

		selenagomez = 460563723

		feed = new Instafeed
			get: 'user'
			# tagName: 'awesome'
			userId: selenagomez
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		audio = new Audio "sound/goodforyou.mp3"
		audio.play()
		@images
