<script setup>

import HttpRequest, { BaseUrl } from '@/Api/ApiConfig';
import Loading from '@/components/Loading.vue';
import { toast } from '@/composables/AlertToast';
import { useToken } from '@/stores/Authentication/useToken';
import { useUser } from '@/stores/Authentication/useUser';
import nprogress from 'nprogress';
import { ref } from 'vue';
import { RouterLink, useRoute } from 'vue-router';

let route = useRoute()

let tokenStore = useToken();

let props = defineProps({
    data: Object,
    MovieType: String,
    isLoading: {
        type: Boolean,
        default: true
    }
})

let isLikeLoading = ref(false);
let isunLikeLoading = ref(false);


let likeRequest = () => {

    if (!tokenStore.token) {
        toast("ابتدا باید وارد حساب کاربری خود شوید", 'error')
        return
    }

    if (!isLikeLoading.value) {
        nprogress.start()
        isLikeLoading.value = true
        HttpRequest.post(`/movie/${route.params.id}/like`, {
            type: true
        })
            .then(res => {
                nprogress.done()
                isLikeLoading.value = false
                if (res != undefined) {
                    props.data.likes = res.data.isLiked
                    props.data.populer = res.data.populer
                    props.data.votes = res.data.votes

                    let text = "امتیاز شما با موفقیت ثبت شد"
                    text = res.data.isLiked == null ? 'امتیاز شما برداشته شد' : text
                    toast(text)
                }
            })
            .catch(err => {
                nprogress.done()
                isLikeLoading.value = false
            })
    }
}

let unlikeRequest = () => {

    if (!tokenStore.token) {
        toast("ابتدا باید وارد حساب کاربری خود شوید", 'error')
        return
    }

    if (!isunLikeLoading.value) {
        nprogress.start()
        isunLikeLoading.value = true
        HttpRequest.post(`/movie/${route.params.id}/like`, {
            type: false
        })
            .then(res => {
                nprogress.done()
                isunLikeLoading.value = false
                if (res != undefined) {
                    props.data.likes = res.data.isLiked
                    props.data.populer = res.data.populer
                    props.data.votes = res.data.votes

                    let text = "امتیاز شما با موفقیت ثبت شد"
                    text = res.data.isLiked == null ? 'امتیاز شما برداشته شد' : text
                    toast(text)
                }
            })
            .catch(err => {
                nprogress.done()
                isunLikeLoading.value = false
            })

    }
}



</script>

