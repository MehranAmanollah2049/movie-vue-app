<script setup>
import { RouterLink } from 'vue-router';


defineProps({
    title: String,
    isActive: Boolean,
    path: {
        type: [Object,Boolean],
        default: false
    }
})

let emits = defineEmits(['clickEvent'])

</script>

<template>
    <div :class="{
        'NavItem': true,
        'active': isActive
    }" v-if="path == false" @click="emits('clickEvent')">
        <div class="icon">
            <slot />
        </div>
        <p>{{ title }}</p>
    </div>
    <RouterLink :to="path" :class="{
        'NavItem': true,
        'active': isActive
    }" v-if="path != false">
        <div class="icon">
            <slot />
        </div>
        <p>{{ title }}</p>
    </RouterLink>
</template>

<style scoped>
@import '@/assets/css/components/Menu/NavBar/NavBar.css';
</style>