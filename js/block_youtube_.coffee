class @block_youtube_

	constructor: ()->
		css = """
		#youtube_pic{
			position: absolute;
			left:0px;
			top: 0px;
		}

		#youtube_input {
			position: absolute;
			top: 150px;
			left: 40px;
			width: 200px;
			font-size: 25px;
		}

		#youtube_player {
			position: absolute;
			top: 0px;
			left: 0px;
			width: 100%;
			height: 100%;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div id="drag9" class="draggable block3">
				<div id="youtube_player"></div>
				<img id="youtube_pic" src="img/youtube-logo.png">
				<input id="youtube_input" type="text">
		</div>
		""").appendTo ".block_bank_wrapper"

		interact("#drag9")
		.on 'tap', (event) ->
			$("#youtube_input").focus()

		extract_video_id = (url)->
			match = url.match /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/
			if match && match[7].length == 11
				return match[7]
			else
				alert "Could not extract video ID."

		$("#youtube_input").on 'input propertychange', (event)=>

			# @youtube_id = "MTNPf8WxTus"
			# https://www.youtube.com/watch?v=MTNPf8WxTus

			youtube_url = $("#youtube_input").val()
			@youtube_id = extract_video_id youtube_url

			$("#youtube_input").remove()
			$("#youtube_pic").remove()

			$("#drag9").css
				backgroundImage: "url(https://i1.ytimg.com/vi/#{@youtube_id}/default.jpg)"
				backgroundSize: 'cover'
				backgroundRepeat:'no-repeat'
				backgroundPosition: 'center center'

	run: ()=>
		# tag = document.createElement 'script'
		# tag.src = "https://www.youtube.com/player_api"
		# firstScriptTag = document.getElementsByTagName('script')[0]
		# firstScriptTag.parentNode.insertBefore tag, firstScriptTag

		# window.onYouTubeIframeAPIReady = ()=>
		# 	player = new YT.Player 'youtube_player',
		# 		videoId: @youtube_id
		# 		playerVars:
		# 			controls: 0
		# 			autohide: 1
		# 			iv_load_policy: 3
		# 			showinfo: 0
		# 			modestbranding: 1
		# 		events:
		# 			onStateChange: (e)-> console.log "onStateChange"
		# 			onReady: (e)-> e.target.playVideo()

