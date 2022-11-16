<template>
    <div class="cVueExample">
        <div ref="slime" id="slime"></div>
    </div>
</template>

<script>
    import { TimelineMax, Power0 } from "gsap/all"; 

    export default {
        mounted: function() {
            var slime = this.$refs.slime
            var tl    = new TimelineMax({repeat: -1})

            tl.to(slime, 4, {left: "80%", ease:Power0.easeInOut})
              .to(slime, 1, {rotationY: "+=180"})
              .to(slime, 4, {left: "15%", ease:Power0.easeInOut})
              .to(slime, 1, {rotationY: "+=180"});
        }
    }
</script>

<style>
    .cVueExample {
        @apply mb-10 relative h-20;
    }

    #slime {
        @apply aspect-square h-full;
        background-image: url("https://res.cloudinary.com/epiphanystudios/image/upload/v1473966077/slime-green_qksmbp.png");
        background-size: contain;
        background-repeat: no-repeat;
        position: absolute;
        top: 0;
        left: 25%;
        z-index: 1;
    }
</style>

