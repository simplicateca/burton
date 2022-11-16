const defaultTheme = require('tailwindcss/defaultTheme')

// module exports
module.exports = {
  content: [
    '../cms/templates/**/*.{twig,html,json}',
    '../src/vue/**/*.{vue,html}',
    '../src/css/components/**/*.pcss'
  ],
  theme: {
    container: {
      center: true,
      padding: {
        DEFAULT: '1rem',
        sm: '2rem',
        md: '1rem',
        lg: '2rem',
        xl: '3rem',
        '2xl': '3rem',
      }
    },

    screens: {
      'xs': '360px',
      'tall': { 'raw': '(min-height: 800px)' },
      ...defaultTheme.screens,
    },

    extend: {
      fontFamily: {
        display:  ["TitanOne", "sans-serif"],
        headline: ["OverlockOblique", "sans-serif"],
        body:     ["Mulish", "sans-serif"],
      },

      colors: {
        transparent: 'transparent',
        current: 'currentColor'

        // 'grey': '#eeeeee',
        // 'blue': '#1d70b8'
      },

      typography: (theme) => ({
        DEFAULT: {
          css: {
            maxWidth: '100%'
          },
        },
      }),
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
    // ...
  ],
};