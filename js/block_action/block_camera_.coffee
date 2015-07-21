class @block_camera_

	constructor: ()->
		css = """
		#camera_video {
			position: relative;
			left: -15px;
			transform: scaleX(-1);
			height: 100%;
		}

		#camera_photo {
			position: absolute;
			left: -15px;
			transform: scaleX(-1);
			height: 100%;
			top: 0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="camera">
			<video id='camera_video' autoplay>Video stream not available.</video>
			<canvas id='camera_canvas'></canvas>
			<img id='camera_photo'>
		</div>
		""").appendTo ".drag-zone"

		# The [0] makes it an html object.
		@video = $("#camera_video")[0]
		@photo = $('#camera_photo')[0]

		@canvas = $("#camera_canvas")[0]
		@canvas.width = 640
		@canvas.height = 480

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

	run: (cb)=>
		# Takes picture. Draw video into a canvas, then converting it to a PNG format data URL.
		@context.drawImage @video, 0, 0, 640, 480
		data = @canvas.toDataURL 'image/png'
		@photo.setAttribute 'src', data
		console.log @photo

		cb()