<template>
    <section class="movie_header_container">
        <img :src="BaseUrl + data?.image_bg" v-if="!isLoading" class="bg_image" alt="">
        <div class="header_bg loadingBox" v-if="isLoading"></div>
        <div class="movie_header_section">
            <div class="rightContent">

                <div class="movie_banner">
                    <img :src="BaseUrl + data?.image" v-if="!isLoading" alt="">
                    <div class="bannerLoading loadingBox" v-if="isLoading"></div>
                </div>
                <div class="movie_detail_content">

                    <div class="playButton">
                        <svg class="icon">
                            <use xlink:href="#play_round">
                                <symbol viewBox="0 0 29 30" id="play_round">
                                    <path
                                        d="M24.0447 9.22918C28.452 11.7737 28.452 18.1351 24.0447 20.6797L12.145 27.55C7.73768 30.0945 2.22857 26.9138 2.22857 21.8247L2.22857 8.08412C2.22857 2.99501 7.73768 -0.185671 12.145 2.35888L24.0447 9.22918Z"
                                        stroke-width="2.64438"></path>
                                </symbol>
                            </use>
                        </svg>
                    </div>

                    <!-- title -->
                    <p class="title_movie" v-if="!isLoading">دانلود {{ MovieType + ' ' + data.title + ' ' + data.year }}
                    </p>
                    <p class="loading_title textloading" v-if="isLoading"></p>

                    <!-- fa title -->
                    <p class="title_fa_movie" v-if="!isLoading">{{ data.title_fa }}</p>
                    <p class="title_fa_movie_loading textloading" v-if="isLoading"></p>

                    <!-- genres -->
                    <div class="genres" v-if="!isLoading">
                        <p>ژانر ها: </p>
                        <div class="genresList">
                            <RouterLink v-for="genre in data.genres"
                                :to="{ name: 'all-movies', query: { genres: genre.id } }" class="genre_item"
                                :key="genre.id">{{ genre.title }}</RouterLink>
                        </div>
                    </div>
                    <div class="genre_loading textloading" v-if="isLoading"></div>

                    <!-- text -->
                    <p class="text_movie" v-if="!isLoading">{{ data.text }}</p>
                    <p class="text_movie_loading textloading" v-if="isLoading"></p>
                    <p class="text_movie_loading textloading" v-if="isLoading"></p>
                    <p class="text_movie_loading small textloading" v-if="isLoading"></p>

                    <!-- stars -->
                    <div class="stars_container" v-if="!isLoading">
                        <div class="stars_section">
                            <div class="title_part">
                                <svg class="icon starts_icon">
                                    <use xlink:href="#starts">
                                        <symbol viewBox="0 0 92 92" id="starts">
                                            <path
                                                d=" M 42.26 2.21 C 46.99 -0.08 52.54 2.73 54.93 7.06 C 57.95 12.51 60.46 18.23 63.39 23.72 C 64.13 25.12 65.52 26.15 67.06 26.47 C 72.30 27.54 77.65 28.07 82.87 29.26 C 86.86 30.30 90.65 33.58 90.99 37.90 C 91.21 41.12 89.71 44.21 87.63 46.59 C 83.88 50.83 79.54 54.51 75.77 58.73 C 73.51 61.88 75.76 65.69 76.25 69.06 C 77.45 74.79 79.94 81.27 76.84 86.81 C 74.41 91.19 68.40 91.27 64.31 89.47 C 58.84 86.93 53.92 83.35 48.61 80.52 C 47.24 79.80 45.58 79.40 44.15 80.20 C 38.49 82.97 33.41 86.85 27.67 89.48 C 23.31 91.51 16.97 90.92 14.75 86.09 C 12.23 80.20 14.81 73.85 16.03 67.96 C 16.53 64.97 18.32 61.54 16.26 58.76 C 12.33 54.33 7.71 50.54 3.90 46.00 C 1.73 43.26 0.29 39.52 1.43 36.05 C 2.46 32.60 5.72 30.30 9.04 29.30 C 14.49 27.98 20.12 27.58 25.57 26.30 C 29.11 24.85 29.72 20.55 31.56 17.61 C 34.65 12.25 36.34 5.24 42.26 2.21 M 43.27 9.34 C 39.05 15.37 36.89 22.61 32.80 28.73 C 28.66 33.75 21.55 33.08 15.77 34.39 C 12.85 35.08 8.92 34.93 7.35 38.00 C 7.29 41.56 10.66 43.82 12.83 46.23 C 15.97 49.64 19.84 52.48 22.33 56.43 C 26.57 65.64 17.50 75.14 20.90 84.36 C 25.84 84.47 29.68 80.98 33.81 78.78 C 38.61 75.93 43.99 71.81 49.88 74.17 C 55.67 76.76 60.74 80.72 66.45 83.48 C 67.91 84.30 69.62 84.15 71.23 84.31 C 74.38 74.95 65.24 65.36 69.90 56.15 C 73.79 50.43 79.90 46.56 83.92 40.92 C 85.57 39.09 84.49 36.39 82.23 35.75 C 76.48 33.93 70.35 33.84 64.53 32.31 C 62.05 31.49 59.74 29.88 58.38 27.61 C 54.95 21.66 52.64 15.07 48.77 9.39 C 47.54 7.22 44.53 7.19 43.27 9.34 Z">
                                            </path>
                                        </symbol>
                                    </use>
                                </svg>
                                <span>ستارگان: </span>
                            </div>
                            <div class="stars_content">
                                <div class="stars" v-for="star in data.stars.actors" :key="star.id">{{ star.name }}
                                </div>
                            </div>
                        </div>
                        <div class="stars_section">
                            <div class="title_part">
                                <svg class="icon user_square_icon">
                                    <use xlink:href="#user_square">
                                        <symbol viewBox="0 0 100 100" id="user_square">
                                            <path
                                                d=" M 33.23 5.32 C 43.83 5.17 54.43 5.28 65.03 5.26 C 72.89 5.45 81.38 7.14 87.16 12.85 C 92.85 18.62 94.54 27.07 94.74 34.90 C 94.76 44.95 94.75 54.99 94.74 65.04 C 94.56 72.91 92.89 81.40 87.14 87.19 C 81.31 92.82 72.88 94.56 65.03 94.74 C 55.00 94.75 44.98 94.76 34.96 94.74 C 27.10 94.56 18.66 92.81 12.84 87.17 C 7.15 81.37 5.44 72.92 5.26 65.07 C 5.24 55.03 5.24 44.98 5.26 34.93 C 5.46 27.31 7.04 19.14 12.36 13.36 C 17.67 7.67 25.73 5.74 33.23 5.32 M 17.35 17.34 C 12.79 21.94 11.81 28.74 11.52 34.92 C 11.51 45.31 11.43 55.71 11.56 66.10 C 11.76 73.76 14.37 82.42 21.85 85.92 C 23.70 80.63 27.18 75.96 31.86 72.85 C 41.95 66.18 55.76 65.83 66.30 71.72 C 71.81 74.81 76.10 79.93 78.15 85.92 C 85.33 82.56 88.09 74.36 88.39 66.95 C 88.66 56.65 88.42 46.33 88.51 36.02 C 88.34 29.49 87.46 22.24 82.66 17.35 C 78.06 12.78 71.24 11.79 65.04 11.52 C 55.02 11.48 44.99 11.49 34.97 11.51 C 28.77 11.81 21.96 12.78 17.35 17.34 M 27.93 87.76 C 33.90 88.84 39.99 88.44 46.02 88.50 C 54.71 88.26 63.47 89.14 72.08 87.75 C 65.49 69.24 34.50 69.23 27.93 87.76 Z">
                                            </path>
                                            <path
                                                d=" M 45.43 26.59 C 56.34 23.30 68.52 32.68 68.03 44.07 C 68.46 54.47 58.34 63.61 48.02 62.07 C 39.06 61.37 31.62 52.95 31.97 43.99 C 31.77 36.02 37.73 28.48 45.43 26.59 M 47.43 32.59 C 43.65 33.52 40.29 36.25 38.96 39.95 C 36.26 46.48 40.94 54.59 47.86 55.70 C 55.23 57.40 62.66 50.35 61.73 42.94 C 61.28 36.16 54.00 30.89 47.43 32.59 Z">
                                            </path>
                                        </symbol>
                                    </use>
                                </svg>
                                <span>کارگردان: </span>
                            </div>
                            <div class="stars_content">
                                <div class="stars" v-for="star in data.stars.directors" :key="star.id">{{ star.name }}
                                </div>
                            </div>
                        </div>
                    </div>

                    <p class="stars_container_loading first textloading" v-if="isLoading"></p>
                    <p class="stars_container_loading small textloading" v-if="isLoading"></p>

                    <!-- alert -->
                    <div class="alert_movie" v-if="!isLoading && data.alert">
                        <svg class="icon updates_icon">
                            <use xlink:href="#updates">
                                <symbol viewBox="0 0 20 20" id="updates">
                                    <path
                                        d="M10 20C4.477 20 0 15.523 0 10C0 4.477 4.477 0 10 0C15.523 0 20 4.477 20 10C20 15.523 15.523 20 10 20ZM14.82 15.076C16.0271 13.9319 16.7874 12.3953 16.9647 10.7416C17.1419 9.0879 16.7246 7.4251 15.7874 6.05111C14.8503 4.67711 13.4545 3.6817 11.8502 3.24319C10.2458 2.80468 8.53777 2.95173 7.032 3.658L8.007 5.413C8.76793 5.08229 9.59919 4.94613 10.4259 5.01679C11.2525 5.08746 12.0486 5.36273 12.7424 5.81779C13.4361 6.27286 14.0057 6.89341 14.3999 7.62351C14.794 8.35361 15.0002 9.17031 15 10H12L14.82 15.076ZM12.968 16.342L11.993 14.587C11.2321 14.9177 10.4008 15.0539 9.57414 14.9832C8.74747 14.9125 7.95137 14.6373 7.25762 14.1822C6.56386 13.7271 5.99425 13.1066 5.60013 12.3765C5.20601 11.6464 4.99977 10.8297 5 10H8L5.18 4.924C3.97289 6.06814 3.2126 7.60469 3.03532 9.2584C2.85805 10.9121 3.27539 12.5749 4.21256 13.9489C5.14974 15.3229 6.54552 16.3183 8.14985 16.7568C9.75418 17.1953 11.4622 17.0483 12.968 16.342Z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                        {{ data.alert }}
                    </div>

                    <div class="alert_loading textloading" v-if="isLoading"></div>

                </div>
            </div>
            <div class="leftContent">
                <div class="topContent">
                    <div class="imdb_section">
                        <p v-if="!isLoading">
                            10 / <span>{{ data.imdb }}</span>
                        </p>
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
                        <div class="top_loading textloading" v-if="isLoading"></div>
                    </div>
                    <div class="like_section">
                        <div class="top" v-if="!isLoading">
                            <div class="like_btn" @click="likeRequest">
                                <svg v-if="!isLikeLoading && tokenStore.token && (data.likes != null && data.likes == 'liked')"
                                    class="liked_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"
                                    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"
                                    x="0" y="0" viewBox="0 0 24 24" xml:space="preserve">
                                    <g>
                                        <path
                                            d="M22.773 7.721A4.994 4.994 0 0 0 19 6h-3.989l.336-2.041a3.037 3.037 0 0 0-5.721-1.837L8 5.417V21h10.3a5.024 5.024 0 0 0 4.951-4.3l.705-5a4.994 4.994 0 0 0-1.183-3.979ZM0 11v5a5.006 5.006 0 0 0 5 5h1V6H5a5.006 5.006 0 0 0-5 5Z"
                                            data-original="#000000"></path>
                                    </g>
                                </svg>

                                <svg v-if="!isLikeLoading && (data.likes == null || !tokenStore.token || data.likes == 'unliked')"
                                    class="unliked_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"
                                    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"
                                    x="0" y="0" viewBox="0 0 24 24">
                                    <g>
                                        <path
                                            d="M22.773 7.721A4.994 4.994 0 0 0 19 6h-3.989l.336-2.041a3.037 3.037 0 0 0-5.721-1.837L7.712 6H5a5.006 5.006 0 0 0-5 5v5a5.006 5.006 0 0 0 5 5h13.3a5.024 5.024 0 0 0 4.951-4.3l.705-5a5 5 0 0 0-1.183-3.979ZM2 16v-5a3 3 0 0 1 3-3h2v11H5a3 3 0 0 1-3-3Zm19.971-4.581-.706 5A3.012 3.012 0 0 1 18.3 19H9V7.734a1 1 0 0 0 .23-.292l2.189-4.435a1.07 1.07 0 0 1 1.722-.207 1.024 1.024 0 0 1 .233.84l-.528 3.2A1 1 0 0 0 13.833 8H19a3 3 0 0 1 2.971 3.419Z">
                                        </path>
                                    </g>
                                </svg>

                                <Loading v-if="isLikeLoading" />

                            </div>
                            <div class="like_btn unlike" @click="unlikeRequest">
                                <svg v-if="!isunLikeLoading && tokenStore.token && (data.likes != null && data.likes == 'unliked')"
                                    class="unliked_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"
                                    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"
                                    x="0" y="0" viewBox="0 0 24 24" xml:space="preserve">
                                    <g>
                                        <path
                                            d="M22.773 7.721A4.994 4.994 0 0 0 19 6h-3.989l.336-2.041a3.037 3.037 0 0 0-5.721-1.837L8 5.417V21h10.3a5.024 5.024 0 0 0 4.951-4.3l.705-5a4.994 4.994 0 0 0-1.183-3.979ZM0 11v5a5.006 5.006 0 0 0 5 5h1V6H5a5.006 5.006 0 0 0-5 5Z"
                                            data-original="#000000"></path>
                                    </g>
                                </svg>

                                <svg v-if="!isunLikeLoading && (data.likes == null || !tokenStore.token || data.likes == 'liked')"
                                    class="unliked_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"
                                    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"
                                    x="0" y="0" viewBox="0 0 24 24">
                                    <g>
                                        <path
                                            d="M22.773 7.721A4.994 4.994 0 0 0 19 6h-3.989l.336-2.041a3.037 3.037 0 0 0-5.721-1.837L7.712 6H5a5.006 5.006 0 0 0-5 5v5a5.006 5.006 0 0 0 5 5h13.3a5.024 5.024 0 0 0 4.951-4.3l.705-5a5 5 0 0 0-1.183-3.979ZM2 16v-5a3 3 0 0 1 3-3h2v11H5a3 3 0 0 1-3-3Zm19.971-4.581-.706 5A3.012 3.012 0 0 1 18.3 19H9V7.734a1 1 0 0 0 .23-.292l2.189-4.435a1.07 1.07 0 0 1 1.722-.207 1.024 1.024 0 0 1 .233.84l-.528 3.2A1 1 0 0 0 13.833 8H19a3 3 0 0 1 2.971 3.419Z">
                                        </path>
                                    </g>
                                </svg>

                                <Loading v-if="isunLikeLoading" />

                            </div>

                            <img src="/images/zarfilm-logo-white-sm.png" v-if="!isLoading" alt="">
                        </div>
                        <div class="top_loading textloading" v-if="isLoading"></div>
                        <div class="bottom" v-if="!isLoading">{{ data.populer }}% ({{ data.votes }} رای)</div>
                        <div class="bottom_loading textloading" v-if="isLoading"></div>
                    </div>
                </div>

                <div class="leftButtons">
                    <div class="btns watch" v-if="!isLoading"
                        @click="toast('این بخش ها هنوز در دسترس قرار ندارند', 'warning')">
                        <svg class="icon playsingle_icon">
                            <use xlink:href="#playsingle">
                                <symbol viewBox="0 0 24 24" id="playsingle">
                                    <path
                                        d="M17.49 9.60001L5.6 16.77C4.9 17.19 4 16.69 4 15.87V7.87001C4 4.38001 7.77 2.20001 10.8 3.94001L15.39 6.58001L17.48 7.78001C18.17 8.19001 18.18 9.19001 17.49 9.60001Z">
                                    </path>
                                    <path
                                        d="M18.0908 15.46L14.0408 17.8L10.0008 20.13C8.55079 20.96 6.91079 20.79 5.72079 19.95C5.14079 19.55 5.21079 18.66 5.82079 18.3L18.5308 10.68C19.1308 10.32 19.9208 10.66 20.0308 11.35C20.2808 12.9 19.6408 14.57 18.0908 15.46Z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                        مشاهده آنلاین
                    </div>
                    <div class="btns trailer" v-if="!isLoading"
                        @click="toast('این بخش ها هنوز در دسترس قرار ندارند', 'warning')">
                        <svg class="icon video_square_icon">
                            <use xlink:href="#video_square">
                                <symbol viewBox="0 0 24 24" id="video_square">
                                    <path opacity="0.4"
                                        d="M16.19 2H7.81C4.17 2 2 4.17 2 7.81V16.18C2 19.83 4.17 22 7.81 22H16.18C19.82 22 21.99 19.83 21.99 16.19V7.81C22 4.17 19.83 2 16.19 2Z">
                                    </path>
                                    <path
                                        d="M9.09961 12V10.52C9.09961 8.60999 10.4496 7.83999 12.0996 8.78999L13.3796 9.52999L14.6596 10.27C16.3096 11.22 16.3096 12.78 14.6596 13.73L13.3796 14.47L12.0996 15.21C10.4496 16.16 9.09961 15.38 9.09961 13.48V12Z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                        مشاهده تریلر
                    </div>

                    <div class="btns_loading loadingBox" v-if="isLoading"></div>
                    <div class="btns_loading loadingBox" v-if="isLoading"></div>

                </div>

            </div>
        </div>
    </section>
</template>

<style scoped>
@import '@/assets/css/views/Movie/Header.css';
</style>