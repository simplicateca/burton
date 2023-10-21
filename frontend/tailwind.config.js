const defaultTheme = require('tailwindcss/defaultTheme')

// module exports
module.exports = {
    content: [
        '../craftcms/templates/**/*.{twig,sprig,html,json,svg}',
        './vue/**/*.{vue,html}'
    ],
    theme: {
        // fontSize: {
        //     'xs'  : '',
        //     'sm'  : '',
        //     'base': '',
        //     'lg'  : '',
        //     'xl'  : '',
        //     '2xl' : '',
        //     '3xl' : '',
        //     '4xl' : '',
        //     '5xl' : '',
        //     '6xl' : '',
        //     '7xl' : '',
        //     '8xl' : '',
        //     '9xl' : '',
        // },

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
                'slide-in-up': 'slideinup 0.25s ease-out forwards 0.1s',
            },

            keyframes: {
                slideinup: {
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
		100: 100,
                max: 999,
            },

            scale: {
                '-1': '-1'
            },

            colors: {
                transparent: 'transparent',
                current: 'currentColor',
                //blue: {
                //    DEFAULT: '#219EBC',
                //    light: '#219EBC',
                //    medium: '#008cac',
                //    dark: '#023047',
                //},
            },
        }
    },

    plugins: [
        require('@tailwindcss/container-queries'),
        // ...
    ],
};
