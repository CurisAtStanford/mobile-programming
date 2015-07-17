class @block_kimkardashian_

	constructor: ()->
		css = """
		#instafeed {
			display: none;
		}
		#kim-image {
			width:120%;
			position: relative;
			left: -15px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="kimkardashian">
			<img id="kim-image" src="img/kimkardashian.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		kimkardashian = 18428658

		feed = new Instafeed
			get: 'user'
			userId: kimkardashian
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		audio = new Audio "sound/bound2.mp3"
		audio.play()
		@images
