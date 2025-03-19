<script setup>
import { computed, inject, onMounted, ref, watch } from 'vue';


defineProps({
    title: String
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
        'QuestionsItem': true,
        'active': isOpen
    }">
        <div class="top" @click="toggleOpen">
            <div class="title">
                <svg class="icon arrow_down_icon">
                    <use xlink:href="#question">
                        <symbol viewBox="0 96 960 960" id="question">
                            <path
                                d="M479.56 800.614q17.132 0 28.94-11.829 11.807-11.829 11.807-28.961 0-17.132-11.829-28.939-11.829-11.808-28.961-11.808-17.132 0-28.939 11.829-11.808 11.829-11.808 28.961 0 17.132 11.829 28.94 11.829 11.807 28.961 11.807Zm.507 155.385q-78.836 0-148.204-29.92-69.369-29.92-120.682-81.21-51.314-51.291-81.247-120.629-29.933-69.337-29.933-148.173t29.92-148.204q29.92-69.369 81.21-120.682 51.291-51.314 120.629-81.247 69.337-29.933 148.173-29.933t148.204 29.92q69.369 29.92 120.682 81.21 51.314 51.291 81.247 120.629 29.933 69.337 29.933 148.173t-29.92 148.204q-29.92 69.369-81.21 120.682-51.291 51.314-120.629 81.247-69.337 29.933-148.173 29.933ZM480 896q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Zm3.24-171.231q27.683 0 47.914 17.429t20.231 43.572q0 22-12.923 39.384-12.923 17.385-29.538 32.385-21.78 19.321-38.352 42.507-16.571 23.185-17.725 51.647-.385 10.922 7.692 18.307 8.077 7.384 18.846 7.384 11.538 0 19.538-7.692 7.999-7.692 10.23-18.846 4-20.615 17.039-36.73Q539.23 578 554.441 563.468q21.866-21.314 38.173-46.48 16.308-25.167 16.308-56.141 0-47.538-37.461-78.115Q534 352.155 484 352.155q-35.692 0-67.307 15.808-31.615 15.807-49.231 46.115-5.461 9.307-3.506 19.593 1.955 10.285 10.557 15.619 10.949 6.095 22.487 3.479 11.538-2.615 19.615-13.153 12.154-15.77 29.423-25.308 17.269-9.539 37.202-9.539Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
                <span>{{ title }}</span>
            </div>
            <div class="arrow" data-v-3bb0bc59=""><svg class="icon arrow_down_icon" data-v-3bb0bc59="">
                    <use xlink:href="#arrow_down" data-v-3bb0bc59="">
                        <symbol viewBox="0 0 10 6" id="arrow_down" data-v-3bb0bc59="">
                            <path
                                d="M5.0006 3.97656L8.53643 0.440729C8.86182 0.115341 9.38938 0.115341 9.71477 0.440729V0.440729C10.0402 0.766117 10.0402 1.29367 9.71477 1.61906L5.78864 5.54518C5.35342 5.98041 4.64778 5.98041 4.21255 5.54518L0.286432 1.61906C-0.0389555 1.29367 -0.0389554 0.766117 0.286432 0.440729V0.440729C0.61182 0.115341 1.13938 0.115341 1.46477 0.440729L5.0006 3.97656Z"
                                data-v-3bb0bc59=""></path>
                        </symbol>
                    </use>
                </svg></div>
        </div>
        <div class="bottom" :style="{ height: Height + 'px' }">
            <div class="content" ref="ContentElem">
                <p>
                    <slot />
                </p>
            </div>
        </div>
    </div>
</template>


<style scoped>
@import '@/assets/css/views/Movie/navbar/FAQ/QuestionsBox.css';
</style>