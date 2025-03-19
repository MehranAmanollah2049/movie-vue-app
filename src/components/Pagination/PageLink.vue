<script setup>

defineProps({
    title: {
        type: [String,Number]
    },
    isMore: {
        type: Boolean,
        default: false
    },
    isActive: {
        type: Boolean,
        default: false
    }
})

</script>

<template>
    <div :class="{
        'page': true,
        'active': isActive
    }">{{ isMore ? '...' : title }}</div>
</template>


<style scoped>
@import '@/assets/css/components/Pagination/Pagination.css';
</style>