<script setup>
import { RouterLink, RouterView, useRoute } from 'vue-router'

let router = useRoute()

</script>

<template>
    <div class="AutheticationContainer">
        <div :class="{'authSection':true, 'verify': (router.name == 'auth.verify'),'top': (router.name == 'auth.forget-password' || router.name == 'auth.change-password')}">
            <div class="pagesContent" v-if="(router.name != 'auth.verify' && router.name != 'auth.forget-password' && router.name != 'auth.change-password')">
                <RouterLink :to="{name:'auth.login'}" :class="{
                    'active': router.name == 'auth.login'
                }">ورود</RouterLink>
                <RouterLink :to="{name:'auth.register'}" :class="{
                    'active': router.name == 'auth.register'
                }">عضویت</RouterLink>
            </div>
            <RouterView />
        </div>
    </div>    
</template>


<style scoped>
@import '@/assets/css/views/authentication/authentication.css';
</style>