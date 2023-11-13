const defaultTheme = require('tailwindcss/defaultTheme')

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
                DEFAULT: '2rem'
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

            //backgroundImage: {
            //    '': "url('')",
            //},

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
                transparent: 'transparent',
                current    : 'currentColor',

                theme: {
                    DEFAULT: 'var(--primaryColor)',
                    foreground: 'var(--primaryColor)',
                    accent    : 'var(--accentColor)',
                    background: 'var(--backgroundColor)',
                    backgroundOff: 'var(--backgroundColorOff)',
                    section: 'var(--sectionBackgroundColor)',
                },

                next: {
                    'block-bg': 'var(--backgroundColorNext)',
                },

                prev: {
                    'block-bg': 'var(--backgroundColorPrev)',
                },

                hilite: {
                    DEFAULT : 'var(--hiliteColor)',
                    alt     : 'var(--hiliteAltColor)',
                },

                shade: {
                   DEFAULT : 'var(--shadeColor)',
                   light   : 'var(--shadeLightColor)',
                   dark    : 'var(--shadeDarkColor)',
                }
            },
        }
    },

    plugins: [
        require('@tailwindcss/container-queries')
    ],
};
