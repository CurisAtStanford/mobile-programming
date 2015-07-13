class @block_map_

	constructor: ()->
		css = """
		#google_map{
			width: 220px;
			height: 220px;
			left: 35px;
			top: 35px;
			line-height: 0px;
		}

		.not_draggable {
			overflow: hidden;
			border: 2px solid #F3FFE2;
			border-radius: 10px;
			position: relative;
			float: left;
			width: 290px;
			height: 290px;
			background-color: #1695A3;
			color: #F3FFE2;
			text-align: center;
			vertical-align: center;
			line-height: 280px;
			margin: 15px;
			box-shadow: 0 8px 6px -6px black;
		}

		.not_draggable.drop_possible {
			background-color: #EB7F00;
		}

		.not_draggable.drop_over {
			background-color: #225378;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div id='drag5' class='draggable block2'>
			<div id='google_map'></div>
		</div>
		""").appendTo ".block_bank_wrapper"

		# Implements non-dragging functionality for map block
		$("#google_map").bind 'touchstart mousedown' ,->
			$("#drag5").removeClass("draggable").addClass "not_draggable"

		$("body").bind 'touchend mouseup', ->
			$("#drag5").removeClass("not_draggable").addClass "draggable"

		google.maps.event.addDomListener window, 'load',=>
			navigator.geolocation.getCurrentPosition (position) =>
				@my_lat = position.coords.latitude
				@my_lng = position.coords.longitude

				map_prop =
					center: new google.maps.LatLng @my_lat, @my_lng
					zoom: 17
					mapTypeId: google.maps.MapTypeId.ROADMAP
					disableDefaultUI: true
					minZoom: 17
					maxZoom: 17
				@map = new google.maps.Map document.getElementById("google_map"), map_prop

	run: ()=>
		get_rectangle_coords = (bounds) =>
			northEast = bounds.getNorthEast()
			southWest = bounds.getSouthWest()
			southWestLat = southWest.lat()
			southWestLng = southWest.lng()
			northEastLat = northEast.lat()
			northEastLng = northEast.lng()
			southEastLat = northEast.lat()
			southEastLng = southWest.lng()
			northWestLng = northEast.lng()
			northWestLat = southWest.lat()
			[
				new google.maps.LatLng southWestLat, southWestLng
				new google.maps.LatLng northWestLat, northWestLng
				new google.maps.LatLng northEastLat, northEastLng
				new google.maps.LatLng southEastLat, southEastLng
			]

		navigator.geolocation.getCurrentPosition (position) =>
			@my_lat = position.coords.latitude
			@my_lng = position.coords.longitude

			my_lat_lng = new google.maps.LatLng @my_lat, @my_lng

			bounds = @map.getBounds()
			rectangle = get_rectangle_coords bounds
			polygon_area = new google.maps.Polygon
					paths: rectangle
					# strokeColor: '#FF0000'
					# strokeOpacity: 0.8
					# strokeWeight: 3
					# fillColor: '#FF0000'
					# fillOpacity: 0.35

			if google.maps.geometry.poly.containsLocation my_lat_lng, polygon_area
				return true
			else
				return false

		# polygon_area.setMap @map