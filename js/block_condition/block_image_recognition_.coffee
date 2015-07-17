class @block_image_recognition_

	constructor: ()->
		css = """
		#image_pic {
			position: absolute;
			width: 140px;
			top: 30px;
			left: 70px;
			height: 100px;
		}
		#image_input {
			position: absolute;
			top: 150px;
			left: 40px;
			width: 200px;
			font-size: 25px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="drag10" class="draggable block1">
			<img src = "img/image_placeholder.png" id="image_pic">
			<input id="image_input" type="text" name="image" >
		</div>
		""").appendTo ".block_bank_wrapper"

		$image_input = $("#image_input")

		interact("#drag10")
		.on 'tap', (event) ->
			$("#image_input").focus()

		$image_input.on 'input propertychange', (event)=>
			@image_url = $image_input.val()
			$("#drag10").css
				backgroundImage: "url(#{@image_url})"
				backgroundSize: 'cover'
			$image_input.remove()
			$("#image_pic").remove()

			# get tags
			$.ajax
				url: "https://api.clarifai.com/v1/tag/?url=" + encodeURI(@image_url)
				headers:
					Authorization: "Bearer 80mKPxFRKzN2APnVMJJGnOMRxHLiRj"

				error: (jqXHR, textStatus, errorThrown)->
					console.log jqXHR
					console.log textStatus
					console.log errorThrown
					alert "error"
				success: (json,textStatus, z)=>
					NMAX_TAGS = 5
					@top_tags = json.results[0].result.tag.classes[0...NMAX_TAGS]
					top_probs = json.results[0].result.tag.probs[0...NMAX_TAGS]

	run: ()=>
		@top_tags