<script setup>
import { ref , onMounted , onBeforeUnmount } from 'vue';


defineProps({
    title: String,
})

let isOpen = ref(false)
let Height = ref(0)
let ContentElem = ref(null)
let transitionParent = ref('0.4s ease-in-out')
let observer = null;

let toggleOpen = () => {

transitionParent.value = '0.4s ease-in-out'
isOpen.value = !isOpen.value

calculateHeight()
if (!isOpen.value) {
    Height.value = 0
}
}


let calculateHeight = () => {
if (isOpen.value) {
    Height.value = ContentElem.value.clientHeight
}

}

onMounted(() => {
observer = new ResizeObserver((entries) => {
    for (let entry of entries) {
        if (entry.target === ContentElem.value) {
            calculateHeight()
        }
    }
});
observer.observe(ContentElem.value);
})


onBeforeUnmount(() => {
if (observer) {
    observer.disconnect();
}
});

</script>

<template>
    <div :class="{
        'Section': true,
        'active': isOpen
    }">
        <div class="top_drp" @click="toggleOpen">
            <div class="title">
                <slot name="icon" />
                {{ title }}
            </div>
            <svg class="icon down_icon">
                <use xlink:href="#down_icon">
                    <symbol viewBox="0 0 21 21" id="down_icon">
                        <path
                            d="M10.0973 11.4767L13.6331 7.94082C13.9585 7.61543 14.4861 7.61543 14.8114 7.94082C15.1368 8.26621 15.1368 8.79377 14.8114 9.11915L10.8853 13.0453C10.4501 13.4805 9.74446 13.4805 9.30923 13.0453L5.38311 9.11915C5.05772 8.79377 5.05772 8.26621 5.38311 7.94082C5.7085 7.61543 6.23606 7.61543 6.56145 7.94082L10.0973 11.4767Z">
                        </path>
                    </symbol>
                </use>
            </svg>
        </div>
        <div class="bottom_drp" :style="{ height: Height + 'px',transition: transitionParent }" @click="transitionParent = '0s'">
            <div class="bottom_content" ref="ContentElem" >
                <slot />
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/MenuXS/DropDown/Section.css';
</style>