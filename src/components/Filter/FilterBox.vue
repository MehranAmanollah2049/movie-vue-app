<script setup>
import { ref , onMounted } from 'vue';


let props = defineProps({
    title: String,
})

let isOpen = ref(false);
let ContentElem = ref(null)
let Height = ref(0)

let toggleOpen = () => {
    isOpen.value = !isOpen.value

    calculateHeight()
    if(!isOpen.value)
    {
        Height.value = 0
    }
}


let calculateHeight = () => {
    if(isOpen.value) {
        Height.value = ContentElem.value.clientHeight
    }
}

onMounted(() => calculateHeight())


</script>

<template>
    <div :class="{
        'FilterBox': true,
        'active': isOpen
    }">
        <div class="topFilter" @click="toggleOpen">
            <div class="rightTop">
                <slot name="icon" />
                <p class="title_filter">{{ title }}</p>
            </div>
            <svg class="arrow" fill="none" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
        </div>
        <div class="bottomFilter" :style="{ height: Height + 'px' }">
            <div class="bottomContentFilter" ref="ContentElem" @vue:Updated="calculateHeight">
                <slot />
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Filter/FilterBox.css';
</style>