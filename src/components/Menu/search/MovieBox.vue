<script setup lang="ts">
import { RouterLink } from 'vue-router';
import { BaseUrl } from '@/Api/ApiConfig';

defineProps({
    data: Object
})

let emits = defineEmits(['clickEvent'])

</script>


<template>
    <RouterLink :to="{name: 'movie' , params: {id: data.id}}" class="MovieBox" @click="emits('clickEvent')">
        <img :src="BaseUrl + data.image" alt="">
        <p class="movie_name">{{ data.title }}</p>
        <div class="detail">
            <p class="point">{{ data.imdb }}</p>
            <div class="line"></div>
            <p class="year">{{ data.year }}</p>
        </div>
    </RouterLink>
</template>

<style scoped>
@import '@/assets/css/components/Menu/search/movieBox.css';
</style>