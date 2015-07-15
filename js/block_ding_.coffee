class @block_ding_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag4' class='draggable block3 block5'>DING</div>
		""").appendTo ".block_bank_wrapper"

	run: ()=>
		audio = new Audio "sound/Ding.mp3"
		audio.play()