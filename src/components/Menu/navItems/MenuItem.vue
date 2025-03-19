<script setup>

import { toast } from '@/composables/AlertToast';
import { RouterLink } from 'vue-router'

defineProps({
    title: String,
    path: {
        type: String,
        default: '/'
    }
})

</script>

<template>
    <!-- <RouterLink :to="path" class="MenuItem">{{ title }}</RouterLink> -->
    <div @click="toast('این بخش ها هنوز در دسترس قرار ندارند','warning')" class="MenuItem" >{{ title }}</div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/navItems/Item.css';
</style>