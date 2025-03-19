<script setup>

import HttpRequest from '@/Api/ApiConfig';
import InputBox from '@/components/Forms/InputBox.vue'
import Loading from '@/components/Loading.vue';
import { toast } from '@/composables/AlertToast';
import { useAuth } from '@/stores/Authentication/useAuth';
import { ref } from 'vue';
import { useRouter } from 'vue-router';

let authStore = useAuth()
let router = useRouter()

let phone = ref('')

let isLoading = ref(false)

let handleForm = () => {

    if (phone.value == '' || phone.value.length != 11) {
        toast('لطفا اطلاعات خواسته شده رو وارد کنید', 'error')
        return
    }

    if (!isLoading.value) {
        isLoading.value = true

        HttpRequest.post('/auth/forget-password', {
            phone: phone.value
        })
            .then(res => {
                isLoading.value = false

                if (res != undefined) {
                    authStore.clearData()

                    authStore.data = {
                        phone: phone.value
                    }

                    authStore.data_type = 2;
                    authStore.canAccessToChangePass = false;
                    authStore.canAccessToVerify = true;
                    toast(`کد تایید برای ${phone.value} ارسال گردید`)

                    phone.value = ''

                    router.push({ name: 'auth.verify' })
                }
            })
            .catch(err => isLoading.value = false)
    }
}

</script>

<template>
    <div class="title">بازیابی رمز عبور</div>

    <form class="form" @submit.prevent="handleForm">
        <InputBox title="شماره موبایل" v-model="phone" :number="true">
            <svg :style="{ width: '18px', height: '18px' }" width="24" height="24" viewBox="0 0 24 24" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M8.20049 15.799C1.3025 8.90022 2.28338 5.74115 3.01055 4.72316C3.10396 4.55862 5.40647 1.11188 7.87459 3.13407C14.0008 8.17945 6.2451 7.46611 11.3894 12.6113C16.5348 17.7554 15.8214 9.99995 20.8659 16.1249C22.8882 18.594 19.4413 20.8964 19.2778 20.9888C18.2598 21.717 15.0995 22.6978 8.20049 15.799Z"
                    stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
        </InputBox>

        <button class="submitButton">
            {{ !isLoading ? 'ارسال کد تایید' : '' }}
            <Loading v-if="isLoading" />
        </button>
    </form>

</template>

<style scoped>
@import '@/assets/css/views/authentication/authentication.css';
</style>