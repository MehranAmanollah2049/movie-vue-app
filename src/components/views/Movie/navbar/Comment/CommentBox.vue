<script setup lang="ts">
import HttpRequest, { BaseUrl } from '@/Api/ApiConfig';
import { toast } from '@/composables/AlertToast';
import { useToken } from '@/stores/Authentication/useToken';
import nprogress from 'nprogress';
import { provide, ref } from 'vue';
import { RouterLink, useRoute } from 'vue-router';


let props = defineProps({
    commentsTotal: [Number,String]
})

let route = useRoute()

let isMoreLoading = ref(false)

let comments = defineModel('comments', {
    type: Array,
    default: []
});

let hasMore = defineModel('hasMore', {
    default: ''
})

let commentsTotal = defineModel('commentsTotal' , {
    default: 0
})

let emits = defineEmits(['update:comments', 'update:hasMore','update:commentsTotal'])

let tokenStore = useToken()
let CommentBox = ref(null)

let comment = ref({
    text: '',
    isExpoile: false
})
let isCommentLoading = ref(false)


let answerableData = ref(null)
let isAnswerLoading = ref(false)

let answer = ref({
    text: '',
    isExpoile: false
})

let toggleIsEspoile = (type) => {
    if (type == 0) {
        comment.value.isExpoile = !comment.value.isExpoile
    }
    else {
        answer.value.isExpoile = !answer.value.isExpoile
    }
}

let addComment = () => {
    if (comment.value.text == '') {
        toast('لطفا متن نظر خود را وارد کنید', 'error')
        return
    }

    if (!isCommentLoading.value) {
        isCommentLoading.value = true
        nprogress.start()

        HttpRequest.post(`/comments/add/${route.params.id}`, {
            text: comment.value.text,
            isExpoile: comment.value.isExpoile,
        })
            .then(res => {

                isCommentLoading.value = false;
                nprogress.done()

                if (res != undefined) {
                    comment.value = {
                        text: '',
                        isExpoile: false
                    }
                    toast("دیدگاه شما با موفقیت ثبت شد");
                    emits('update:comments', res.data.data)
                    emits('update:hasMore', res.data.hasMore == null ? '' : `/comments/${route.params.id}/?page=2`)
                    commentsTotal.value++
                }
            })
            .catch(err => {
                isCommentLoading.value = false;
                nprogress.done()
            })
    }
}

let answerComment = () => {
    if (answer.value.text == '') {
        toast('لطفا متن نظر خود را وارد کنید', 'error')
        return
    }

    if (!isAnswerLoading.value && answerableData.value) {
        isAnswerLoading.value = true
        nprogress.start()

        HttpRequest.post(`/comments/add-answer/${route.params.id}`, {
            text: answer.value.text,
            isExpoile: answer.value.isExpoile,
            ...answerableData.value
        })
            .then(res => {
                isAnswerLoading.value = false;
                nprogress.done()
                if (res != undefined) {
                    answer.value = {
                        text: '',
                        isExpoile: false
                    }
                    answerableData.value = null
                    toast("دیدگاه شما با موفقیت ثبت شد");
                    emits('update:comments', res.data.data)
                    emits('update:hasMore', res.data.hasMore == null ? '' : `/comments/${route.params.id}/?page=2`)
                    commentsTotal.value++
                }
            })
            .catch(err => {
                isAnswerLoading.value = false;
                nprogress.done()
            })
    }
}

let setAnswer = (data) => {
    window.scrollTo({ top: Math.round(CommentBox.value?.getBoundingClientRect().top + document.documentElement.scrollTop) - 100, behavior: 'smooth' })
    answerableData.value = data
}

provide('setAnswer', setAnswer);

let loadMore = () => {
    if (hasMore.value && !isMoreLoading.value) {
        isMoreLoading.value = true
        HttpRequest.get(hasMore.value.replace(BaseUrl + '/api', ''))
            .then(res => {
                console.log(res.data)
                isMoreLoading.value = false
                if (res != undefined) {
                    emits('update:comments', [...comments.value,...res.data.data])
                    emits('update:hasMore', res.data.hasMore == null ? '' : res.data.hasMore)
                }
            })
            .catch(err => isMoreLoading.value = false)
    }
}

</script>

