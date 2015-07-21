class @block_weather_

	constructor: ()->
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

	run: (cb, element)=>
		active = @weather_block.get_active_slide()
		condition = null
		condition = 'rainy' if active is "rainy-icon"
		condition = 'cloudy' if active is "cloudy-icon"
		condition = 'sunny' if active is "sunny-icon"

		rain_codes = [3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 35, 37, 38, 39, 40, 41, 42, 43, 45, 46, 47]
		cloudy_codes = [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 44]
		sunny_codes = [31, 32, 33, 34, 36]

		navigator.geolocation.getCurrentPosition (position) =>
			myLat = position.coords.latitude
			myLng = position.coords.longitude

			$.simpleWeather
				async: false

				location: "#{myLat},#{myLng}"
				unit: 'f'
				success: (weather) =>
					code = parseInt weather.todayCode
					if ((condition is "rainy") and (code in rain_codes)) or ((condition is "cloudy") and (code in cloudy_codes)) or ((condition is "sunny") and (code in sunny_codes))
						cb true
					else cb false

				error: (error) ->
					alert 'my_weather error'
					console.log error
					cb false
