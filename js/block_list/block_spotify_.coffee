class @block_spotify_

	constructor: ()->
		css = """
			#spotify {
				background-image: url(img/spotify.png);
				background-size: cover;
			}

			#spotify_input {
				position: absolute;
				top: 50px;
				left: 10px;
				right: 10px;
				width: 80%;
				text-align: center;
				font-size: 10px;
			}
		"""

		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="spotify" class="drag-wrap draggable" name="spotify">
			<input id="spotify_input" type="text">
			<div id="video_frame"></div>
		</div>
		""").appendTo ".drag-zone"

		interact("#spotify_input")
		.on 'tap', (event) ->
			$("#spotify_input").focus()

		@track = ""
		@image = null
		@entries = []

		$("#spotify_input").on 'input propertychange', (event)=>
			artist = $("#spotify_input").val()
			$.ajax
				url: "https://api.spotify.com/v1/search?q=" + artist + "&type=track"
				error: (jqXHR, textStatus, errorThrown)->
					console.log jqXHR
					console.log textStatus
					console.log errorThrown
				success: (json,textStatus, z)=>
					@entries = json.tracks.items
					@track = json.tracks.items[0]
					@image = @track.album.images[0].url

	run: (element)=>
		$("#spotify").html("<img style='width: 115px; height: 115px' src=" + @image + ">")
		@entries

