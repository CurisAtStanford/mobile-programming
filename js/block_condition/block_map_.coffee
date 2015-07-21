class @block_map_

	constructor: ()->
		css = """
		#google_map{
			width: 100px;
			height: 100px;
			left: 7px;
			top: 7px;
			line-height: 0px;
			border-radius: 50%
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="map">
			<div id='google_map'></div>
		</div>
		""").appendTo ".drag-zone"

		# Implements non-dragging functionality for map block
		$("#google_map").bind 'touchstart mousedown' ,->
			$("#google_map").parent().removeClass("draggable").addClass "not_draggable"

		$("body").bind 'touchend mouseup', ->
			$("#google_map").parent().removeClass("not_draggable").addClass "draggable"

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
		# fix
		true

		# navigator.geolocation.getCurrentPosition (position) =>
		# 	@my_lat = position.coords.latitude
		# 	@my_lng = position.coords.longitude

		# 	my_lat_lng = new google.maps.LatLng @my_lat, @my_lng

		# 	bounds = @map.getBounds()
		# 	rectangle = get_rectangle_coords bounds
		# 	polygon_area = new google.maps.Polygon
		# 			paths: rectangle

		# 	if google.maps.geometry.poly.containsLocation my_lat_lng, polygon_area
		# 		return true
		# 	else
		# 		return false

		# polygon_area.setMap @map

		# strokeColor: '#FF0000'
		# strokeOpacity: 0.8
		# strokeWeight: 3
		# fillColor: '#FF0000'
		# fillOpacity: 0.35
