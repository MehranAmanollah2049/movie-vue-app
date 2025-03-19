<script setup>

defineProps({
    color: {
        type: String,
        default: 'white'
    },
    bgColor: {
        type: String,
        default: 'transparent'
    },
    title: {
        type: String,
        default: null
    },
    isUnder: {
        type: Boolean,
        default: false
    }
})

</script>

<template>
    <div :class="{
        'loadingContainer': true,
        'isUnder': isUnder
    }">
        <svg class="loading-svg" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
        viewBox="25 25 50 50">

        <circle cx="50" cy="50" r="20" fill="none" stroke-width="6"
            stroke-linecap="round" :stroke="bgColor" stroke-dashoffset="0" stroke-dasharray="200, 300">

        </circle>
        <circle :stroke="color" cx="50" cy="50" r="20" fill="none" stroke-width="6"
            stroke-linecap="round" stroke-dashoffset="0" stroke-dasharray="100, 200">
            <animateTransform attributeName="transform" attributeType="XML" type="rotate" from="0 50 50" to="360 50 50"
                dur="2.5s" repeatCount="indefinite"></animateTransform>
            <animate attributeName="stroke-dashoffset" values="0;-30;-124" dur="1.25s" repeatCount="indefinite">
            </animate>
            <animate attributeName="stroke-dasharray" values="0,200;110,200;110,200" dur="1.25s"
                repeatCount="indefinite"></animate>
        </circle>
    </svg>
    <p v-if="title" class="loading-title" >{{ title }}</p>
    </div>
</template>


<style scoped>
@import '@/assets/css/components/loading.css';
</style>