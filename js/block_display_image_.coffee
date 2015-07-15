class @block_display_image_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head" 

		$("""
		<div class="drag-wrap draggable" name="display_image">
			DISPLAY IMAGE
		</div>
		""").appendTo ".drag-zone"


	run: (obj)=>

		object_has_key = (obj, prop) ->
			for p of obj
				if obj.hasOwnProperty p

					if p is prop
						return obj[p]
					else if obj[p] instanceof Object
						return object_has_key(obj[p], prop)
						console.log 2
					# 	return obj[p]
			null

		# console.log obj
		obj = object_has_key obj, 'text'


		if obj
			console.log obj
		else
			console.log 'false'

		# # url = "http://www.loveinthecityoflights.com/wp-content/uploads/2013/02/IMG_1585.jpg"
		# $('<div id="white-background"></div><div id="image-div"></div><img class="new_image" src='+url+' />').appendTo "body"

		# $('#white-background').css
		# 	backgroundColor: 'white'
		# 	backgroundSize: 'cover'
		# 	backgroundPosition: 'center'
		# 	position: 'fixed'
		# 	margin: 0
		# 	top: 0
		# 	bottom: 0
		# 	right: 0
		# 	left: 0
		# 	width: '100%'
		# 	height: '100%'
		# 	zIndex: 90

		# $('#image-div').css
		# 	backgroundImage:"url(#{url})"
		# 	backgroundSize:'cover'
		# 	backgroundPosition:'center'
		# 	position:'fixed'
		# 	margin: 0
		# 	top: '-50%'
		# 	bottom: 0
		# 	right: 0
		# 	left:'-50%'
		# 	width : '200%'
		# 	height : '200%'
		# 	zIndex: 100
		# 	opacity: 0.35
		# 	transform: 'rotate(15deg)'

		# $('.new_image').css
		# 	maxWidth: '120%'
		# 	maxHeight: '100%'
		# 	bottom: 0
		# 	left: 0
		# 	margin: 'auto'
		# 	overflow: 'auto'
		# 	position: 'fixed'
		# 	right: 0
		# 	top: 0
		# 	zIndex: 110