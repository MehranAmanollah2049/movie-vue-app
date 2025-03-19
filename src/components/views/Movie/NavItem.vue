<script setup>

defineProps({
    title: String,
    count: {
        type: [Number, Boolean],
        default: false
    },
    isActive: {
        type: Boolean,
        default: false
    },
})

let emits = defineEmits(['clickEvent']);

</script>

<template>
    <div :class="{
        'NavItem': true,
        'active': isActive
    }" @click="emits('clickEvent')">
        <div class="count" v-if="count">{{ count }}</div>
        <slot />
        <p>{{ title }}</p>
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/NavItem.css';
</style>