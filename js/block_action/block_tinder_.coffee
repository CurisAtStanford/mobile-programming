class @block_tinder_

  constructor: ()->
    css = """
      #tinder_drag {
        background-image: url(http://media.bestofmicro.com/K/U/423246/original/mini.png);
        background-size: cover;
      }

      #viewport {
        width: 100%;
        height: 100%;
        position: relative;
        left: auto;
        right: auto;
      }

      #viewport li {
        width: 250px;
        height: 350px;
        list-style: none;
        background: #fff;
        border-radius: 5px;
        top:0;
        bottom: 0;
        left: 0;
        right: 0;
        margin: auto;
        position: absolute;
        text-align: center;
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.2), 1px 1px 1px rgba(0, 0, 0, 0.2);
        line-height: 300px;
        text-align: center;
        font-size: 100px;
        border: 15px solid #ECECEC;
        box-sizing: border-box;
        cursor: default;
      }
    """
    $('<style type="text/css"></style>').html(css).appendTo "head"

    $("""
    <div id = "tinder_drag" class="drag-wrap draggable" name="tinder">
    </div>
    """).appendTo ".drag-zone"

  window.tinder_yes_entries= []
  window.tinder_no_entries = []

  run: (cb, entry)=>
    audio = new Audio()
    audio.src = entry.preview_url
    audio.play()

    if entry.album is undefined
      url = entry.images.standard_resolution.url
      description = ""
    else
      url = entry.album.images[0].url
      description = "Track: " + entry.name
    $('<div id="white-background"></div><div id="image-div"></div><div id="viewport">
        <ul class="stack">
        </ul>
    </div>').appendTo "body"

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

    $('#viewport').css
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

    stack = gajus.Swing.Stack()

    elem = $("<li id = 'active-entry' class='clubs in-deck'><img src=" + url + " width='100%'; height='70%'><div id='description' style='text-align:center; position: absolute; width: 230px; right: auto;top: 100px; font-size: 20px'>" + description  + "</div></li>")
    $(".stack" ).append(elem)

    [].forEach.call($('.stack li'), (targetElement) =>
      stack.createCard targetElement
      targetElement.classList.add 'in-deck'
    )

    stack.on 'throwout', (e) =>
      audio.pause()
      # right
      if e.throwDirection == 1
        window.tinder_no_entries.push entry

      # left
      if e.throwDirection != 1
        window.tinder_yes_entries.push entry

      e.target.classList.remove('in-deck')
      e.target.remove()
      cb()
