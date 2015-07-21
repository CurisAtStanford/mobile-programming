class @block_youtube_

	constructor: ()->
		css = """
		#youtube_pic{
			position: absolute;
			left: 6px;
			top: 2px;
			width: 100px;
		}

		#youtube_player {
			position: absolute;
			top: 0px;
			left: 0px;
			width: 100%;
			height: 100%;
		}

		#youtube_input {
			position: absolute;
			top: 55%;
			width: 80%;
			left: 6%;
			text-align: center;
			font-size: 11px;
			background: #ACF0F2;
			opacity: 0.4;
		}

		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="youtube">
			<div id="youtube_player"></div>
			<img id="youtube_pic" src="img/youtube-logo.png">
			<input id="youtube_input" type="text" value="VIDEO URL">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=youtube]")
		.on 'tap', (event) =>
			$("#youtube_input").val ""
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
			console.log @youtube_id = extract_video_id youtube_url

			$("#youtube_input").remove()
			$("#youtube_pic").remove()

			$("[name=youtube]").css
				backgroundImage: "url(https://i1.ytimg.com/vi/#{@youtube_id}/default.jpg)"
				backgroundSize: 'cover'
				backgroundRepeat:'no-repeat'
				backgroundPosition: 'center center'

	run: ()=>
		console.log " youtube run"
		tag = document.createElement 'script'
		tag.src = "https://www.youtube.com/player_api"
		firstScriptTag = document.getElementsByTagName('script')[0]
		firstScriptTag.parentNode.insertBefore tag, firstScriptTag

		window.onYouTubeIframeAPIReady = ()=>
			player = new YT.Player 'youtube_player',
				# videoId: @youtube_id
				videoId: "CLAnuG1340g"
				# playerVars:
				# 	controls: 0
				# 	autohide: 1
				# 	iv_load_policy: 3
				# 	showinfo: 0
				# 	modestbranding: 1
				events:
					onStateChange: (e)->
						console.log "youtube onStateChange"
					onReady: (e)->
						console.log "youtube onReady"
						e.target.playVideo()

# https://www.youtube.com/watch?v=CLAnuG1340g