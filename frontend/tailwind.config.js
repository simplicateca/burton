const defaultTheme = require('tailwindcss/defaultTheme')

// module exports
module.exports = {
  content: [
    '../cms/templates/**/*.{twig,html,json}',
    './vue/**/*.{vue,html}'
  ],
  theme: {
    fontSize: {
      'xs': '0.7rem',
      'sm': '0.85rem',
      'base': '0.95rem',
      'lg': '1.15rem',
      'xl': '1.30rem',
      '2xl': '1.60rem',
      '3xl': '1.90rem',
      '4xl': '2.40rem',
      '5xl': '3.0rem',
      '6xl': '3.50rem',
      '7xl': '4.0rem',
      '8xl': '5.50rem',
      '9xl': '7.0rem',
    },

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
      'tall': { 'raw': '(min-height: 900px)' },
      ...defaultTheme.screens,
    },

    extend: {
      fontFamily: {
        display:  ["Rubik"],
        headline: ["Rubik"],
        body:     ["Roboto Mono"],
      },

      lineHeight: {
        'extra-tight': '1.15'
      },

      colors: {
        transparent: 'transparent',
        current: 'currentColor'
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
