// Import our CSS
import '@/css/app.pcss';

import {createApp} from 'vue';
import "@lottiefiles/lottie-player";

import gsap from "gsap";
import { ScrollTrigger, Power3 } from "gsap/all";

// wrap the main app in an async function
// delay importing packages until absolutely necessary
const main = async() => {

    const app = {
        // async createSlime(el) {
        //     const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue')
        //     return new Vue({
        //         el: el,
        //         components: {
        //             'slime': () => import(/* webpackChunkName: "slime" */ '@/vue/Slime.vue')
        //         }
        //     })
        // }
    }

    gsap.registerPlugin(ScrollTrigger)

    gsap.utils.toArray("[data-viewport]").forEach(el => {
        ScrollTrigger.create({
            trigger: el,
            onToggle: self => el.setAttribute("data-visible", self.isActive ? "in" : "out"),
            onEnter : self => el.setAttribute("data-entered", true),
            onLeave : self => el.setAttribute("data-left",    true)
        });
    });

    app.gsap = gsap
    app.ScrollTrigger = ScrollTrigger
    app.Power3 = Power3

    return app
}

// execute async function
main().then( (app) => {
    window.app = app
});

// Accept HMR as per: https://vitejs.dev/guide/api-hmr.html
if (import.meta.hot) {
    import.meta.hot.accept(() => {
        console.log("HMR")
    });
}
