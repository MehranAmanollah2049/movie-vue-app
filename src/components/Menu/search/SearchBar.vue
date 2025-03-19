<script setup>
import { ref } from 'vue';
import { RouterLink, useRouter } from 'vue-router';
import MovieBox from '@/components/Menu/search/MovieBox.vue'
import Loading from '@/components/Loading.vue';
import HttpRequest from '@/Api/ApiConfig';

let router = useRouter()

let isOpen = ref(false)
let isLoading = ref(false)
let Search = ref('')

let result = ref({
    movies: [],
    isMore: false
})

let searchEvent = () => {
    if (Search.value != '') {
        isLoading.value = true;
        HttpRequest.get(`/search?title=${Search.value}`)
            .then(res => {
                isLoading.value = false;
                if (res != undefined) {
                    result.value = res.data
                }
            })
            .catch(err =>  isLoading.value = false)
    }
}

let showMore = () => {

    router.push({ name: 'all-movies', query: { search: Search.value } })

    Search.value = ''
    isOpen.value = false
}

let closeSearchBar = () => {
    Search.value = ''
    isOpen.value = false
}

</script>

<template>
    <div :class="{
        'SearchBar': true,
        'active': isOpen
    }">
        <div class="searchContent">
            <div class="icon" @click="isOpen = !isOpen">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M20.3317 14.5002C20.6066 13.6382 20.7549 12.7197 20.7549 11.7666C20.7549 6.80236 16.7306 2.77805 11.7664 2.77805C6.80215 2.77805 2.77783 6.80236 2.77783 11.7666C2.77783 16.7308 6.80215 20.7552 11.7664 20.7552C14.1293 20.7552 16.2793 19.8434 17.8837 18.3524"
                        stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    <path d="M18.0181 18.4851L21.5421 22" stroke-width="1.5" stroke-linecap="round"
                        stroke-linejoin="round"></path>
                </svg>
            </div>
            <input type="text" placeholder="نام فیلم یا سریال مورد نظر را وارد کنید" v-model="Search"
                @input="searchEvent" />

        </div>
        <div :class="{
            'dropDownSearchBar': true,
            'active': Search.length > 0 && isOpen
        }">
            <p class="empty" v-if="!isLoading && result.movies.length == 0">موردی یافت نشد</p>
            <Loading v-if="isLoading" title="در حال جستجو ..." />
            <div @click="showMore" class="show-more" v-if="!isLoading && result.movies.length && result?.isMore">نمایش
                نتایج بیشتر ...</div>
            <p class="title_search" v-if="!isLoading && result.movies.length">نتایج جستجوی شما:</p>
            <div class="searchResultContainer" v-if="!isLoading && result.movies.length">
                <MovieBox v-if="!isLoading && result.movies.length" v-for="movie in result.movies" :key="movie.id"
                    :data="movie" @clickEvent="closeSearchBar" />
            </div>
        </div>
    </div>
    <div :class="{
        'overlay_search': true,
        'active': isOpen
    }" @click="isOpen = false"></div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/search/SearchBar.css';
</style>