<template>
    <div class="CommentBox" ref="CommentBox">
        <div class="topBox">
            <svg class="icon commentshead_icon">
                <use xlink:href="#commentshead">
                    <symbol viewBox="0 0 80 69" id="commentshead">
                        <path
                            d="M42.0827 12.125H52.916C58.6624 12.125 64.1734 14.4077 68.2367 18.471C72.3 22.5343 74.5827 28.0453 74.5827 33.7917C74.5827 39.538 72.3 45.049 68.2367 49.1123C64.1734 53.1756 58.6624 55.4583 52.916 55.4583V64.9375C39.3743 59.5208 20.416 51.3958 20.416 33.7917C20.416 28.0453 22.6987 22.5343 26.762 18.471C30.8253 14.4077 36.3363 12.125 42.0827 12.125Z"
                            fill="black"></path>
                        <path
                            d="M27.0827 8.125H37.916C43.6624 8.125 49.1734 10.4077 53.2367 14.471C57.3 18.5343 59.5827 24.0453 59.5827 29.7917C59.5827 35.538 57.3 41.049 53.2367 45.1123C49.1734 49.1756 43.6624 51.4583 37.916 51.4583V60.9375C24.3744 55.5208 5.41602 47.3958 5.41602 29.7917C5.41602 24.0453 7.69875 18.5343 11.762 14.471C15.8253 10.4077 21.3363 8.125 27.0827 8.125V8.125Z"
                            fill="#E4810D"></path>
                        <path
                            d="M41 31C41 32.6569 42.3431 34 44 34C45.6569 34 47 32.6569 47 31C47 29.3431 45.6569 28 44 28C42.3431 28 41 29.3431 41 31Z"
                            fill="white"></path>
                        <path
                            d="M17 31C17 32.6569 18.3431 34 20 34C21.6569 34 23 32.6569 23 31C23 29.3431 21.6569 28 20 28C18.3431 28 17 29.3431 17 31Z"
                            fill="white"></path>
                        <path
                            d="M29 31C29 32.6569 30.3431 34 32 34C33.6569 34 35 32.6569 35 31C35 29.3431 33.6569 28 32 28C30.3431 28 29 29.3431 29 31Z"
                            fill="white"></path>
                    </symbol>
                </use>
            </svg>
            <div class="needAuth" v-if="!tokenStore.token">
                <p>برای ثبت نظر خود باید ثبت نام کنید یا وارد شوید</p>
                <div class="buttons">
                    <RouterLink :to="{ name: 'auth.register' }" class="register">عضویت</RouterLink>
                    <RouterLink :to="{ name: 'auth.login' }" class="login">ورود به حساب</RouterLink>
                </div>
            </div>
            <form @submit.prevent="addComment" class="cmt_form" v-if="tokenStore.token && !answerableData">
                <textarea placeholder="دیدگاه خود را تایپ کنید..." v-model="comment.text"></textarea>
                <div class="bottom_form">
                    <div class="isExpoile" @click="toggleIsEspoile(0)">
                        <p>نظر حاوی اکسپویل</p>
                        <div :class="{
                            'checkBoxItem': true,
                            'ischecked': comment.isExpoile
                        }"></div>
                    </div>
                    <button>{{ isCommentLoading ? 'در حال ثبت ...' : 'ارسال دیدگاه' }}</button>
                </div>
            </form>
            <form @submit.prevent="answerComment" class="cmt_form" v-if="tokenStore.token && answerableData">
                <p class="answer_to">پاسخ به کامنت {{ answerableData.username }} : </p>
                <textarea placeholder="دیدگاه خود را تایپ کنید..." v-model="answer.text"></textarea>
                <div class="bottom_form">
                    <div class="isExpoile" @click="toggleIsEspoile(1)">
                        <p>نظر حاوی اکسپویل</p>
                        <div :class="{
                            'checkBoxItem': true,
                            'ischecked': answer.isExpoile
                        }"></div>
                    </div>
                    <button>{{ isAnswerLoading ? 'در حال ثبت ...' : 'ارسال دیدگاه' }}</button>
                </div>
            </form>
            <p class="cmt_num">{{ commentsTotal }} نظر</p>
        </div>
        <div class="bottomComments">
            <slot @setAnswer="setAnswer" />
        </div>

        <div class="loadMoreSection" v-if="hasMore != ''">
            <button class="loadmore" @click="loadMore">{{ isMoreLoading ? 'لطفا منتظر بمانید...' : 'نمایش بیشتر'
                }}</button>
        </div>

    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/Comment/CommentBox.css';
</style>