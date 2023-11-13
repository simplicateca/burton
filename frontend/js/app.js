// Import our CSS
import '@/css/app.pcss';

// eslint-disable-next-line no-unused-vars
import {createApp, defineAsyncComponent} from 'vue';
import "@lottiefiles/lottie-player";
import gsap from "gsap";
import { ScrollTrigger, Power3 } from "gsap/all";

// wrap the main app in an async function
// delay importing packages until absolutely necessary
const main = async() => {

    gsap.registerPlugin(ScrollTrigger)

    gsap.utils.toArray("[data-viewport]").forEach(el => {
        ScrollTrigger.create({
            trigger: el,
            onToggle: (self) => el.setAttribute("data-visible", self.isActive ? "in" : "out"),
            onEnter : ()     => el.setAttribute("data-entered", true),
            onLeave : ()     => el.setAttribute("data-left",    true)
        });
    });

    return {
        gsap: gsap,
        ScrollTrigger: ScrollTrigger,
        Power3: Power3,
        createApp: createApp,
        vueTestSlime: defineAsyncComponent(() =>
            import('@/vue/TestSlime.vue')
        )
    }
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