<script setup>
import { toast } from '@/composables/AlertToast';
import { computed } from 'vue';
import { RouterLink } from 'vue-router';


let props = defineProps({
    title: String,
    count: Number,
    path: {
        type: Object,
        default: {path: '/'}
    },
    border: {
        type: Boolean,
        default: false
    },
    text: {
        type: String,
        default: ''
    }
})


let numberFormat = computed(() => props.count.toLocaleString())

let emits = defineEmits(['clickEvent'])

</script>

<template>
    <RouterLink v-if="count != 0 && text == ''" :to="path" :class="{
        'DrpBox': true,
        'border': border
    }" @click="emits('clickEvent')">
        <p>{{ title }} <span v-if="count >= 0">({{ numberFormat }})</span></p>
    </RouterLink>
    <div @click="toast('این بخش ها هنوز در دسترس قرار ندارند','warning')" v-if="text != ''" :to="path" :class="{
        'DrpBox': true,
        'border': border
    }">
        <p>{{ title }} <span class='sm'>({{ text }})</span></p>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/navItems/DrpBox.css';
</style>