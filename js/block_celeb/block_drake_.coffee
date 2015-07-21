class @block_drake_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		#drake-image {
			height:100%;
			position: relative;
			left: -50px;
			top: 0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="drake">
			<img id="drake-image" src="img/drake.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		drake = 14455831

		feed = new Instafeed
			get: 'user'
			userId: drake
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		audio = new Audio "sound/headlines.mp3"
		audio.play()
		@images
