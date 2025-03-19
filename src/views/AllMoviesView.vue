<script setup>
import FilterBox from '@/components/Filter/FilterBox.vue';
import CheckItem from '@/components/Filter/CheckItem.vue';
import { onBeforeUnmount, onMounted, ref, watch } from 'vue';
import Loading from '@/components/Loading.vue';
import HttpRequest, { BaseUrl } from '@/Api/ApiConfig';
import nProgress from 'nprogress';
import nprogress from 'nprogress';
import { useRoute } from 'vue-router';
import MovieCard from '@/components/MovieCard/MovieCard.vue';
import Pagination from '@/components/Pagination/Pagination.vue';
import FilterBoxMobile from '@/components/Filter/FilterBoxMobile.vue';
import { toast } from '@/composables/AlertToast';

const route = useRoute()
let FilterBoxMobileActive = ref(null)

let isGenreLoading = ref(true)

let movies = ref([])
let moviesLoading = ref(true)
let paginationData = ref({
    links: {
        next: null,
        prev: null,
    },
    meta: {
        last_page: 0
    }
})

let data = ref({
    category: [
        {
            id: 1,
            title: 'فیلم',
            val: 0,
            isLoading: false,
        },
        {
            id: 2,
            title: 'سریال',
            val: 1,
            isLoading: false,
        },
    ],
    genres: [],
    orderBy: [
        {
            id: 1,
            title: 'جدید ترین',
            val: 'جدید ترین',
            isLoading: false
        },
        {
            id: 2,
            title: 'سال انتشار',
            val: 'سال انتشار',
            isLoading: false
        },
        {
            id: 3,
            title: 'نمره IMDB',
            val: 'نمره IMDB',
            isLoading: false
        },
        {
            id: 4,
            title: 'امتیاز کاربران',
            val: 'امتیاز کاربران',
            isLoading: false
        }
    ]
})

let selectedFilter = ref({
    category: -1,
    genres: [],
    orderBy: -1,
    tag: -1,
    search: ''
})


let isRequestBlocked = ref(true)

onMounted(async () => {

    await HttpRequest.get('/genres')
        .then(res => {
            isGenreLoading.value = false;

            if (res != undefined) {
                let genresData = res?.data.map(item => {
                    return {
                        ...item,
                        val: item.id,
                        isLoading: false
                    }
                })

                data.value.genres = genresData
            }

        })
        .catch(err => isGenreLoading.value = false)

    handleQuerys()
})

watch(route, () => handleQuerys())

let handleQuerys = () => {

    let copySelected = {
        category: -1,
        genres: [],
        orderBy: -1,
        tag: -1,
        search: ''
    };

    if (route.query != undefined) {
        copySelected = { ...copySelected, ...route.query };

        if (`genres` in route.query) {
            copySelected.genres = [Number(route.query.genres)];
        }
    }

    // loading
    nProgress.start();
    isRequestBlocked.value = true

    loadMovies(copySelected)
}

let FilterEvent = (id, parent, newData) => {

    let index = data.value[parent].findIndex(item => item.id == id)

    // loading
    nProgress.start();
    isRequestBlocked.value = true
    data.value[parent][index].isLoading = true;

    let copySelected = { ...selectedFilter.value };
    copySelected[parent] = newData

    loadMovies(copySelected, index, parent)
}

let loadMovies = (copySelected, index = null, parent = null) => {

    HttpRequest.post('/filter-movies', { ...copySelected })
        .then(res => {
            nprogress.done()
            isRequestBlocked.value = false
            if (res != undefined) {
                moviesLoading.value = false
                if (index != null && parent != null) {
                    data.value[parent][index].isLoading = false;
                }
                selectedFilter.value = copySelected

                movies.value = res?.data
                paginationData.value.links = res?.data.links;
                paginationData.value.meta = res?.data.meta;


                window.scrollTo({ top: 0, behavior: 'smooth' })
            }

        })
        .catch(err => {
            nprogress.done()
            isRequestBlocked.value = false
        })
}

