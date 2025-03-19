<script setup>
import HttpRequest from '@/Api/ApiConfig';
import Loading from '@/components/Loading.vue';
import { ref } from 'vue';


let props = defineProps({
    data: Object
})

let isLoading = ref(false)

let download = () => {
    if (!isLoading.value) {
        isLoading.value = true
        HttpRequest.post(`/download/series/${props.data.id}`)
            .then(res => {
                isLoading.value = false
                if (res != undefined) {
                    // window.open(res.data, '_blank');
                    window.location.href = res.data
                }
            })
            .catch(err => isLoading.value = false)
    }
}

</script>

<template>
    <div class="SeriesLink" @click="download">
        <Loading v-if="isLoading" />
        {{ !isLoading ? data.title : '' }}
    </div>
</template>

<style scoped>
@import '@/assets/css/views/Movie/navbar/download/SeriesDownload/SeriesLink.css';
</style>