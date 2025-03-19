<script setup>
import HttpRequest from '@/Api/ApiConfig';
import Loading from '@/components/Loading.vue';
import Header from '@/components/views/Movie/Header.vue';
import NavItem from '@/components/views/Movie/NavItem.vue';
import DownloadMovieBox from '@/components/views/Movie/navbar/download/MovieDownload/DownloadMovieBox.vue';
import DownloadSection from '@/components/views/Movie/navbar/download/MovieDownload/DownloadSection.vue';
import Link from '@/components/views/Movie/navbar/download/MovieDownload/Link.vue';
import Season from '@/components/views/Movie/navbar/download/SeriesDownload/Season.vue';
import DownloadSeriesSection from '@/components/views/Movie/navbar/download/SeriesDownload/DownloadSeriesSection.vue';
import SeriesLink from '@/components/views/Movie/navbar/download/SeriesDownload/SeriesLink.vue';
import CommentBox from '@/components/views/Movie/navbar/Comment/CommentBox.vue';
import Comment from '@/components/views/Movie/navbar/Comment/Comment.vue';
import Answer from '@/components/views/Movie/navbar/Comment/Answer.vue';
import QuestionsBox from '@/components/views/Movie/navbar/FAQ/QuestionsBox.vue';
import QuestionItem from '@/components/views/Movie/navbar/FAQ/QuestionItem.vue';
import { toast } from '@/composables/AlertToast';
import nProgress from 'nprogress';
import { computed, onBeforeUnmount, onMounted, ref , watch } from 'vue';
import { useRoute } from 'vue-router';
import DownloadSeriesBox from '@/components/views/Movie/navbar/download/SeriesDownload/DownloadSeriesBox.vue';

let route = useRoute()

let isLoading = ref(true);
let isCommentLoading = ref(true);
let data = ref({});
let comments = ref([])
let hasMore = ref('')
let commentsTotal = ref(0)

let navBarContainer = ref(null)

let navBarActive = ref(0)

onMounted(() => loadMovieData())

watch(route, () => loadMovieData())

let loadMovieData = async () => {
    nProgress.start();

    await HttpRequest.get(`/movie/${route.params.id}`)
        .then(res => {
            isLoading.value = false;
            if (res != undefined) {
                data.value = res.data
            }
        })
        .catch(err => isLoading.value = false)

    await HttpRequest.get(`/comments/${route.params.id}`)
        .then(res => {
            isCommentLoading.value = false
            if (res != undefined) {
                comments.value = res.data.data
                commentsTotal.value = res.data.total
                hasMore.value = res.data.hasMore == null ? '' : res.data.hasMore
            }
        })
        .catch(err => isCommentLoading.value = false)

    nProgress.done();
}

let MovieType = computed(() => {
    return data.value?.type == 0 ? 'فیلم' : 'سریال';
})

onBeforeUnmount(() => {
    nProgress.done()
})


</script>

