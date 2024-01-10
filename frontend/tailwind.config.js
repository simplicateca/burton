const defaultTheme = require('tailwindcss/defaultTheme')

const blockColors =
{
    // background colours.
    // accessibly in tailwind by:
    // bg-canvas / bg-canvas-light / bg-canvas-dark
    canvas: {
        DEFAULT: 'var(--theme-canvas)',
        light  : 'var(--theme-canvas-light)',
        dark   : 'var(--theme-canvas-dark)',
    },

    // foreground / text colours.
    // accessibly in tailwind by:
    // text-theme / border-theme-accent / etc
    theme: {
        DEFAULT : 'var(--theme-text)',
        lead    : 'var(--theme-text)',
        light   : 'var(--theme-text-light)',
        dark    : 'var(--theme-text-dark)',
        accent  : 'var(--theme-accent)',
        headline: 'var(--theme-headline)',
        eyebrow : 'var(--theme-eyebrow)',
    },

    // link & button colours.
    // accessibly in tailwind by:
    // text-link / bg-button-base / etc / etc
    link: {
        DEFAULT: 'var(--theme-link)',
        base   : 'var(--theme-link-bg)',
        active : 'var(--theme-link-active)',
        'active-base': 'var(--theme-link-active-bg)',
    },

    button: {
        DEFAULT: 'var(--theme-btn)',
        base   : 'var(--theme-btn-bg)',
        border : 'var(--theme-btn-b)',
        active : 'var(--theme-btn-active)',
        'active-base': 'var(--theme-btn-active-bg)',
        'active-border': 'var(--theme-btn-active-b)',
    },
}

// module exports
module.exports = {
    content: [
        '../craftcms/templates/**/*.{twig,sprig,html,json,svg}',
        './vue/**/*.{vue,html}'
    ],
    theme: {
        container: {
            center: true,
            padding: {
                DEFAULT: '1rem',
                sm: '2rem'
            }
        },

        screens: {
            '2xs': '280px',
            'xs': '360px',
            'tall': { 'raw': '(min-height: 900px)' },
            'max-lg': {'max': '1023px'},
            ...defaultTheme.screens,
        },

        extend: {
            fontFamily: {
                display:  ["Rubik"],
                headline: ["Rubik"],
                body:     ["Roboto Mono"],
            },

            containers: {
                '2xs': '16rem'
            },

            animation: {
                'slideInUp': 'slideInUp 0.25s ease-out forwards 0.1s',
            },

            keyframes: {
                slideInUp: {
                  '0%'  : { transform: 'translateY(20px)', opacity: 0 },
                  '100%': { transform: 'translateY(0)',    opacity: 1 },
                },
            },

            maxWidth: {
                '2xs': '16rem',
            },

            zIndex: {
		        100: 100
            },

            scale: {
                '-1': '-1'
            },

            colors: {
                ...blockColors,
                'next-theme': blockColors,
                'prev-theme': blockColors,
                transparent : 'transparent',
                current     : 'currentColor',
            },
        }
    },

    plugins: [
        require('@tailwindcss/container-queries')
    ],
};
