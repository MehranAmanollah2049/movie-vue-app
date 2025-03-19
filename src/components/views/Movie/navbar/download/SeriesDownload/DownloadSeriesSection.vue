<script setup>
import {onMounted, ref} from 'vue'

defineProps({
    type: Number,
    data: Object
})

let isOpen = ref(false)
let Height = ref(0)
let ContentElem = ref(null)

let toggleOpen = () => {
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

onMounted(() => calculateHeight())


</script>

<template>
    <div :class="{
        'DownloadSeriesSection': true,
        'active': isOpen,
        'type-0': type == 0,
        'type-1': type == 1,
        'type-2': type == 2,
    }">
        <div class="title_bg">{{ type == 0 ? 'زیرنویس' : type == 1 ? 'دوبله' : 'نسخه بدون زیرنویس' }}</div>
        <div class="DownloadSeriesSection-inner">
            <div class="topSection" @click="toggleOpen">
                <div class="right_section">
                    <p class="quality">
                        <svg class="icon import_icon">
                            <use xlink:href="#import">
                                <symbol viewBox="0 0 250 250" id="import">
                                    <path
                                        d=" M 116.77 41.95 C 116.66 38.30 119.26 34.62 122.92 33.95 C 127.34 32.77 132.49 36.37 132.49 41.04 C 132.52 70.48 132.49 99.92 132.50 129.35 C 137.02 124.91 141.43 120.37 145.95 115.95 C 149.02 112.75 154.71 113.12 157.44 116.56 C 159.98 119.51 159.85 124.34 157.06 127.07 C 148.08 136.06 139.09 145.03 130.12 154.02 C 127.23 157.02 121.93 156.98 119.09 153.95 C 110.55 145.46 102.09 136.91 93.54 128.44 C 91.43 126.52 89.71 123.88 90.24 120.89 C 90.28 114.98 98.18 111.59 102.67 115.28 C 107.59 119.64 112.00 124.56 116.75 129.11 C 116.76 100.06 116.73 71.00 116.77 41.95 Z">
                                    </path>
                                    <path
                                        d=" M 39.41 119.64 C 44.06 117.34 50.29 120.96 50.44 126.19 C 50.40 142.84 54.80 159.83 64.73 173.38 C 75.26 188.27 92.17 198.03 110.05 200.98 C 125.85 203.57 142.51 202.57 157.44 196.53 C 171.62 190.91 183.78 180.35 191.23 167.04 C 198.04 155.21 201.20 141.51 201.38 127.92 C 201.26 125.16 202.09 122.15 204.49 120.54 C 208.08 117.72 214.11 118.81 216.15 123.00 C 217.74 125.74 217.07 129.02 217.01 132.02 C 216.13 154.36 207.51 176.75 191.52 192.63 C 177.46 207.01 157.96 215.38 138.09 217.44 C 118.96 219.40 99.02 216.94 81.75 208.15 C 64.51 199.61 50.65 184.73 42.95 167.14 C 37.36 154.56 34.69 140.73 34.74 126.99 C 34.59 123.87 36.58 120.88 39.41 119.64 Z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                       <span> کیفیت: {{ data.quality }}</span>
                    </p>
                    <p class="episodes">تعداد قسمت : {{ data.episodes.length }}</p>
                    <p class="disk">{{ data.disk }}</p>
                </div>
                <div class="left_section">
                    <div class="subtitle">{{ data.subtitle }}</div>
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
            <div class="bottomSection" :style="{height: Height+ 'px'}">
                <div class="bottomContent" ref="ContentElem">
                    <slot />
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/download/SeriesDownload/DownloadSeriesSection.css';
</style>