const defaultTheme = require('tailwindcss/defaultTheme')

// module exports
module.exports = {
    content: [
        '../craftcms/modules/**/templates/**/*.{twig,sprig,html,json,svg}',
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
                current: 'currentColor',
                transparent: 'transparent',
                theme: {
                    // backgrounds
                    // bg-theme | bg-theme-tint | bg-theme-tint2 | bg-theme-alt
                    'DEFAULT'     : 'rgb( var(--background) / <alpha-value> )',
                    'tint'        : 'rgb( var(--background-tint) / <alpha-value> )',
                    'tint2'       : 'rgb( var(--background-tint2) / <alpha-value> )',
                    'alt'         : 'rgb( var(--bodycopy) / <alpha-value> )',

                    // text
                    // text-theme-headings | text-theme-bodycopy | text-theme-highlight
                    'headings'    : 'rgb( var(--headings) / <alpha-value> )',
                    'headings-alt': 'rgb( var(--headings-alt) / <alpha-value> )',
                    'headings1'   : 'rgb( var(--headings1) / <alpha-value> )',
                    'headings2'   : 'rgb( var(--headings2) / <alpha-value> )',
                    'headings3'   : 'rgb( var(--headings3) / <alpha-value> )',
                    'headings4'   : 'rgb( var(--headings4) / <alpha-value> )',
                    'bodycopy'    : 'rgb( var(--bodycopy) / <alpha-value> )',
                    'leadcopy'    : 'rgb( var(--leadcopy) / <alpha-value> )',
                    'highlight'   : 'rgb( var(--highlight) / <alpha-value> )',

                    // inline text links:
                    // text-theme-link | text-theme-link-tint
                    'link'        : 'rgb( var(--link) / <alpha-value> )',
                    'link-tint'   : 'rgb( var(--link-tint) / <alpha-value> )',
                    'link-tint2'  : 'rgb( var(--link-tint2) / <alpha-value> )',

                    // elements that you want to draw attention to:
                    // text-theme-accent | bg-theme-accent | bg-theme-accent-tint | text-theme-accent-alt
                    'accent'      : 'rgb( var(--accent)  / <alpha-value> )',
                    'accent-tint' : 'rgb( var(--accent-tint)  / <alpha-value> )',
                    'accent-alt'  : 'rgb( var(--accent-alt)  / <alpha-value> )',
                    'accent-alt2' : 'rgb( var(--accent-alt2)  / <alpha-value> )',
                }
            },
        }
    },

    plugins: [
        require('@tailwindcss/container-queries')
    ],
};
