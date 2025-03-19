<script setup>

import { BaseUrl } from '@/Api/ApiConfig';
import MovieCard from '@/components/MovieCard/MovieCard.vue';
import { onMounted, ref } from 'vue';
import HttpRequest from '@/Api/ApiConfig';

// Import Swiper Vue components
import { Swiper, SwiperSlide } from 'swiper/vue';

// Import Swiper styles
import 'swiper/css';

let sliders = ref([])

let slideActive = ref(0)

let isLoading = ref(true)

onMounted(async () => {

    await HttpRequest.get('/new-movies')
        .then(res => {
            isLoading.value = false;
            if (res != undefined) {
                sliders.value = res?.data
            }
        })
        .catch(err => isLoading.value = false)
})

let slideChangeEvent = (swiper) => {
    if (!isLoading.value) {
        slideActive.value = swiper.realIndex
    }
}

</script>

<template>
    <header class="headerContainer">
        <img :src="BaseUrl + sliders[slideActive].image_bg" class="header_bg" alt="" v-if="!isLoading">
        <div class="header_bg loadingBox" v-if="isLoading"></div>

        <section class="headerSection">
            <div class="right">
                <Swiper class="slider-header-movie" slides-per-view="3" space-between="23"
                    @slideChange="slideChangeEvent" :loop="true" :css-mode="false" :breakpoints="{
                        0: {
                            slidesPerView: 1.3,
                            cssMode: true,
                            spaceBetween: 10
                        },
                        290: {
                            slidesPerView: 1.5,
                            cssMode: true,
                            spaceBetween: 10,
                            loop: false,
                        },
                        330: {
                            slidesPerView: 1.8,
                            cssMode: true,
                            spaceBetween: 10,
                            loop: false,
                        },
                        350: {
                            slidesPerView: 2,
                            cssMode: true,
                            spaceBetween: 10,
                            loop: false,
                        },
                        390: {
                            slidesPerView: 2.2,
                            cssMode: true,
                            spaceBetween: 10,
                            loop: false,
                        },
                        430: {
                            slidesPerView: 2.5,
                            cssMode: true,
                            spaceBetween: 10,
                            loop: false,
                        },
                        530: {
                            slidesPerView: 2.5,
                            cssMode: false,
                            spaceBetween: 23,
                            loop: true,
                        },
                        590: {
                            slidesPerView: 2.5,
                        },
                        600: {
                            slidesPerView: 3,
                        },
                        650: {
                            slidesPerView: 3.4,
                        },
                        760: {
                            slidesPerView: 4,
                        },
                        1010: {
                            slidesPerView: 2.1,
                        },
                        1100: {
                            slidesPerView: 2.3,
                        },
                        1160: {
                            slidesPerView: 2.5,
                        },
                        1260: {
                            slidesPerView: 2.7,
                        },
                        1400: {
                            slidesPerView: 3,
                        }
                    }">

                    <SwiperSlide v-for="slide in sliders" :key="slide.id" v-if="!isLoading">
                        <MovieCard :data="slide" :hideDetail="true" />
                    </SwiperSlide>

                    <!-- loading -->
                    <SwiperSlide v-if="isLoading">
                        <div class="loadingHeaderMovieCard loadingBox"></div>
                    </SwiperSlide>
                    <SwiperSlide v-if="isLoading">
                        <div class="loadingHeaderMovieCard loadingBox"></div>
                    </SwiperSlide>
                    <SwiperSlide v-if="isLoading">
                        <div class="loadingHeaderMovieCard loadingBox"></div>
                    </SwiperSlide>
                    <SwiperSlide v-if="isLoading">
                        <div class="loadingHeaderMovieCard loadingBox"></div>
                    </SwiperSlide>
                    <!-- loading -->
                </Swiper>
            </div>
            <div class="left">
                <div class="playButton">
                    <svg class="icon playcos_icon">
                        <use xlink:href="#playcos">
                            <symbol viewBox="0 0 34 35" id="playcos">
                                <path
                                    d="M28.5293 9.9171C34.5293 13.3812 34.5293 22.0415 28.5293 25.5056L14.4764 33.619C8.47637 37.0831 0.976362 32.753 0.976363 25.8248L0.976363 9.59788C0.976364 2.66967 8.47636 -1.66046 14.4764 1.80364L28.5293 9.9171Z"
                                    fill="white"></path>
                            </symbol>
                        </use>
                    </svg>
                </div>
                <div class="content_header">
                    <p class="title_header" v-if="!isLoading">{{ sliders[slideActive].title }}</p>
                    <p class="title_header_loading textloading" v-if="isLoading"></p>
                    <p class="title_header_loading textloading" v-if="isLoading"></p>
                    <svg class="icon IMDB_icon" v-if="!isLoading">
                        <use xlink:href="#IMDB">
                            <symbol viewBox="0 0 60 30" id="IMDB">
                                <path
                                    d="M4.36943 0.0585327H55.3924C57.4048 0.0585327 59.0392 1.6876 59.0392 3.70531V25.57C59.0392 27.5824 57.4101 29.2168 55.3924 29.2168H4.36943C2.35705 29.2168 0.722656 27.5877 0.722656 25.57V3.69999C0.722656 1.6876 2.35705 0.0585327 4.36943 0.0585327Z"
                                    fill="#F5C518"></path>
                                <path d="M8.01074 22.8334H12.5679V6.43109H8.01074V22.8334Z" fill="black"></path>
                                <path
                                    d="M22.2891 6.43109L21.2669 14.0919L20.6334 9.92345C20.4471 8.58719 20.2714 7.42663 20.1064 6.43109H14.3887V22.8334H18.2537L18.2697 12.005L19.8934 22.8334H22.6458L24.1897 11.7655L24.2003 22.8334H28.0547V6.43109H22.2891Z"
                                    fill="black"></path>
                                <path
                                    d="M29.8809 22.8334V6.43109H36.9932C38.601 6.43109 39.9053 7.72475 39.9053 9.32719V19.9373C39.9053 21.5345 38.6063 22.8334 36.9932 22.8334H29.8809ZM35.1938 9.38575C35.0128 9.28993 34.6668 9.24201 34.1664 9.24201V20.0012C34.8318 20.0012 35.2364 19.8841 35.3908 19.6339C35.5452 19.389 35.6251 18.7235 35.6251 17.6322V11.2703C35.6251 10.5303 35.5984 10.0565 35.5452 9.84359C35.492 9.63597 35.3748 9.48158 35.1938 9.38575Z"
                                    fill="black"></path>
                                <path
                                    d="M48.493 10.541H48.7858C50.4202 10.541 51.7458 11.824 51.7458 13.3998V19.9746C51.7458 21.5558 50.4202 22.8334 48.7858 22.8334H48.493C47.4922 22.8334 46.6084 22.3543 46.0707 21.6196L45.8099 22.6205H41.7266V6.43109H46.0867V11.6962C46.6457 10.9988 47.5135 10.541 48.493 10.541ZM47.5614 18.5372V14.6509C47.5614 14.0067 47.5188 13.5862 47.4336 13.3945C47.3484 13.2029 47.0024 13.0751 46.7628 13.0751C46.5233 13.0751 46.1506 13.1762 46.0814 13.3466V14.6509V18.6597V19.9214C46.1612 20.1077 46.5179 20.2142 46.7628 20.2142C47.0077 20.2142 47.3697 20.113 47.4443 19.9214C47.5241 19.735 47.5614 19.2719 47.5614 18.5372Z"
                                    fill="black"></path>
                            </symbol>
                        </use>
                    </svg>
                    <p class="IMDB_icon_loading textloading" v-if="isLoading"></p>
                    <p class="point_header" v-if="!isLoading">
                        10 / <span>{{ sliders[slideActive].imdb }}</span>
                    </p>
                    <p class="point_header_loading textloading" v-if="isLoading"></p>
                </div>
            </div>
        </section>
    </header>
</template>

<style scoped>
@import '@/assets/css/views/Home/Header.css';
</style>