class @block_nlp_

	constructor: ()->
		css = """
		#I_FEEL_text{
			position: absolute;
			font-size: 20px;
			top: -30px;
			left: 25px;
		}

		#nlp_input {
			position: absolute;
			top: 30px;
			left: 10px;
			width: 80px;
			font-size: 10px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="nlp-block" class="drag-wrap draggable" name="nlp">
			<div id="thumbs-up-icon">
				<img src="img/thumbs_up.png">
			</div>
			<div id="neutral-icon">
				<img src="img/neutral.png">
			</div>
			<div id="thumbs-down-icon">
				<img src="img/thumbs_down.png">
			</div>
		</div>
		""").appendTo ".drag-zone"

		@nlp_block = new block_animation_ "nlp-block"

		interact("#nlp_input")
		.on 'tap', (event) ->
			$("#nlp_input").focus()

		@sentiment = ""
		$("#nlp_input").on 'input propertychange', (event)=>
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


		run: ()=>
			active = @nlp_block.get_active_slide()
			if @sentiment is "positive" and active is "thumbs-down-icon" then return true
			else if @sentiment is "negative" and active is "thumbs-up-icon" then return true
			else if @sentiment is "neutral " and active is "neutral-icon" then return true