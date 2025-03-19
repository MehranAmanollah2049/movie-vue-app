<script setup>

import { RouterLink } from 'vue-router';

let emits = defineEmits(['clickEvent'])

</script>

<template>
    <RouterLink to="/" class="logo" @click="emits('clickEvent')">
        <img src="/images/zarfilm-logo-white.png" alt="">
    </RouterLink>
</template>