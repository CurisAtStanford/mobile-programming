class @block_instagram_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag20' class='draggable block4'>INSTAGRAM</div>
		""").appendTo ".block_bank_wrapper"

		feed = new Instafeed
			get: 'tagged'
			tagName: 'batman'
			clientId: '2ce74f3a33a6412f8d176c3603a92c0f'
			template: '<div class="instagram-captions">{{caption}}</div>'

		feed.run();

	run: ()=>
		captions = []
		$(".instagram-captions").each ->
			captions.push $(this).text()
		console.log captions
		captions
