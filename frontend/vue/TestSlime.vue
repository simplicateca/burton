<template>
    <div class="container">

        <div v-if="settings.text" v-html="settings.text"></div>

        <h2  v-else class="mx-auto text-center">
            Simple Vue Component
        </h2>

        <div class="my-10 relative h-24 max-w-2xl mx-auto">
            <div
                id="slime"
                ref="slime"
                class="aspect-square h-full"
            >
                &nbsp;
            </div>
        </div>
    </div>
</template>

<script>
    import { TimelineMax, Power0 } from "gsap/all";

    export default {
        mounted: function() {
            var slime = this.$refs.slime
            var tl    = new TimelineMax({repeat: -1})

            tl.to(slime, 2.50, {left: "80%", ease:Power0.easeInOut})
              .to(slime, 0.25, {rotationY: "+=180", left: "90%"})
              .to(slime, 2.50, {left: "20%", ease:Power0.easeInOut})
              .to(slime, 0.25, {rotationY: "+=180", left: "10%"});
        },

        props: ['settings']
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