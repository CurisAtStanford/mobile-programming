class @block_block_color_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable" name="block_color" style="background-image:url(./img/color_bubbles.jpg)">
			<input type="image" src="./img/left-arrow.png" name="saveForm" class="btTxt submit" id="button-left-color" style="width:20%;margin-bottom:45px"/>
			<img id="crayon2" src="./img/crayon_red.png" style="height:100%"/>
			<input type="image" src="./img/right-arrow.png" name="saveForm" class="btTxt submit" id="button-right-color" style="width:20%;margin-bottom:45px"/>
		</div>
		""").appendTo ".drag-zone"


		interact("#button-left-color").on 'tap', ->
			src = $("#crayon2").attr('src')
			switch
				when src is "./img/crayon_red.png" then $("#crayon2").attr 'src',  "./img/crayon_orange.png"
				when src is "./img/crayon_orange.png" then $("#crayon2").attr 'src',  "./img/crayon_yellow.png"
				when src is "./img/crayon_yellow.png" then $("#crayon2").attr 'src',  "./img/crayon_green.png"
				when src is "./img/crayon_green.png" then $("#crayon2").attr 'src',  "./img/crayon_blue.png"
				when src is "./img/crayon_blue.png" then $("#crayon2").attr 'src',  "./img/crayon_purple.png"
				when src is "./img/crayon_purple.png" then $("#crayon2").attr 'src',  "./img/crayon_pink.png"
				when src is "./img/crayon_pink.png" then $("#crayon2").attr 'src',  "./img/crayon_grey.png"
				when src is "./img/crayon_grey.png" then $("#crayon2").attr 'src',  "./img/crayon_red.png"

		interact("#button-right-color").on 'tap', ->
			src = $("#crayon2").attr('src')
			switch
				when src is "./img/crayon_grey.png" then $("#crayon2").attr 'src',  "./img/crayon_pink.png"
				when src is "./img/crayon_pink.png" then $("#crayon2").attr 'src',  "./img/crayon_purple.png"
				when src is "./img/crayon_purple.png" then $("#crayon2").attr 'src',  "./img/crayon_blue.png"
				when src is "./img/crayon_blue.png" then $("#crayon2").attr 'src',  "./img/crayon_green.png"
				when src is "./img/crayon_green.png" then $("#crayon2").attr 'src',  "./img/crayon_yellow.png"
				when src is "./img/crayon_yellow.png" then $("#crayon2").attr 'src',  "./img/crayon_orange.png"
				when src is "./img/crayon_orange.png" then $("#crayon2").attr 'src',  "./img/crayon_red.png"
				when src is "./img/crayon_red.png" then $("#crayon2").attr 'src',  "./img/crayon_grey.png"

	run: (cb)=>
		src = $("#crayon2").attr('src')
		switch
			when src is "./img/crayon_grey.png" then $(".drag-wrap").css(backgroundColor: "#cccccc")
			when src is "./img/crayon_pink.png" then $(".drag-wrap").css(backgroundColor: "#FF99CC")
			when src is "./img/crayon_purple.png" then $(".drag-wrap").css(backgroundColor: "#FF00FF")
			when src is "./img/crayon_blue.png" then $(".drag-wrap").css(backgroundColor: "#33CCFF")
			when src is "./img/crayon_green.png" then $(".drag-wrap").css(backgroundColor: "#66FF66")
			when src is "./img/crayon_yellow.png" then $(".drag-wrap").css(backgroundColor: "#FFFF00")
			when src is "./img/crayon_orange.png" then $(".drag-wrap").css(backgroundColor: "#FF9933")
			when src is "./img/crayon_red.png" then $(".drag-wrap").css(backgroundColor: "#E62425")

		cb()