class @block_my_weather_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag15' class='draggable block1'>MY WEATHER</div>
		""").appendTo ".block_bank_wrapper"

		rain_codes = [3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 35, 37, 38, 39, 40, 41, 42, 43, 45, 46, 47]
		cloudy_codes = [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 44]
		sunny_codes = [31, 32, 33, 34, 36]

		@condition = ''
		navigator.geolocation.getCurrentPosition (position) =>
			myLat = position.coords.latitude
			myLng = position.coords.longitude

			$.simpleWeather
				async: false

				location: "#{myLat},#{myLng}"
				unit: 'f'
				success: (weather) =>
					code = parseInt weather.todayCode
					@condition = 'rainy' if code in rain_codes
					@condition = 'cloudy' if code in cloudy_codes
					@condition = 'sunny' if code in sunny_codes
				error: (error) ->
					alert 'my_weather error'
					console.log error
	run: ()=>
		# async bug
		@condition

###
weatherInfo = 
	0: tornado
	1: tropical storm
	2: hurricane
	3: severe thunderstorms
	4: thunderstorms
	5: mixed rain and snow
	6: mixed rain and sleet
	7: mixed snow and sleet
	8: freezing drizzle
	9: drizzle
	10: freezing rain
	11: showers
	12: showers
	13: snow flurries
	14: light snow showers
	15: blowing snow
	16: snow
	17: hail
	18: sleet
	19: dust
	20: foggy
	21: haze
	22: smoky
	23: blustery
	24: windy
	25: cold
	26: cloudy
	27: mostly cloudy (night)
	28: mostly cloudy (day)
	29: partly cloudy (night)
	30: partly cloudy (day)
	31: clear (night)
	32: sunny
	33: fair (night)
	34: fair (day)
	35: mixed rain and hail
	36: hot
	37: isolated thunderstorms
	38: scattered thunderstorms
	39: scattered thunderstorms
	40: scattered showers
	41: heavy snow
	42: scattered snow showers
	43: heavy snow
	44: partly cloudy
	45: thundershowers
	46: snow showers
	47: isolated thundershowers
	3200: "not available"
###