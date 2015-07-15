class @block_camera_

	constructor: ()->
		css = """
		#camera_video {
			position: absolute;
			width: 385px;
			height: 290px;
			left: -47px;
			transform: scaleX(-1);
		}

		#camera_photo {
			position: absolute;
			width: 385px;
			height: 290px;
			left: -47px;
			top: 0px;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div id='drag12' class='draggable block3'>
			<video id='camera_video' autoplay>Video stream not available.</video>
			<canvas id='camera_canvas'></canvas>
			<img id='camera_photo'>
		</div>
		""").appendTo ".block_bank_wrapper"

		# The [0] makes it an html object.
		@video = $("#camera_video")[0]
		@photo = $('#camera_photo')[0]

		@canvas = $("#camera_canvas")[0]
		@canvas.width = 385
		@canvas.height = 290

		@context = @canvas.getContext '2d'

		navigator.getMedia = navigator.getUserMedia or navigator.webkitGetUserMedia
		navigator.getMedia
			video: true
			audio: false
		, (stream) =>
			@video.src = window.URL.createObjectURL stream
		, (error) ->
			console.log 'Camera blocked - the following error occurred: ' + error
			return

	run: ()=>
		# Takes picture. Draw video into a canvas, then converting it to a PNG format data URL.
		@context.drawImage @video, 0, 0, 385, 290
		data = @canvas.toDataURL 'image/png'
		@photo.setAttribute 'src', data