class @block_taylorswift_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		#taylor-image {
			height:130%;
			position: relative;
			left: -65px;
			top:0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="taylorswift">
			<img id="taylor-image" src="img/taylorswift.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		taylorswift = 11830955

		feed = new Instafeed
			get: 'user'
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
