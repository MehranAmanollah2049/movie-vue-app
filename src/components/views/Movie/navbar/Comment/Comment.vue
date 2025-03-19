<script setup>
import { BaseUrl } from '@/Api/ApiConfig';
import { inject } from 'vue';

defineProps({
    data: Object
})

let setAnswer = inject('setAnswer')

</script>

<template>
    <div class="Comment">
        <div class="expoile" v-if="data.isExpoile">
            <button @click="data.isExpoile = false">نمایش نظر حاوی اکسپویل</button>
        </div>
        <div class="topComment">
            <div class="right">
                <img :src="BaseUrl + data.user.profile" alt="">
                <p class="username">{{ data.user.username }}</p>
            </div>
            <p class="date">{{ data.time }}</p>
        </div>
        <div class="content">

            <div class="text" v-html="data.text"></div>
            <div class="answer" @click="setAnswer({
                username: data.user.username,
                answerable_id: data.id,
                answerable_type: 'Comment',
                commentId: data.id,
            })">پاسخ</div>
        </div>

    </div>
    <div class="answers_list">
        <slot />
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/Comment/Comment.css';
</style>