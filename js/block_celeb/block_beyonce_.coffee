class @block_beyonce_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}

		#beyonce-image {
			height:100%;
			position: relative;
			left: -40px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="beyonce">
			<img id="beyonce-image" src="img/beyonce.jpg">
		<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		beyonce = 247944034

		feed = new Instafeed
			get: 'user'
			userId: beyonce
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		audio = new Audio "sound/drunkinlove.mp3"
		audio.play()
		@images