let loadMoviesByPaginate = (url) => {

    nProgress.start()
    isRequestBlocked.value = true

    HttpRequest.post(url.replace(BaseUrl + '/api', ''), { ...selectedFilter.value })
        .then(res => {
            nprogress.done()
            isRequestBlocked.value = false
            if (res != undefined) {
                movies.value = res?.data
                paginationData.value.links = res?.data.links;
                paginationData.value.meta = res?.data.meta;

                window.scrollTo({ top: 0, behavior: 'smooth' })
            }
        })
        .catch(err => {
            nprogress.done()
            isRequestBlocked.value = false
        })
}

onBeforeUnmount(() => {
    nProgress.done()
})


</script>

<template>
    <section class="containerAll">
        <div class="sectionAll">
            <div class="topFilterMobile">
                <div class="FilterButtons" @click="FilterBoxMobileActive = 1">
                    <svg fill="none" stroke-width="0" viewBox="0 0 24 24" class="w-5 h-5 text-gray-400 ml-2"
                        height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4">
                        </path>
                    </svg>
                    <span>فیلتر اطلاعات</span>
                </div>
                <div class="FilterButtons" @click="FilterBoxMobileActive = 2">
                    <svg fill="none" stroke-width="0" viewBox="0 0 24 24" class="w-5 h-5 text-gray-400 ml-2"
                        height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M3 4h13M3 8h9m-9 4h9m5-4v12m0 0l-4-4m4 4l4-4"></path>
                    </svg>
                    <span>مرتب سازی</span>
                </div>
            </div>
            <div class="FilterSection">
                <FilterBox title="دسته بندی">
                    <template #icon>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"
                            class="w-5 h-5 text-secondary-700">
                            <path
                                d="M18.333 5v2.017c0 1.316-.833 2.15-2.15 2.15h-2.85V3.342c0-.925.759-1.675 1.684-1.675a3.35 3.35 0 0 1 2.341.975c.6.608.975 1.441.975 2.358Z">
                            </path>
                            <path
                                d="M1.667 5.833V17.5A.83.83 0 0 0 3 18.167L4.425 17.1a.84.84 0 0 1 1.1.083l1.383 1.392a.84.84 0 0 0 1.184 0l1.4-1.4a.826.826 0 0 1 1.083-.075L12 18.167a.835.835 0 0 0 1.333-.667V3.333c0-.916.75-1.666 1.667-1.666H5C2.5 1.667 1.667 3.158 1.667 5v.833Z"
                                opacity="0.4"></path>
                            <path
                                d="M10 8.125H5a.63.63 0 0 1-.625-.625A.63.63 0 0 1 5 6.875h5a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Zm-.625 3.333h-3.75A.63.63 0 0 1 5 10.833a.63.63 0 0 1 .625-.625h3.75a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Z">
                            </path>
                        </svg>
                    </template>

                    <CheckItem v-for="category in data.category" :key="category.id" :data="category"
                        :isActive="selectedFilter.category == category.val" parent="category" :isMultipleSelect="false"
                        :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.category"
                        @FilterEvent="FilterEvent" />

                </FilterBox>
                <FilterBox title="ژانر ها">
                    <template #icon>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" fill="none"
                            class="w-5 h-5 text-secondary-700">
                            <path
                                d="M32.151 4h6.772C41.727 4 44 6.292 44 9.12v6.829c0 2.828-2.273 5.12-5.077 5.12h-6.772c-2.805 0-5.077-2.292-5.077-5.12v-6.83C27.074 6.293 29.346 4 32.151 4Z"
                                opacity="0.4"></path>
                            <path
                                d="M15.849 26.931c2.805 0 5.077 2.292 5.077 5.12v6.83c0 2.825-2.272 5.119-5.077 5.119H9.077C6.273 44 4 41.706 4 38.88v-6.829c0-2.828 2.273-5.12 5.077-5.12h6.772Zm23.074 0c2.804 0 5.077 2.292 5.077 5.12v6.83C44 41.705 41.727 44 38.923 44h-6.772c-2.805 0-5.077-2.294-5.077-5.12v-6.829c0-2.828 2.272-5.12 5.077-5.12h6.772ZM15.849 4c2.805 0 5.077 2.292 5.077 5.12v6.829c0 2.828-2.272 5.12-5.077 5.12H9.077C6.273 21.069 4 18.777 4 15.949v-6.83C4 6.293 6.273 4 9.077 4h6.772Z">
                            </path>
                        </svg>
                    </template>

                    <Loading v-if="isGenreLoading" title="در حال گرفتن اطلاعات ..." />

                    <CheckItem v-for="genre in data.genres" :key="genre.id" :data="genre"
                        :isActive="selectedFilter.genres.includes(genre.val)" parent="genres"
                        :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.genres"
                        @FilterEvent="FilterEvent" />

                </FilterBox>
                <FilterBox title="مرتب سازی">
                    <template #icon>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"
                            class="w-5 h-5 text-secondary-700">
                            <path
                                d="M18.333 8.967a.717.717 0 0 0-.716-.717H2.383c-.4 0-.716.317-.716.717 0 4.908 3.425 8.333 8.333 8.333s8.333-3.433 8.333-8.333Z"
                                opacity="0.4"></path>
                            <path
                                d="m10.442 2.883 2.375 2.367a.629.629 0 0 1 0 .883.629.629 0 0 1-.884 0l-1.308-1.3v7.975a.63.63 0 0 1-.625.625.63.63 0 0 1-.625-.625V4.833l-1.3 1.309a.629.629 0 0 1-.883 0A.627.627 0 0 1 7 5.7c0-.158.058-.317.183-.442l2.375-2.366a.621.621 0 0 1 .884-.009Z">
                            </path>
                        </svg>
                    </template>

                    <CheckItem v-for="orderBy in data.orderBy" :key="orderBy.id" :data="orderBy"
                        :isActive="selectedFilter.orderBy == orderBy.val" parent="orderBy" :isMultipleSelect="false"
                        :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.orderBy"
                        @FilterEvent="FilterEvent" />
                </FilterBox>
            </div>
            <div class="MoviesSection">
                <div class="MovieCardLoading loadingBox" v-if="moviesLoading" v-for="item in 20"
                    :key="Math.random().toString(36).substr(3)"></div>

                <MovieCard v-for="movie in movies.data" :data="movie" :key="movie.id" v-if="!moviesLoading" />

                <p class="empty" v-if="!moviesLoading && movies.data.length == 0">موردی یافت نشد</p>

                <Pagination v-if="!moviesLoading && paginationData.meta?.last_page > 1"
                    :nextUrl="paginationData.links.next" :prevUrl="paginationData.links.prev"
                    @loadDataByPagination="loadMoviesByPaginate" :meta="paginationData.meta" api_route="filter-movies">
                </Pagination>

            </div>
        </div>
    </section>

    <FilterBoxMobile title="فیلتر اطلاعات" :isActive="FilterBoxMobileActive == 1" @closeFiter="FilterBoxMobileActive = null">
        <FilterBox title="دسته بندی">
            <template #icon>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"
                    class="w-5 h-5 text-secondary-700">
                    <path
                        d="M18.333 5v2.017c0 1.316-.833 2.15-2.15 2.15h-2.85V3.342c0-.925.759-1.675 1.684-1.675a3.35 3.35 0 0 1 2.341.975c.6.608.975 1.441.975 2.358Z">
                    </path>
                    <path
                        d="M1.667 5.833V17.5A.83.83 0 0 0 3 18.167L4.425 17.1a.84.84 0 0 1 1.1.083l1.383 1.392a.84.84 0 0 0 1.184 0l1.4-1.4a.826.826 0 0 1 1.083-.075L12 18.167a.835.835 0 0 0 1.333-.667V3.333c0-.916.75-1.666 1.667-1.666H5C2.5 1.667 1.667 3.158 1.667 5v.833Z"
                        opacity="0.4"></path>
                    <path
                        d="M10 8.125H5a.63.63 0 0 1-.625-.625A.63.63 0 0 1 5 6.875h5a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Zm-.625 3.333h-3.75A.63.63 0 0 1 5 10.833a.63.63 0 0 1 .625-.625h3.75a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Z">
                    </path>
                </svg>
            </template>

            <CheckItem v-for="category in data.category" :key="category.id" :data="category"
                :isActive="selectedFilter.category == category.val" parent="category" :isMultipleSelect="false"
                :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.category"
                @FilterEvent="FilterEvent" />

        </FilterBox>
        <FilterBox title="ژانر ها">
            <template #icon>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" fill="none"
                    class="w-5 h-5 text-secondary-700">
                    <path
                        d="M32.151 4h6.772C41.727 4 44 6.292 44 9.12v6.829c0 2.828-2.273 5.12-5.077 5.12h-6.772c-2.805 0-5.077-2.292-5.077-5.12v-6.83C27.074 6.293 29.346 4 32.151 4Z"
                        opacity="0.4"></path>
                    <path
                        d="M15.849 26.931c2.805 0 5.077 2.292 5.077 5.12v6.83c0 2.825-2.272 5.119-5.077 5.119H9.077C6.273 44 4 41.706 4 38.88v-6.829c0-2.828 2.273-5.12 5.077-5.12h6.772Zm23.074 0c2.804 0 5.077 2.292 5.077 5.12v6.83C44 41.705 41.727 44 38.923 44h-6.772c-2.805 0-5.077-2.294-5.077-5.12v-6.829c0-2.828 2.272-5.12 5.077-5.12h6.772ZM15.849 4c2.805 0 5.077 2.292 5.077 5.12v6.829c0 2.828-2.272 5.12-5.077 5.12H9.077C6.273 21.069 4 18.777 4 15.949v-6.83C4 6.293 6.273 4 9.077 4h6.772Z">
                    </path>
                </svg>
            </template>

            <Loading v-if="isGenreLoading" title="در حال گرفتن اطلاعات ..." />

            <CheckItem v-for="genre in data.genres" :key="genre.id" :data="genre"
                :isActive="selectedFilter.genres.includes(genre.val)" parent="genres"
                :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.genres"
                @FilterEvent="FilterEvent" />

        </FilterBox>
    </FilterBoxMobile>
    <FilterBoxMobile title="مرتب سازی" :isActive="FilterBoxMobileActive == 2" @closeFiter="FilterBoxMobileActive = null">
        <FilterBox title="مرتب سازی">
            <template #icon>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"
                    class="w-5 h-5 text-secondary-700">
                    <path
                        d="M18.333 8.967a.717.717 0 0 0-.716-.717H2.383c-.4 0-.716.317-.716.717 0 4.908 3.425 8.333 8.333 8.333s8.333-3.433 8.333-8.333Z"
                        opacity="0.4"></path>
                    <path
                        d="m10.442 2.883 2.375 2.367a.629.629 0 0 1 0 .883.629.629 0 0 1-.884 0l-1.308-1.3v7.975a.63.63 0 0 1-.625.625.63.63 0 0 1-.625-.625V4.833l-1.3 1.309a.629.629 0 0 1-.883 0A.627.627 0 0 1 7 5.7c0-.158.058-.317.183-.442l2.375-2.366a.621.621 0 0 1 .884-.009Z">
                    </path>
                </svg>
            </template>

            <CheckItem v-for="orderBy in data.orderBy" :key="orderBy.id" :data="orderBy"
                :isActive="selectedFilter.orderBy == orderBy.val" parent="orderBy" :isMultipleSelect="false"
                :isRequestBlocked="isRequestBlocked" :selectedFilter="selectedFilter.orderBy"
                @FilterEvent="FilterEvent" />
        </FilterBox>
    </FilterBoxMobile>
</template>

<style scoped>
@import '@/assets/css/views/AllMovies/allMovies.css';
</style>