<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue';

defineProps({
    data: Object
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
        'Season': true,
        'active': isOpen
    }">
        <div class="topSeason" @click="toggleOpen">
            <div class="right_season">
                <p class="title">
                    <svg class="icon squaredl_icon">
                        <use xlink:href="#squaredl">
                            <symbol viewBox="0 0 100 100" id="squaredl">
                                <path
                                    d=" M 33.29 5.31 C 43.88 5.17 54.47 5.28 65.06 5.26 C 72.88 5.45 81.34 7.13 87.12 12.81 C 92.86 18.60 94.55 27.12 94.74 34.99 C 94.74 45.32 94.79 55.66 94.72 65.99 C 94.41 73.75 92.52 82.12 86.65 87.63 C 80.84 92.98 72.63 94.56 64.98 94.74 C 54.96 94.75 44.95 94.76 34.94 94.74 C 27.10 94.56 18.64 92.86 12.86 87.16 C 7.12 81.37 5.44 72.85 5.26 64.98 C 5.26 54.65 5.21 44.32 5.28 33.99 C 5.61 26.47 7.35 18.41 12.82 12.88 C 18.17 7.53 25.98 5.72 33.29 5.31 M 26.41 12.62 C 22.14 13.57 18.00 15.84 15.53 19.54 C 12.48 24.05 11.78 29.66 11.51 34.97 C 11.49 44.99 11.49 55.02 11.51 65.05 C 11.79 71.23 12.78 78.04 17.34 82.65 C 21.96 87.23 28.80 88.22 35.01 88.49 C 45.01 88.51 55.02 88.51 65.02 88.48 C 71.21 88.22 78.00 87.21 82.64 82.70 C 87.20 78.06 88.22 71.23 88.49 65.01 C 88.51 55.02 88.51 45.02 88.49 35.03 C 88.28 27.75 86.63 19.25 79.90 15.17 C 71.80 10.34 61.96 11.71 52.95 11.50 C 44.11 11.81 35.12 10.65 26.41 12.62 Z">
                                </path>
                                <path
                                    d=" M 47.11 25.94 C 47.89 23.37 51.09 23.77 52.87 25.08 C 53.70 34.22 53.04 43.43 53.25 52.61 C 55.92 50.14 58.21 47.23 61.15 45.07 C 63.86 43.43 67.13 47.39 65.02 49.70 C 60.52 54.39 56.00 59.12 51.15 63.46 C 50.58 63.46 49.44 63.47 48.87 63.47 C 44.17 59.37 39.95 54.72 35.51 50.34 C 32.59 48.28 35.73 43.22 38.87 45.08 C 41.89 47.34 44.27 50.32 47.01 52.89 C 47.07 43.91 46.84 34.92 47.11 25.94 Z">
                                </path>
                            </symbol>
                        </use>
                    </svg>
                    {{ data.title }} 
                </p>
                <div class="status">{{ data.isLast ? 'فصل پایانی' : data.status }}</div>
            </div>
            <div class="left_season">
                <div class="arrow">
                    <svg class="icon arrow_down_icon">
                        <use xlink:href="#arrow_down">
                            <symbol viewBox="0 0 10 6" id="arrow_down">
                                <path
                                    d="M5.0006 3.97656L8.53643 0.440729C8.86182 0.115341 9.38938 0.115341 9.71477 0.440729V0.440729C10.0402 0.766117 10.0402 1.29367 9.71477 1.61906L5.78864 5.54518C5.35342 5.98041 4.64778 5.98041 4.21255 5.54518L0.286432 1.61906C-0.0389555 1.29367 -0.0389554 0.766117 0.286432 0.440729V0.440729C0.61182 0.115341 1.13938 0.115341 1.46477 0.440729L5.0006 3.97656Z">
                                </path>
                            </symbol>
                        </use>
                    </svg>
                </div>
            </div>
        </div>
        <div class="bottomSeason" :style="{ height: Height + 'px',transition: transitionParent }" @click="transitionParent = '0s'">
            <div class="bottomContent" ref="ContentElem">
                <slot />
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/download/SeriesDownload/Season.css';
</style>