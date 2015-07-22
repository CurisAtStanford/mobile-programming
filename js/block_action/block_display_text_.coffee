class @block_display_text_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="display_text">
			DISPLAY TEXT
		</div>
		""").appendTo ".drag-zone"

	run: (text)=>
		background = $ '<div>',
			text: text
		.css
			backgroundColor:'#1c1c1c'
			position:'absolute'
			top: 0
			width: '100%'
			height : '100%'
			zIndex: 90
			color: 'white'
			fontFamily: "'Amaranth', 'sans-serif'"
			padding: 100
		.appendTo "body"

		textFit background[0],
			alignVert:true
			alignHoriz:true
			multiLine: true
			maxFontSize: 300

		# callback?
		# cb()