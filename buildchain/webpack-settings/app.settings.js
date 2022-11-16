// app.settings.js

// node modules
require('dotenv').config();
const path = require('path');

// settings
module.exports = {
    alias: {
        'vue$': 'vue/dist/vue.esm.js',
        '@': path.resolve('../src'),
    },
    entry: {
        'app': [
            '@/js/app.js',
            '@/css/app.pcss'
        ],
    },
    extensions: [ '.tsx', '.ts', '.js', '.vue' ],
    name: 'Website Project',
    paths: {
        dist: path.resolve('../cms/web/dist/'),
    },
    urls: {
        criticalCss: 'http://example.test/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};
