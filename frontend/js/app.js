// Import our CSS
import '@/css/app.pcss';

import gsap from "gsap";
import { ScrollTrigger, Power3 } from "gsap/all";

// wrap the main app in an async function
// delay importing packages until absolutely necessary
const main = async() => {

    gsap.registerPlugin(ScrollTrigger)

    gsap.utils.toArray("[data-monitor]").forEach(el => {
        ScrollTrigger.create({
            trigger: el,
            onToggle: (self) => el.setAttribute("data-visible", self.isActive ? "in" : "out"),
            onEnter : ()     => el.setAttribute("data-entered", true),
            onLeave : ()     => el.setAttribute("data-left",    true)
        });
    });

    return {
        gsap,
        ScrollTrigger,
        Power3,
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