<script setup>

import MovieCard from '@/components/MovieCard/MovieCard.vue';
import Header from '@/components/views/Home/Header.vue';
import SectionBox from '@/components/views/Home/SectionBox.vue';
import SeriesCard from '@/components/views/Home/SeriesCard.vue';
import Tag from '@/components/views/Home/Tag.vue';
import Footer from '@/components/Footer/Footer.vue';
import { onMounted, ref } from 'vue';
import HttpRequest from '@/Api/ApiConfig';

let movies = ref([])
let series = ref([])

let isSeriesLoading = ref(true)
let isMoviesLoading = ref(true)

onMounted(async () => {
    await HttpRequest.get('/going-on-series')
        .then(res => {
            isSeriesLoading.value = false
            if (res != undefined) {
                series.value = res?.data
            }
        })
        .catch(err => isSeriesLoading.value = false)


    await HttpRequest.get('/new-movies2')
        .then(res => {
            isMoviesLoading.value = false
            if (res != undefined) {
                movies.value = res?.data
            }
        })
        .catch(err => isMoviesLoading.value = false)
})

</script>

<template>
    <Header />
    <div class="downloadContainer">
        <div class="downloadApp">
            دانلود اپلیکیشن
            <svg class="icon android_icon">
                <use xlink:href="#android">
                    <symbol viewBox="0 0 16 16" id="android">
                        <path
                            d="M5.6582 0.843933C5.5782 0.843933 5.49819 0.874548 5.43726 0.935486C5.31538 1.05736 5.31538 1.25551 5.43726 1.37738L6.25635 2.19647C5.3264 2.87888 4.7207 3.9769 4.7207 5.21893H12.2207C12.2207 3.9769 11.615 2.87888 10.6851 2.19647L11.5042 1.37738C11.626 1.25488 11.626 1.05799 11.5042 0.935486C11.3823 0.813611 11.1841 0.813611 11.0623 0.935486L10.1357 1.862C9.63359 1.61241 9.06957 1.46893 8.4707 1.46893C7.87183 1.46893 7.30782 1.61241 6.80566 1.862L5.87915 0.935486C5.81821 0.874548 5.7382 0.843933 5.6582 0.843933ZM6.5957 3.34393H7.2207V3.96893H6.5957V3.34393ZM9.7207 3.34393H10.3457V3.96893H9.7207V3.34393ZM3.4707 5.84393C3.1257 5.84393 2.8457 6.12393 2.8457 6.46893V10.2189C2.8457 10.5639 3.1257 10.8439 3.4707 10.8439C3.8157 10.8439 4.0957 10.5639 4.0957 10.2189V6.46893C4.0957 6.12393 3.8157 5.84393 3.4707 5.84393ZM4.7207 5.84393V10.8439C4.7207 11.1889 5.0007 11.4689 5.3457 11.4689H5.9707V13.6564C5.9707 14.1739 6.3907 14.5939 6.9082 14.5939C7.4257 14.5939 7.8457 14.1739 7.8457 13.6564V11.4689H9.0957V13.6564C9.0957 14.1739 9.5157 14.5939 10.0332 14.5939C10.5507 14.5939 10.9707 14.1739 10.9707 13.6564V11.4689H11.5957C11.9407 11.4689 12.2207 11.1889 12.2207 10.8439V5.84393H4.7207ZM13.4707 5.84393C13.1257 5.84393 12.8457 6.12393 12.8457 6.46893V10.2189C12.8457 10.5639 13.1257 10.8439 13.4707 10.8439C13.8157 10.8439 14.0957 10.5639 14.0957 10.2189V6.46893C14.0957 6.12393 13.8157 5.84393 13.4707 5.84393Z">
                        </path>
                    </symbol>
                </use>
            </svg>
        </div>
    </div>
    <SectionBox title="سریال های درحال پخش" text="آخرین سریال های بروز شده در زرفیلم" link_text="تمامی سریال ها"
        :link="{ name: 'all-movies', query: { category: 1 } }">

        <SeriesCard v-if="!isSeriesLoading" v-for="serie in series" :key="serie.id" :data="serie" />

        <div class="seriesCardLoading loadingBox" v-if="isSeriesLoading" v-for="item in 8"
            :key="Math.random().toString(36).substr(3)"></div>

    </SectionBox>
    <div class="aboutContainer">
        <div class="aboutSection">
            <p class="title_about">مرجع دانلود فیلم و سریال با زیرنویس چسبیده</p>
            <div class="tags_about">
                <Tag title="پشتیبانی 24 ساعته روی تیکت" />
                <Tag title="بدون سانسور و حذفیات" />
                <Tag title="اپلیکیشن اختصاصی" />
            </div>
        </div>
    </div>
    <SectionBox class="last" title="جدیدترین فیلم ها" text="آخرین فیلم های بروز شده در زرفیلم" link_text="تمامی فیلم ها"
        :link="{ name: 'all-movies', query: { category: 0 } }">

        <MovieCard v-for="movie in movies" :data="movie" :key="movie.id" v-if="!isMoviesLoading" />

        <div class="MovieCardLoading loadingBox" v-if="isMoviesLoading" v-for="item in 14"
            :key="Math.random().toString(36).substr(3)"></div>

    </SectionBox>

</template>

<style scoped>
@import '@/assets/css/views/Home/Home.css';
</style>