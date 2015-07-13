class @block_time_

	constructor: ()->
		css = """
		.arrowUp {
			width: 50px;
			height: 50px;
			position: absolute;
			top: 30px;
			left: 9px;
		}

		.arrowDown {
			width: 50px;
			height: 50px;
			position: absolute;
			top: 200px;
			left: 9px;
		}

		#hoursBlock {
			position: relative;
			left: 50px;
			width: 70px;
		}

		#minutesBlock {
			position: relative;
			left: 130px;
			width: 70px;
		}

		#timeBlock {
			position: relative;
			left: 200px;
			width: 70px;
		}

		#hours {
			position: absolute;
		}

		#colon {
			position: absolute;
			left: 100px;
		}

		#minutes {
			position: absolute;
		}

		#time {
			position: absolute;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div id='drag7' class='draggable block2'>
			<div id="hoursBlock">
				<div id="hours">12</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
			<div id="colon">:</div>
			<div id="minutesBlock">
				<div id="minutes">00</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
			<div id="timeBlock">
				<div id="time">AM</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
		</div>
		""").appendTo ".block_bank_wrapper"

		#clock logic
		$hours = $ "#hours"
		$minutes = $ "#minutes"
		$time = $ "#time"

		hours_counter = 12
		minutes_counter = 0
		morning = true

		interact('.arrowUp')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlock"
					hours_counter++
					hours_counter = 1 if hours_counter > 12
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter++
					minutes_counter = 0 if minutes_counter > 59
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"

		interact('.arrowDown')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlock"
					hours_counter--
					hours_counter = 12 if hours_counter <= 0
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter--
					minutes_counter = 59 if minutes_counter < 0
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"


	run: ()=>
		clock_hours = $("#hours").text()
		clock_minutes = $("#minutes").text()
		clock_time = $("#time").text()
		if clock_time is "PM"
			clock_hours = parseInt(clock_hours) + 12

		"#{clock_hours}:#{clock_minutes}"