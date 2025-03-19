<script setup>

defineProps({
    title: String,
    id: Number
})

let drpActivelide = defineModel('modelValue');
let emits = defineEmits(['update:modelValue'])

</script>

<template>
    <div :class="{
        'DrpItem': true,
        'active': drpActivelide == id
    }" @mouseover="emits('update:modelValue',id)">
        <slot />
        <span>{{ title }}</span>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/navItems/DrpItem.css';
</style>