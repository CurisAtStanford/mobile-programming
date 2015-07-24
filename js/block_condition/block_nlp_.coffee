class @block_nlp_

	constructor: ()->
		@happy_picture_path = "img/thumbs_up.jpg"
		@sad_picture_path = "img/thumbs_down.png"

		css = """
		#nlp-block {
			background-image: url(#{@happy_picture_path});
			background-size: cover;
		}

		#nlp_input {
			position: absolute;
			top: 65%;
			width: 80%;
			left: 10%;
			text-align: center;
			font-size: 11px;
			background: #ACF0F2;
			z-index: 20;
			opacity: 0.6;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="nlp-block" class="drag-wrap draggable" name="nlp">
			<img src="./img/left-arrow.png" id="button-left-nlp" style="width:20%;margin-bottom:-15px; margin-left: -5px;"/>
			<input id="nlp_input" type="text" value="FEELING">
			<img src="./img/right-arrow.png" id="button-right-nlp" style="width:20%;margin-bottom:-15px;margin-left: 60px;"/>

		</div>
		""").appendTo ".drag-zone"

		switch_feeling = () =>
			background = $("#nlp-block").css('background-image')
			happy_index = background.indexOf @happy_picture_path
			sad_index = background.indexOf @sad_picture_path
			if happy_index !=-1 then $("#nlp-block").css 'background-image',  "url(" + @sad_picture_path + ")"
			else if sad_index !=-1 then $("#nlp-block").css 'background-image',  "url(" + @happy_picture_path + ")"

		interact("#button-left-nlp").on 'tap', ->
			switch_feeling()

		interact("#button-right-nlp").on 'tap', ->
			switch_feeling()

		interact("#nlp_input")
		.on 'tap', (event) ->
			$("#nlp_input").val ""
			$("#nlp_input").focus()

		@sentiment = ""



	run: (cb, element)=>
		text = $("#nlp_input").val()
		$.ajax
				Accept: "application/json"
				url: "https://loudelement-free-natural-language-processing-service.p.mashape.com/nlp-text/?text=" + text
				headers:
					'X-Mashape-Key': 'KnJbxzvOw6msheLU1Lt6ol120y0Rp1rdwCwjsnKYyLhmdJERdO'
				error: (jqXHR, textStatus, errorThrown)->
					console.log jqXHR
					console.log textStatus
					console.log errorThrown
					alert "error"
				success: (json,textStatus, z)=>
					@sentiment = json["sentiment-text"]
					background_image = $("#nlp-block").css('background-image')
					is_happy = background_image.indexOf @happy_picture_path
					is_sad = background_image.indexOf @sad_picture_path
					if @sentiment is "positive" and is_happy != -1 then cb true
					else if @sentiment is "negative" and is_sad != -1 then cb true