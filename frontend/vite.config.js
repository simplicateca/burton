import {defineConfig} from 'vite';
import vue from '@vitejs/plugin-vue'
import legacy from '@vitejs/plugin-legacy';
import ViteRestart from 'vite-plugin-restart';
import viteCompression from 'vite-plugin-compression';
import manifestSRI from 'vite-plugin-manifest-sri';
import {visualizer} from 'rollup-plugin-visualizer';
import eslintPlugin from 'vite-plugin-eslint';
import {nodeResolve} from '@rollup/plugin-node-resolve';
//import critical from 'rollup-plugin-critical';
import {ViteFaviconsPlugin} from 'vite-plugin-favicon2';
import * as path from 'path';

// https://vitejs.dev/config/
export default defineConfig(({command}) => ({
    base: command === 'serve' ? '' : '/dist/',
    build: {
        emptyOutDir: true,
        manifest: true,
        outDir: '../craftcms/web/dist',
        rollupOptions: {
            input: {
                app: './js/app.js'
            },
            output: {
                sourcemap: true
            },
        }
    },

    plugins: [
        // critical({
        //     criticalUrl: 'https://replaceme.com/',
        //     criticalBase: '../craftcms/web/dist/criticalcss/',
        //     criticalPages: [
        //         {uri: '/', template: 'index'},
        //     ],
        //     criticalConfig: {}
        // }),
        legacy({
            targets: ['defaults', 'not IE 11']
        }),
        nodeResolve({
            moduleDirectories: [
                path.resolve('./node_modules'),
            ],
        }),
        ViteFaviconsPlugin({
            logo: "./public/static/favicon-src.png",
            inject: false,
            outputPath: 'favicons',
        }),
        ViteRestart({
            reload: [
                './templates/**/*',
                './vue/**/*',
            ],
        }),
        vue(),
        viteCompression({
            filter: /\.(js|mjs|json|css|map)$/i
        }),
        manifestSRI(),
        visualizer({
            filename: '../craftcms/web/dist/assets/stats.html',
            template: 'treemap',
            sourcemap: true,
        }),
        eslintPlugin({
            cache: false,
        }),
    ],
    clearScreen: false,
    publicDir: './public',
    resolve: {
        alias: {
            '@': path.resolve(__dirname)
        },
        preserveSymlinks: true,
    },

    server: {
        fs: {
            strict: false
        },
        host: '0.0.0.0',
        origin: 'http://localhost:3000',
        port: 3000,
        strictPort: true
    }
}));
