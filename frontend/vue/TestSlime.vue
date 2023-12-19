<template>
    <div
        class="my-10 relative h-48 mx-auto max-w-5xl cursor-move @container"
        @mouseover="hover = true"
        @mouseleave="hover = false"
    >
        <h2 class="text-center opacity-50">{{ block.owner.title }}</h2>
        <p class="text-center max-w-2xl @container mx-auto opacity-50">{{ block.owner.dek }}</p>
        <div
            id="slime"
            ref="slime"
            class="aspect-square h-full"
        ></div>
    </div>
</template>

<script>
    import { TimelineMax, Power0 } from "gsap/all"

    export default
    {
        data() {
            return {
                timeline: new TimelineMax({repeat: -1}),
                hover: false
            }
        },

        watch: {
            hover( isHovering ) {
                if( isHovering ) {
                    this.timeline.pause()
                } else {
                    this.timeline.play()
                }
            }
        },

        props: {
            block: {
                type: Object,
                default: () => {}
            },
        },

        created () {
            this.timeline = new TimelineMax({repeat: -1})
        },

        mounted: function() {
            const slime = this.$refs.slime

            // @mouseover="hover = true"
            // @mouseleave="hover = false"
            let timeline = new TimelineMax({repeat: -1})
            timeline
              .to( slime, 2.50, {left: "70%", ease:Power0.easeInOut} )
              .to( slime, 0.25, {rotationY: "+=180", left: "80%"} )
              .to( slime, 2.50, {left: "15%", ease:Power0.easeInOut} )
              .to( slime, 0.25, {rotationY: "+=180", left: "5%"} )

            this.timeline = timeline
        }
    }
</script>

<style>
    #slime {
        background-image: url("https://res.cloudinary.com/epiphanystudios/image/upload/v1473966077/slime-green_qksmbp.png");
        background-size: contain;
        background-repeat: no-repeat;
        position: absolute;
        top: 0;
        left: 10%;
        z-index: 1;
    }
</style>
