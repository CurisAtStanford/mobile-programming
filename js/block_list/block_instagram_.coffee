class @block_instagram_

	constructor: ()->
		css = """
		#instagram_pic {
			position: absolute;
			left: 18px;
			top: 16px;
			width: 80px;
		}

		# #insta_tag_input {
		# 	position: absolute;
		# 	top: 70%;
		# 	width: 60%;
		# 	left: 17%;
		# 	text-align: center;
		# 	font-size: 11px;
		# 	background: #ACF0F2;
		# 	opacity: 0.4;
		# }

		#instafeed {
			display: none;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="instagram">
			<img id="instagram_pic" src="img/instagram.png">
			# <input id="insta_tag_input" type="text" value="ENTER TAG">
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"

		# interact("[name=instagram]")
		# .on 'tap', (event) =>
		# 	$("#insta_tag_input").val ""
		# 	$("#insta_tag_input").focus()

		# @$input = $("#insta_tag_input")

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
		console.log @images
		@images