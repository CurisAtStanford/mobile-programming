class @block_time_

	constructor: ()->
		css = """
		.arrowUp {
			width: 10px;
			position: absolute;
			top: 22px;
			left: 2px;
		}

		.arrowDown {
			width: 10px;
			position: absolute;
			top: 65px;
			left: 2px;
		}

		#hoursBlock {
			position: relative;
			left: 18px;
		}

		#minutesBlock {
			position: relative;
			left: 38px;
			width: 10px;
		}

		#timeBlock {
			position: relative;
			left: 60px;
			width: 10px;
		}

		#hours, #minutes, #time {
			position: absolute;
		}

		#colon {
			position: absolute;
			left: 32px;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div class='drag-wrap draggable' name='time'>
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
		""").appendTo ".drag-zone"

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

		console.log time_clock = "#{clock_hours}:#{clock_minutes}"
		console.log  time_now = moment().format 'HH:mm'
		time_now == time_clock