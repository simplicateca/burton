/**
 * Gearbox - Craft Admin JS
 */

if (typeof Craft.Gearbox === 'undefined') {
    Craft.Gearbox = {};
}

// Sidebar Entry Types / Section Navigation
// per: https://github.com/ethercreative/sidebar-entrytypes
// but with some small UX improvements
Craft.Gearbox.SectionSubNav = {

    linkObserver: new MutationObserver(function(mutations) {
        const className = mutations[0].target.className ?? null
        if( className == 'sel' ) { 
            Craft.Gearbox.SectionSubNav.selected = mutations[0].target

            if( typeId = mutations[0].target.dataset.typeId ) {
                Craft.Gearbox.SectionSubNav.lastSubType = typeId
            }            
        }
    }),

    toggleObserver: new MutationObserver(function(mutations) {
        const toggle   = mutations[0].target
        const expanded = toggle.getAttribute('aria-expanded') ?? null
        if( expanded == 'false' ) {
            const lastSubType = Craft.Gearbox.SectionSubNav.lastSubType ?? null
            const parentLi    = toggle.closest('li')

            if( lastSubType && parentLi.querySelector(`ul li a[data-type-id="${typeId}"]`) ) {
                Craft.Gearbox.SectionSubNav.simulateClick( parentLi.querySelector('a') )               
            }
        }
    }),

    headerObserver: new MutationObserver(function(mutations) {
        const active    = Craft.Gearbox.SectionSubNav.selected   ?? null
        const entryType = active.dataset.entryType ?? null
        const typeId    = active.dataset.typeId    ?? null
        const handle    = active.dataset.handle    ?? null
        if( active && entryType == '' && typeId != null ) {

            const button = document.querySelector('header#header div#action-buttons button.submit.add')           
            
            // remove event listeners from button by cloning it
            const clone  = button.cloneNode(true)           
        
            // add new event listener    
            Craft.Gearbox.SectionSubNav.addMultipleListeners( clone.firstElementChild, "click mousedown", (event) => {
                const newUrl = Craft.getUrl(`entries/${handle}/new?typeId=${typeId}`)

                if (
                    ((event.type === 'click'     && Garnish.isCtrlKeyPressed(event)) ||
                     (event.type === 'mousedown' && event.button === 1))
                   ) {
                    window.open(newUrl);
                } else {
                    window.location = newUrl;
                }
            })

            // replace the button with the clone
            button.replaceWith(clone)
        }
    }),

    addMultipleListeners( element, eventNames, listener ) {
        var events = eventNames.split(' ');
        for( var i=0, iLen=events.length; i<iLen; i++ ) {
            element.addEventListener(events[i], listener, false);
        }
    },

    simulateClick(elem) {

        // Create our event (with options)
        var evt = new MouseEvent('click', {
            bubbles: true,
            cancelable: true,
            view: window
        });

        // If cancelled, don't dispatch our event
        var canceled = !elem.dispatchEvent(evt);
    },

    init() {
        const sectionLinks = document.querySelectorAll('#sidebar ul li a[data-type]');

        if( sectionLinks.length ) {
            sectionLinks.forEach((link) => {
                this.linkObserver.observe(link, {
                    attributes: true
                });
            });

            this.headerObserver.observe( document.querySelector('header#header div#action-buttons'), {
                childList: true
            });

            // const toggleButtons = document.querySelectorAll('#sidebar ul li button.toggle');
            // toggleButtons.forEach((button) => {
            //     this.toggleObserver.observe(button, {
            //         attributes: true
            //     });
            // });
        }
    }
};

document.addEventListener('DOMContentLoaded', (event) => {
    Craft.Gearbox.SectionSubNav.init()
});