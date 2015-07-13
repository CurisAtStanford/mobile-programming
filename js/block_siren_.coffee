class @block_siren_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head" 

		$("""
		<div id='drag6' class='draggable block3'>SIREN</div>
		""").appendTo ".block_bank_wrapper"

	run: ()=>
		audio = new Audio "sound/Siren.mp3"
		audio.play()