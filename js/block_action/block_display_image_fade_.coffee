class @block_display_image_fade_

    num = 1
    constructor: ()->
        css = """
        """
        $('<style type="text/css"></style>').html(css).appendTo "head"

        $("""
        <div class="drag-wrap draggable" name="display_image_fade">
            DISPLAY FADE
        </div>
        """).appendTo ".drag-zone"

    run: (cb, obj)=>
        url = obj.images.standard_resolution.url
        $('<div id="white-background"></div><div id="image-div"></div><img id="pic'+num+'" class="new_image" src='+url+' hidden />').appendTo "body"

        $('#white-background').css
            backgroundColor: 'white'
            backgroundSize: 'cover'
            backgroundPosition: 'center'
            position: 'fixed'
            margin: 0
            top: 0
            bottom: 0
            right: 0
            left: 0
            width: '100%'
            height: '100%'
            zIndex: 90

        $('#image-div').css
            backgroundImage:"url(#{url})"
            backgroundSize:'cover'
            backgroundPosition:'center'
            position:'fixed'
            margin: 0
            top: '-50%'
            bottom: 0
            right: 0
            left:'-50%'
            width : '200%'
            height : '200%'
            zIndex: 100
            opacity: 0.35
            transform: 'rotate(15deg)'

        $('.new_image').css
            maxWidth: '120%'
            maxHeight: '100%'
            bottom: 0
            left: 0
            margin: 'auto'
            overflow: 'auto'
            position: 'fixed'
            right: 0
            top: 0
            zIndex: 110

        fadingPic = "#pic" + num

        `$(fadingPic).fadeIn();`
        `$("#image-div").fadeIn();`
        `setTimeout(function(){$(fadingPic).fadeOut();}, 2500);`
        `setTimeout(function(){$("#image-div").fadeOut();}, 2500);`
        num++
        setTimeout cb, 3000