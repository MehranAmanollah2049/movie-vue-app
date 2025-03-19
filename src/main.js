import '@/assets/css/main.css'
import '../node_modules/nprogress/nprogress.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'
import nprogress from 'nprogress'


const app = createApp(App)

nprogress.configure({
    showSpinner: false,
    spped: 1000,
    easing: 'linear'
});

app.use(createPinia())
app.use(router)

app.mount('#app')
