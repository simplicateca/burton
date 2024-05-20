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

    // this is a super simple way to add scrolltriggered (but not scroll-locked)
    // animations to the entrance or exit of any element.
    //
    // eg.
    // 1) add the `data-scrolltrigger` to the element you want to animate
    //
    // 2) Add something like the following css to your stylesheet
    //
    //    .your-element { opacity: 0; transform: translateY(30px); transition: all 0.2s; }
    //    .your-element[data-entered] { opacity: 1; transform: translateY(0px); }
    //    .your-element[data-left] { opacity: 0; transform: translateY(-30px); }
    //
    gsap.utils.toArray("[data-scrolltrigger]").forEach(el => {
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
        vueSampleComponent: defineAsyncComponent(() =>
            import('@/vue/SampleComponent.vue')
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