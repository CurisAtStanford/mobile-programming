class @block_orientation_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="orientation">
			ORIENTATION
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		# Position name for the Device Orientation
		POSITION_NAMES =
			TANNING: "Tanning"
			FACE_PLANT: "Face Plant"
			STANDING: "Standing"
			HEAD_STAND: "Head Stand"
			NAPPING: "Napping"
			OTHER_POS: "Other Position"


		checkMatchingPosition = ->
			console.log("In checkMatchingPosition")
			device_position = get_device_position()
			desired_position = get_desired_position()
			return device_position is desired_position

		get_device_position = ->
			tolerance = 15
			position = POSITION_NAMES.OTHER_POS

			if  tiltLR >= -tolerance and tiltLR <= tolerance and
				tiltFB >= -tolerance and tiltFB <= tolerance
						position = POSITION_NAMES.TANNING;
			else if tiltLR >= -tolerance and tiltLR <= tolerance and
					tiltFB >= -tolerance - 180 and tiltFB <= tolerance - 180
						position = POSITION_NAMES.FACE_PLANT;
			else if tiltFB >= -tolerance + 90 and tiltFB <= tolerance + 90
						position = POSITION_NAMES.STANDING;
			else if tiltFB >= -tolerance - 90 and tiltFB <= tolerance - 90
						position = POSITION_NAMES.HEAD_STAND;
			else if (((tiltLR >= -tolerance + 90 and tiltLR <= tolerance + 90) or
					(tiltLR >= -tolerance - 90 and tiltLR <= tolerance - 90)) and
					(tiltFB >= -tolerance and tiltFB <= tolerance))
						position = POSITION_NAMES.NAPPING;
			console.log("get_device_position returns with " + position)
			return position



		get_desired_position = () ->
			console.log("In get_desired_position()")
			# $("#messages").text $active_position[0]
			$active_position = $(".real-active-slide")

			position = null
			if $active_position.hasClass "tanning"
				position = POSITION_NAMES.TANNING
			else if $active_position.hasClass "face_plant"
				position = POSITION_NAMES.FACE_PLANT
			else if $active_position.hasClass "standing"
				position = POSITION_NAMES.STANDING
			else if $active_position.hasClass "head_stand"
				position = POSITION_NAMES.HEAD_STAND
			else if $active_position.hasClass "napping"
				position = POSITION_NAMES.NAPPING
			else
			position = POSITION_NAMES.OTHER_POS

			#position = POSITION_NAMES.STANDING
			console.log("get_desired_position returns with " + position)
			$("#messages").text position
			return position


		window.addEventListener 'deviceorientation', ((eventData) ->
			tiltLR = eventData.gamma # left-to-right tilt of the phone
			tiltFB = eventData.beta  # front-to-back tilt of the phone
			dir = eventData.alpha    # compass direction
			#console.log("tiltLR=" + tiltLR + ", tiltFB=" + tiltFB + ", dir=" + dir)
		), false
		console.log("End of startup")


			#     <div class='draggable block1'>ORIENTATION</div>
			#     <div id="swiper-container-reg" class="swiper-container swiper-container-reg">
			#         <div class="swiper-wrapper">
			#             <div class="swiper-slide stop-swiping standing">
			#                 STANDING
			#             </div>
			#             <div class="swiper-slide stop-swiping head-stand">
			#                 HEAD
			#             </div>
			#             <div class="swiper-slide stop-swiping face-plant">
			#                 FACE
			#             </div>
			#              <div class="swiper-slide stop-swiping tanning">
			#                 TANNING
			#             </div>
			#              <div class="swiper-slide stop-swiping napping">
			#                 NAPPING
			#             </div>
			#         </div>
			#         <div class="swiper-button-next"><i class="fa fa-chevron-right fa-3x"></i></div>
			#         <div class="swiper-button-prev"><i class="fa fa-chevron-left fa-3x"></i></div>
			#     </div>
			# </div>