<template>
    <Header :data="data" :isLoading="isLoading" :MovieType="MovieType" />
    <div class="navBarContainer" ref="navBarContainer">
        <div class="navBarContent">
            <NavItem title="باکس های دانلود" :isActive="navBarActive == 0" @clickEvent="navBarActive = 0">
                <svg class="icon">
                    <use xlink:href="#document_cloud">
                        <symbol viewBox="0 0 100 100" id="document_cloud">
                            <path
                                d=" M 33.25 5.32 C 42.04 5.17 50.83 5.27 59.62 5.27 C 71.35 16.94 83.02 28.65 94.71 40.35 C 94.69 45.16 94.92 49.98 94.66 54.79 C 94.49 58.07 89.19 58.10 88.60 54.97 C 88.33 51.57 88.56 48.15 88.50 44.75 C 80.63 44.36 72.49 45.80 64.83 43.42 C 59.41 41.77 56.08 36.38 55.56 30.94 C 54.88 24.49 55.42 17.98 55.25 11.50 C 44.21 12.07 32.58 9.80 22.06 14.09 C 14.68 17.21 11.95 25.64 11.61 33.03 C 11.34 43.34 11.58 53.67 11.49 63.99 C 11.65 70.96 12.72 78.93 18.46 83.65 C 24.04 88.24 31.64 88.25 38.48 88.70 C 41.63 89.23 41.19 94.76 37.95 94.69 C 27.90 95.12 16.07 92.90 10.18 83.86 C 3.69 73.77 5.52 61.29 5.25 49.94 C 5.51 38.83 3.77 26.72 9.80 16.73 C 14.56 8.65 24.41 5.70 33.25 5.32 M 61.50 15.88 C 62.02 22.46 59.90 30.12 64.19 35.79 C 69.86 40.11 77.53 37.98 84.12 38.50 C 76.59 30.95 69.05 23.41 61.50 15.88 Z">
                            </path>
                            <path
                                d=" M 56.80 60.83 C 62.47 53.89 74.28 52.75 80.64 59.34 C 82.80 61.39 83.96 64.17 85.05 66.88 C 91.89 69.21 96.16 76.87 94.46 83.91 C 93.21 90.03 87.30 94.70 81.09 94.74 C 73.09 94.75 65.09 94.78 57.09 94.73 C 51.83 94.73 47.20 90.16 46.86 84.97 C 46.28 80.25 49.13 75.67 53.38 73.71 C 52.87 69.20 53.67 64.30 56.80 60.83 M 66.53 61.73 C 63.17 62.70 60.35 65.49 59.69 68.98 C 58.78 71.98 61.25 74.94 60.14 77.88 C 58.84 79.71 56.01 78.91 54.49 80.47 C 52.00 82.86 53.20 88.26 56.98 88.41 C 64.66 88.64 72.35 88.43 80.04 88.51 C 82.97 88.65 85.99 87.23 87.46 84.63 C 89.36 81.58 88.64 77.35 86.09 74.90 C 84.57 73.10 82.05 73.02 80.09 71.98 C 78.83 70.28 78.81 67.96 77.82 66.10 C 75.94 61.98 70.66 60.28 66.53 61.73 Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
            </NavItem>
            <NavItem title="نظرات و انتقادات" :isActive="navBarActive == 1" :count="commentsTotal"
                @clickEvent="navBarActive = 1">
                <svg class="icon">
                    <use xlink:href="#message">
                        <symbol viewBox="0 0 20 21" id="message">
                            <path
                                d="M9.99935 19.5082C9.42435 19.5082 8.88268 19.2165 8.49935 18.7082L7.24935 17.0415C7.22435 17.0082 7.12435 16.9665 7.08268 16.9582H6.66602C3.19102 16.9582 1.04102 16.0165 1.04102 11.3332V7.1665C1.04102 3.48317 2.98268 1.5415 6.66602 1.5415H13.3327C17.016 1.5415 18.9577 3.48317 18.9577 7.1665V11.3332C18.9577 15.0165 17.016 16.9582 13.3327 16.9582H12.916C12.8493 16.9582 12.791 16.9915 12.7493 17.0415L11.4993 18.7082C11.116 19.2165 10.5743 19.5082 9.99935 19.5082ZM6.66602 2.7915C3.68268 2.7915 2.29102 4.18317 2.29102 7.1665V11.3332C2.29102 15.0998 3.58268 15.7082 6.66602 15.7082H7.08268C7.50768 15.7082 7.99101 15.9498 8.24935 16.2915L9.49935 17.9582C9.79101 18.3415 10.2077 18.3415 10.4993 17.9582L11.7493 16.2915C12.0243 15.9248 12.4577 15.7082 12.916 15.7082H13.3327C16.316 15.7082 17.7077 14.3165 17.7077 11.3332V7.1665C17.7077 4.18317 16.316 2.7915 13.3327 2.7915H6.66602Z">
                            </path>
                            <path
                                d="M9.99935 10.5002C9.53268 10.5002 9.16602 10.1252 9.16602 9.66683C9.16602 9.2085 9.54102 8.8335 9.99935 8.8335C10.4577 8.8335 10.8327 9.2085 10.8327 9.66683C10.8327 10.1252 10.466 10.5002 9.99935 10.5002Z">
                            </path>
                            <path
                                d="M13.3333 10.4999C12.8667 10.4999 12.5 10.1249 12.5 9.66659C12.5 9.20825 12.875 8.83325 13.3333 8.83325C13.7917 8.83325 14.1667 9.20825 14.1667 9.66659C14.1667 10.1249 13.8 10.4999 13.3333 10.4999Z">
                            </path>
                            <path
                                d="M6.66732 10.5002C6.20065 10.5002 5.83398 10.1252 5.83398 9.66683C5.83398 9.2085 6.20898 8.8335 6.66732 8.8335C7.12565 8.8335 7.50065 9.2085 7.50065 9.66683C7.50065 10.1252 7.13398 10.5002 6.66732 10.5002Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
            </NavItem>
            <NavItem title="سوالات متداول" :isActive="navBarActive == 2" @clickEvent="navBarActive = 2">
                <svg class="icon">
                    <use xlink:href="#faq">
                        <symbol viewBox="0 96 960 960" id="faq">
                            <path
                                d="M549.999 686.769q14.692 0 25.654-10.962 10.961-10.961 10.961-25.653 0-14.693-10.961-25.654-10.962-10.961-25.654-10.961T524.346 624.5q-10.962 10.961-10.962 25.654 0 14.692 10.962 25.653 10.961 10.962 25.653 10.962Zm0-120.308q9.077 0 16.462-6.461 7.384-6.461 8.999-16.384 2-13.923 8.885-24.308t25.808-28.539q27.692-26.538 37.692-44.846 10-18.307 10-42.538 0-42.692-30.154-70.423t-77.692-27.731q-30.692 0-56.153 14.231-25.462 14.231-40.692 40.692-4.847 8.077-1 16.962Q456 386 465.307 389.846q8.692 3.846 17.461.808 8.769-3.039 14.231-11.115 9.769-14.539 22.923-21.808 13.154-7.27 30.077-7.27 26.308 0 43.231 15.231 16.924 15.231 16.924 40.154 0 15.154-8.577 28.424-8.577 13.269-29.731 32.654-25.923 22.307-34.308 36.769-8.384 14.461-10.384 38.923-1 9.307 5.769 16.576t17.076 7.269ZM322.308 795.999q-30.308 0-51.307-21-21-21-21-51.308V268.309q0-30.308 21-51.308 20.999-21 51.307-21h455.383q30.307 0 51.307 21 21 21 21 51.308v455.382q0 30.308-21 51.308t-51.307 21H322.308Zm0-59.999h455.383q4.615 0 8.462-3.846 3.846-3.847 3.846-8.463V268.309q0-4.616-3.846-8.463-3.847-3.846-8.462-3.846H322.308q-4.616 0-8.462 3.846-3.847 3.847-3.847 8.463v455.382q0 4.616 3.847 8.463 3.846 3.846 8.462 3.846ZM182.309 935.997q-30.307 0-51.307-21-21-21-21-51.307V378.308q0-12.769 8.615-21.384 8.616-8.615 21.384-8.615 12.769 0 21.385 8.615 8.615 8.615 8.615 21.384V863.69q0 4.616 3.846 8.462 3.847 3.847 8.462 3.847h485.382q12.769 0 21.385 8.615 8.615 8.615 8.615 21.384t-8.615 21.384q-8.616 8.615-21.385 8.615H182.309ZM309.999 256v480-480Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
            </NavItem>
        </div>
    </div>
    <div class="main_content_container">
        <div class="main_content">

            <div class="loadingBox_spinner" v-if="isLoading && navBarActive == 0">
                <Loading title="در حال دریافت لینک ها ..." :isUnder="true" />
            </div>

            <div class="loadingBox_spinner" v-if="isCommentLoading && navBarActive == 1">
                <Loading title="در حال دریافت نظرات ها ..." :isUnder="true" />
            </div>

            <!-- download boxes -->
            <DownloadMovieBox v-if="!isLoading && data.type == 0 && navBarActive == 0">
                <DownloadSection :type="2" v-if="data.links.type_2.length">
                    <Link :type="2" v-for="link in data.links.type_2" :key="link.id" :data="link" />
                </DownloadSection>
                <DownloadSection :type="0" v-if="data.links.type_0.length">
                    <Link :type="0" v-for="link in data.links.type_0" :key="link.id" :data="link" />
                </DownloadSection>
                <DownloadSection :type="1" v-if="data.links.type_1.length">
                    <Link :type="1" v-for="link in data.links.type_1" :key="link.id" :data="link" />
                </DownloadSection>
            </DownloadMovieBox>

            <DownloadSeriesBox v-if="!isLoading && data.type == 1 && navBarActive == 0">
                <Season v-for="season in data.links_series" :key="season.id" :data="season">
                    <DownloadSeriesSection v-for="section in season.sections" :key="section.id" :data="section"
                        :type="Number(section.type)">
                        <SeriesLink v-for="episode in section.episodes" :key="episode.id" :data="episode" />
                    </DownloadSeriesSection>
                </Season>
            </DownloadSeriesBox>

            <!-- comment box -->
            <CommentBox v-model:commentsTotal="commentsTotal" v-if="!isCommentLoading && navBarActive == 1"
                v-model:comments="comments" v-model:hasMore="hasMore">
                <Comment v-for="comment in comments" :key="comment.id" :data="comment" v-if="comments.length != 0">
                    <Answer v-for="answer in comment.answers" :key="answer.id" :data="answer"
                        v-if="comment.answers.length != 0" />
                </Comment>
                <div class="emptyComments" v-if="comments.length == 0">
                    <svg width="54" height="54" viewBox="0 0 54 54" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd"
                            d="M27 0C49.2345 0 54 4.00008 54 24C54 37.0001 51.7506 45 41.6256 45C36.2147 45 34.6052 47.5703 33.1064 49.9638C31.8006 52.0491 30.5789 54.0001 27.0006 54C23.4225 53.9999 22.2007 52.049 20.8949 49.9638C19.3961 47.5703 17.7865 45 12.3756 45C2.25055 45 0 36.7442 0 24C0 4.23601 4.7655 0 27 0ZM49.5 24C49.5 13.878 48.1565 9.89799 45.8623 7.87579C44.6944 6.84628 42.8722 5.95738 39.7488 5.35647C36.6026 4.75117 32.4778 4.5 27 4.5C21.5316 4.5 17.4124 4.76523 14.2732 5.38537C11.1583 6.00072 9.32897 6.90538 8.1517 7.95184C5.83648 10.0098 4.5 14.0158 4.5 24C4.5 30.3241 5.09867 34.632 6.41592 37.2668C7.01586 38.4668 7.70279 39.1862 8.47207 39.6441C9.25959 40.1128 10.4585 40.5 12.3756 40.5C15.6095 40.5 18.2372 41.232 20.3756 42.6808C22.433 44.0748 23.6339 45.8794 24.4009 47.0862L24.7092 47.5722C25.3722 48.6189 25.5918 48.9656 25.9024 49.2444L25.9146 49.256C25.9799 49.3197 26.1644 49.5 27.0007 49.5C27.8371 49.5 28.0216 49.3197 28.0867 49.2561L28.0989 49.2445C28.4096 48.9657 28.6291 48.6191 29.2923 47.572L29.6003 47.0864C30.3672 45.8797 31.5681 44.0749 33.6255 42.6809C35.7638 41.232 38.3916 40.5 41.6256 40.5C43.5662 40.5 44.7756 40.119 45.564 39.6594C46.3265 39.2148 47.0012 38.5197 47.5916 37.3489C48.8981 34.7581 49.5 30.4669 49.5 24Z">
                        </path>
                        <path
                            d="M31.5 15.75C30.2573 15.75 29.25 16.7573 29.25 18C29.25 19.2427 30.2573 20.25 31.5 20.25H38.25C39.4927 20.25 40.5 19.2427 40.5 18C40.5 16.7573 39.4927 15.75 38.25 15.75H31.5Z">
                        </path>
                        <path
                            d="M15.75 24.75C14.5073 24.75 13.5 25.7573 13.5 27C13.5 28.2427 14.5073 29.25 15.75 29.25H38.25C39.4927 29.25 40.5 28.2427 40.5 27C40.5 25.7573 39.4927 24.75 38.25 24.75H15.75Z">
                        </path>
                    </svg>
                    <span>هنوز دیدگاهی ثبت نشده</span>
                </div>
            </CommentBox>

            <!-- FAQ -->
            <QuestionsBox v-if="navBarActive == 2">

                <QuestionItem title="توضیحات تکمیلی وبسایت زرفیلم">
                    این وبسایت صرفا جهت تمرین و نمونه کار توسط مهران امان الله پیاده سازی شده و ظاهر وبسایت از وبسایت
                    اصلی زرفیلم الهام گرفته شده است
                </QuestionItem>
                <QuestionItem title="این وبسایت دارای چه بخش های میباشد ؟">
                    این وبسایت علاوه بر ورود و ثبت نام کاربران دارای صفحات اصلی , همه فیلم و سریال ها و صفحه جزییات فیلم
                    و سریال می باشد
                </QuestionItem>
                <QuestionItem title="چرا بعضی از قسمت های وبسایت ارور دسترسی رو میده؟">
                    این بخش ها صرفا جهت زیبا سازی و امکاناتی که در آینده شاید جهت ارتقای وب سایت فعال بشه رو نشون میده و
                    بیشتر جنبه ظاهری داره
                </QuestionItem>
                <QuestionItem title="این وبسایت با چه تکنولوژی هایی توسعه داده شده؟">
                    فرانت وبسایت با Vue.js و سمت سرور آن با Laravel پیاده سازی شده است.
                </QuestionItem>
            </QuestionsBox>

        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/Movie.css';
</style>