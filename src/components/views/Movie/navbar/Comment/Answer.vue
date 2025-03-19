<script setup>
import { BaseUrl } from '@/Api/ApiConfig';
import { inject, ref } from 'vue';

defineProps({
    data: Object
})

let setAnswer = inject('setAnswer')

</script>

<template>
    <div class="Comment answer_cmt">
        <div class="expoile" v-if="data.isExpoile">
            <button @click="data.isExpoile = false">نمایش نظر حاوی اکسپویل</button>
        </div>
        <div class="topComment">
            <div class="right">
                <img :src="BaseUrl + data.user.profile" alt="">
                <p class="username">{{ data.user.username }} <span> پاسخ به {{ data.answered_to }}</span></p>
            </div>
            <p class="date">{{ data.time }}</p>
        </div>
        <div class="content">
            <div class="text" v-html="data.text"></div>
                <div class="answer" @click="setAnswer({
                    username: data.user.username,
                    answerable_id: data.id,
                    answerable_type: 'Answer',
                    commentId: data.comment_id,
                })">پاسخ</div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/Comment/Comment.css';
</style>