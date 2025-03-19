<script setup>
import { computed } from 'vue';
import PageLink from './PageLink.vue';

let props = defineProps({
    prevUrl: {
        type: [String,null]
    },
    nextUrl: {
        type: [String,null]
    },
    meta: Object,
    api_route: String
})



let emits = defineEmits(['loadDataByPagination']);

let nextPage = () => {
    if (props.nextUrl) {
        emits('loadDataByPagination', props.nextUrl)
    }
}

let prevPage = () => {
    if (props.prevUrl) {
        emits('loadDataByPagination', props.prevUrl)
    }
}

let loadPage = (page) => {
    emits('loadDataByPagination', `/${props.api_route}?page=` + page)
}

let maxPages = computed(() => {
    let list = [];

    let startPoint = props.meta.current_page;
    let endPoint = props.meta.current_page + 1;

    if(props.meta.current_page != 4)
    {
        startPoint = props.meta.current_page - 1
    }

    if(props.meta.current_page + 1 >= props.meta.last_page - 2)
    {
        endPoint = props.meta.current_page
    }

    for(let i = startPoint;i<=endPoint;i++)
    {
        list.push(i)
    }

    return list
})

</script>

<template>
    <div class="paginationContainer">
        <div :class="{
            'btn': true,
            'disable': prevUrl == null
        }" @click="prevPage">
            <svg class="text-biscay-700 dark:text-white" width="23" height="16" viewBox="0 0 23 16" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path opacity="0.4"
                    d="M6.64577 6.43275L2.05275 6.02655C1.02199 6.02655 0.186279 6.8704 0.186279 7.9112C0.186279 8.952 1.02199 9.79585 2.05275 9.79585L6.64577 9.38965C7.45439 9.38965 8.10996 8.7277 8.10996 7.9112C8.10996 7.09333 7.45439 6.43275 6.64577 6.43275">
                </path>
                <path
                    d="M22.0696 6.50741C21.9978 6.43492 21.7296 6.12856 21.4777 5.87418C20.0081 4.28084 16.1709 1.67543 14.1635 0.878077C13.8588 0.750884 13.0881 0.480085 12.675 0.460937C12.2808 0.460937 11.9043 0.552571 11.5453 0.733104C11.097 0.986123 10.7394 1.38548 10.5417 1.85596C10.4157 2.18147 10.218 3.15935 10.218 3.17713C10.0216 4.24528 9.91455 5.98222 9.91455 7.90243C9.91455 9.72964 10.0216 11.3955 10.1827 12.4814C10.2003 12.5005 10.3981 13.7137 10.6135 14.1294C11.0076 14.8899 11.7783 15.3603 12.6032 15.3603H12.675C13.2127 15.3426 14.3423 14.8707 14.3423 14.8543C16.2427 14.057 19.9891 11.5774 21.4953 9.92932C21.4953 9.92932 21.9206 9.50534 22.1048 9.24138C22.392 8.86117 22.5355 8.39069 22.5355 7.92021C22.5355 7.39503 22.3744 6.90677 22.0696 6.50741">
                </path>
            </svg>
        </div>

        <div class="pages" v-if="meta.last_page <= 8">
            <PageLink v-for="index in meta.last_page" :key="'pagination-' + index" :title="index"
                :isActive="meta.current_page == index" @click="loadPage(index)" />
        </div>

        <div class="pages" v-if="meta.last_page > 8 && meta.current_page < 4">
            <PageLink v-for="index in 3" :key="'pagination-' + index" :title="index"
                :isActive="meta.current_page == index" @click="loadPage(index)" />
            <PageLink :title="4" @click="loadPage(4)" />
            <PageLink :isMore="true" />
            <PageLink :title="meta.last_page - 1" @click="loadPage(meta.last_page - 1)" />
            <PageLink :title="meta.last_page" @click="loadPage(meta.last_page)" />
        </div>

        <div class="pages"
            v-if="meta.last_page > 8 && (meta.current_page >= 4 && meta.current_page < meta.last_page - 3)">
            <PageLink :title="1" @click="loadPage(1)" />

            <PageLink :isMore="true" />

            <PageLink v-for="index in maxPages" :key="'pagination-' + index"
                :title="index" :isActive="meta.current_page == index" @click="loadPage(index)" />

            <PageLink :isMore="true" />

            <PageLink :title="meta.last_page" @click="loadPage(meta.last_page)" />
        </div>

        <div class="pages" v-if="meta.last_page > 8 && meta.current_page >= meta.last_page - 3">
            <PageLink :title="1" @click="loadPage(1)" />
            <PageLink :title="2" @click="loadPage(2)" />
            <PageLink :title="3" @click="loadPage(3)" />
            <PageLink :isMore="true" />
            <PageLink :title="meta.last_page - 4" :isActive="meta.current_page == meta.last_page - 4" @click="loadPage(meta.last_page - 4)" />
            <PageLink :title="meta.last_page - 3" :isActive="meta.current_page == meta.last_page - 3" @click="loadPage(meta.last_page - 3)" />
            <PageLink :title="meta.last_page - 2" :isActive="meta.current_page == meta.last_page - 2" @click="loadPage(meta.last_page - 2)" />
            <PageLink :title="meta.last_page - 1" :isActive="meta.current_page == meta.last_page - 1" @click="loadPage(meta.last_page - 1)" />
            <PageLink :title="meta.last_page" :isActive="meta.current_page == meta.last_page" @click="loadPage(meta.last_page)" />
        </div>

        <div :class="{
            'btn': true,
            'disable': nextUrl == null
        }" @click="nextPage">
            <svg class="text-biscay-700 dark:text-white" width="24" height="16" viewBox="0 0 24 16" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path opacity="0.4"
                    d="M16.6145 6.43275L21.2075 6.02655C22.2383 6.02655 23.074 6.8704 23.074 7.9112C23.074 8.952 22.2383 9.79585 21.2075 9.79585L16.6145 9.38965C15.8059 9.38965 15.1503 8.7277 15.1503 7.9112C15.1503 7.09333 15.8059 6.43275 16.6145 6.43275">
                </path>
                <path
                    d="M1.19065 6.50741C1.26243 6.43492 1.53062 6.12856 1.78255 5.87418C3.25216 4.28084 7.08938 1.67543 9.09672 0.878077C9.40147 0.750884 10.1722 0.480085 10.5853 0.460937C10.9794 0.460937 11.356 0.552571 11.7149 0.733104C12.1632 0.986123 12.5208 1.38548 12.7186 1.85596C12.8445 2.18147 13.0423 3.15935 13.0423 3.17713C13.2387 4.24528 13.3457 5.98222 13.3457 7.90243C13.3457 9.72964 13.2387 11.3955 13.0775 12.4814C13.0599 12.5005 12.8622 13.7137 12.6468 14.1294C12.2526 14.8899 11.4819 15.3603 10.6571 15.3603H10.5853C10.0476 15.3426 8.91793 14.8707 8.91793 14.8543C7.0176 14.057 3.27112 11.5774 1.76494 9.92932C1.76494 9.92932 1.33964 9.50534 1.15543 9.24138C0.868281 8.86117 0.724707 8.39069 0.724707 7.92021C0.724707 7.39503 0.885889 6.90677 1.19065 6.50741">
                </path>
            </svg>
        </div>

    </div>
</template>

<style scoped>
@import '@/assets/css/components/Pagination/Pagination.css';
</style>