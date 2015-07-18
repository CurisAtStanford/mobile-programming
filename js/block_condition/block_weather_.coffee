class @block_weather_

	constructor: ()->
		console.log "GOT IN BLOCK WEATHER"

		css = """
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id="weather-block" class="drag-wrap draggable" name="weather">
			<div id="sunny-icon">
				<img src="img/sunny.png">
			</div>
			<div id="cloudy-icon">
				<img src="img/cloudy2.png">
			</div>
			<div id="rainy-icon">
				<img src="img/rainy.png">
			</div>
		</div>
		""").appendTo ".drag-zone"

		@weather_block = new block_animation_ "weather-block"

	run: (action)=>
		active = @weather_block.get_active_slide()
		return 'rainy' if active is "rainy-icon"
		return 'cloudy' if active is "cloudy-icon"
		return 'sunny' if active "sunny-icon"