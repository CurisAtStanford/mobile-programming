class @block_orientation_

    constructor: ()->
        css = """
        """
        $("<style type='text/css'></style>").html(css).appendTo "head" 

        $("""
        <div class="drag-wrap draggable" name="orientation">
            ORIENTATION
        </div>
        """).appendTo ".drag-zone"

    run: ()=>

        #     <div class='draggable block1'>ORIENTATION</div>
        #     <div id="swiper-container-reg" class="swiper-container swiper-container-reg">
        #         <div class="swiper-wrapper">
        #             <div class="swiper-slide stop-swiping standing">
        #                 STANDING
        #             </div>
        #             <div class="swiper-slide stop-swiping head-stand">
        #                 HEAD
        #             </div>
        #             <div class="swiper-slide stop-swiping face-plant">
        #                 FACE
        #             </div>
        #              <div class="swiper-slide stop-swiping tanning">
        #                 TANNING
        #             </div>
        #              <div class="swiper-slide stop-swiping napping">
        #                 NAPPING
        #             </div>
        #         </div>
        #         <div class="swiper-button-next"><i class="fa fa-chevron-right fa-3x"></i></div>
        #         <div class="swiper-button-prev"><i class="fa fa-chevron-left fa-3x"></i></div>
        #     </div>
        # </div>
