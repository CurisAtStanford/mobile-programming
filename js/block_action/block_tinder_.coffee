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

      #description {
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        margin-top: 0;
        margin: auto;
        position: absolute;
        font-size: 12px;
        margin-top: 220px;
        width: 220px;
      }

      #viewport li {
        width: 250px;
        height: 350px;
        list-style: none;
        background: #ff6666;
        border-radius: 5px;
        top:0;
        bottom: 0;
        left: 0;
        right: 0;
        margin: auto;
        position: absolute;
        text-align: center;
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.2), 1px 1px 1px rgba(0, 0, 0, 0.2);
        text-align: center;
        border: 15px solid #ECECEC;
        box-sizing: border-box;
        cursor: default;
      }

      #viewport li.added {
        background: white;
      }

      #viewport li.in-deck:nth-child(3) {
        top: 2px;
        transform: translate(2px, 2px) rotate(0.4deg);
      }

      #viewport li.in-deck:nth-child(2) {
        top: 4px;
        transform: translate(-4px, -2px) rotate(-1deg);
      }

      #viewport li.in-deck:nth-child(4) {
        top: 2px;
        transform: translate(5px, 5px) rotate(1deg);
      }

      #viewport li.in-deck:nth-child(5) {
        top: 4px;
        transform: translate(-5px, -5px) rotate(-1deg);
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
    console.log entry
    audio = new Audio()
    audio.src = entry.preview_url
    audio.play()

    if entry.album is undefined  # instagram
      url = entry.images.standard_resolution.url
      description = entry.caption.text
    else # spotify
      url = entry.album.images[0].url
      description = "Track: " + entry.name
    $('<div id="white-background"></div><div id="image-div"></div><div id="viewport">
        <ul class="stack">
          <li class="in-deck"></li>
          <li class="in-deck"></li>
          <li class="in-deck"></li>
          <li class="in-deck"></li>
          <li class="in-deck"></li>
          <li class="in-deck"></li>
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

    $(".stack").prepend "<li id = 'active-entry' class='in-deck added'><img src=" + url +
     " width='100%'; height='200px'><div id='description'>" + description  + "</div></li>"
    stack = gajus.Swing.Stack()
    stack.createCard document.querySelector('.stack li.in-deck')

    stack.on 'throwout', (e) =>
      audio.pause()
      # right
      if e.throwDirection == 1
        window.tinder_no_entries.push entry

      # left
      if e.throwDirection != 1
        window.tinder_yes_entries.push entry

      e.target.remove()
      e.target.classList.remove("in-deck")
      cb()