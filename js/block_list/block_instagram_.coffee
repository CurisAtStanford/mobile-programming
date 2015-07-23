class @block_instagram_

	constructor: ()->
		css = """
		#instagram_pic {
			position: absolute;
			left: 18px;
			top: 16px;
			width: 80px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="instagram">
			<img id="instagram_pic" src="img/instagram.png">
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"

		feed = new Instafeed
			get: 'tagged'
			tagName: 'awesome'
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		@images