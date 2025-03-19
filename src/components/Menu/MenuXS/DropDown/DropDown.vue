<script setup>
import { ref , onMounted , onBeforeUnmount } from 'vue';


let isOpen = ref(true)
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
        'DropDown': true,
        'active': isOpen
    }">
        <div class="top_drp" @click="toggleOpen">
            <div class="title">
                <svg class="icon category_icon">
                    <use xlink:href="#category">
                        <symbol viewBox="0 0 24 25" id="category">
                            <path
                                d="M7.24 2.5H5.34C3.15 2.5 2 3.65 2 5.83V7.73C2 9.91 3.15 11.06 5.33 11.06H7.23C9.41 11.06 10.56 9.91 10.56 7.73V5.83C10.57 3.65 9.42 2.5 7.24 2.5Z">
                            </path>
                            <path opacity="0.4"
                                d="M18.6704 2.5H16.7704C14.5904 2.5 13.4404 3.65 13.4404 5.83V7.73C13.4404 9.91 14.5904 11.06 16.7704 11.06H18.6704C20.8504 11.06 22.0004 9.91 22.0004 7.73V5.83C22.0004 3.65 20.8504 2.5 18.6704 2.5Z">
                            </path>
                            <path
                                d="M18.6704 13.93H16.7704C14.5904 13.93 13.4404 15.08 13.4404 17.26V19.16C13.4404 21.34 14.5904 22.49 16.7704 22.49H18.6704C20.8504 22.49 22.0004 21.34 22.0004 19.16V17.26C22.0004 15.08 20.8504 13.93 18.6704 13.93Z">
                            </path>
                            <path opacity="0.4"
                                d="M7.24 13.93H5.34C3.15 13.93 2 15.08 2 17.26V19.16C2 21.35 3.15 22.5 5.33 22.5H7.23C9.41 22.5 10.56 21.35 10.56 19.17V17.27C10.57 15.08 9.42 13.93 7.24 13.93Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
                دسته بندی ها
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
            <div class="bottom_content" ref="ContentElem">
                <slot />
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/MenuXS/DropDown/DropDown.css';
</style>