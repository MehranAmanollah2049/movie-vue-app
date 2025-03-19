<script setup>

import HttpRequest from '@/Api/ApiConfig';
import InputBox from '@/components/Forms/InputBox.vue'
import Loading from '@/components/Loading.vue';
import { toast } from '@/composables/AlertToast';
import { useAuth } from '@/stores/Authentication/useAuth';
import { ref } from 'vue';
import { useRouter } from 'vue-router';

let router = useRouter()
let authStore = useAuth()

let username = ref('')
let phone = ref('')
let password = ref('')

let isLoading = ref(false)

let handleForm = () => {

    if (username.value == '' || phone.value == '' || password.value == '') {
        toast('لطفا اطلاعات خواسته شده را وارد کنید', 'error')
        return
    }

    if (phone.value.length != 11) {
        toast("لطفا یک شماره موبایل معتبر وارد کنید", 'error')
        return
    }

    if (password.value.length < 8) {
        toast("پسورد باید حداقل دارای 8 کاراکتر باشد", 'error')
        return
    }

    if (!isLoading.value) {
        isLoading.value = true;

        HttpRequest.post('/auth/register', {
            username: username.value,
            phone: phone.value,
            password: password.value,
        })
            .then(res => {
                isLoading.value = false;
                if (res != undefined) {
                    authStore.clearData()
                    authStore.data = {
                        username: username.value,
                        phone: phone.value,
                        password: password.value,
                    }
                    authStore.data_type = 1;
                    authStore.canAccessToChangePass = false;
                    authStore.canAccessToVerify = true;

                    toast(`کد تایید برای ${phone.value} ارسال گردید`)

                    username.value = ''
                    password.value = ''
                    phone.value = ''

                    router.push({ name: 'auth.verify' })
                }
            })
            .catch(err => isLoading.value = false)
    }


}

function isAllDigits(inputString) {
    let digitPattern = /^\d+$/;
    return digitPattern.test(inputString);
}
</script>

<template>
    <div class="title">ایجاد حساب کاربری</div>

    <form class="form" @submit.prevent="handleForm">
        <InputBox title="نام کاربری" v-model="username">
            <svg :style="{ width: '18px', height: '18px' }" width="24" height="24" viewBox="0 0 24 24" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M8.20049 15.799C1.3025 8.90022 2.28338 5.74115 3.01055 4.72316C3.10396 4.55862 5.40647 1.11188 7.87459 3.13407C14.0008 8.17945 6.2451 7.46611 11.3894 12.6113C16.5348 17.7554 15.8214 9.99995 20.8659 16.1249C22.8882 18.594 19.4413 20.8964 19.2778 20.9888C18.2598 21.717 15.0995 22.6978 8.20049 15.799Z"
                    stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
        </InputBox>
        <InputBox title="شماره موبایل" :number="true" v-model="phone">
            <svg :style="{ width: '18px', height: '18px' }" width="24" height="24" viewBox="0 0 24 24" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M8.20049 15.799C1.3025 8.90022 2.28338 5.74115 3.01055 4.72316C3.10396 4.55862 5.40647 1.11188 7.87459 3.13407C14.0008 8.17945 6.2451 7.46611 11.3894 12.6113C16.5348 17.7554 15.8214 9.99995 20.8659 16.1249C22.8882 18.594 19.4413 20.8964 19.2778 20.9888C18.2598 21.717 15.0995 22.6978 8.20049 15.799Z"
                    stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
        </InputBox>
        <InputBox title="رمز عبور" v-model="password" type="password">
            <svg width="24px" height="24px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink">
                <g id="Iconly/Light-Outline/Lock" stroke="none" stroke-width="1.5" fill="none" fill-rule="evenodd">
                    <g id="Lock" transform="translate(4.000000, 2.000000)" fill="white">
                        <path
                            d="M8.3749,0.002 C11.2949,0.002 13.6729,2.38 13.6729,5.303 L13.6727875,6.879599 C15.4479968,7.49741017 16.725,9.18740957 16.725,11.1708 L16.725,15.4598 C16.725,17.9648 14.688,20.0018 12.183,20.0018 L4.542,20.0018 C2.037,20.0018 -9.23705556e-14,17.9648 -9.23705556e-14,15.4598 L-9.23705556e-14,11.1708 C-9.23705556e-14,9.18778429 1.27652074,7.49804876 3.05120634,6.87994928 L3.0519,5.303 C3.0579,3.863 3.6149,2.534 4.6199,1.538 C5.6259,0.541 6.9539,-0.036 8.3749,0.002 Z M12.183,8.1288 L4.542,8.1288 C2.864,8.1288 1.5,9.4928 1.5,11.1708 L1.5,15.4598 C1.5,17.1378 2.864,18.5018 4.542,18.5018 L12.183,18.5018 C13.86,18.5018 15.225,17.1378 15.225,15.4598 L15.225,11.1708 C15.225,9.4928 13.86,8.1288 12.183,8.1288 Z M8.3623,11.4546 C8.7763,11.4546 9.1123,11.7906 9.1123,12.2046 L9.1123,14.4256 C9.1123,14.8396 8.7763,15.1756 8.3623,15.1756 C7.9483,15.1756 7.6123,14.8396 7.6123,14.4256 L7.6123,12.2046 C7.6123,11.7906 7.9483,11.4546 8.3623,11.4546 Z M8.3719,1.502 L8.3559,1.502 C7.3429,1.502 6.3939,1.892 5.6769,2.603 C4.9549,3.317 4.5559,4.27 4.5519,5.286 L4.551,6.62823323 L12.172,6.62823323 L12.1729,5.303 C12.1729,3.207 10.4679,1.502 8.3719,1.502 Z"
                            id="Combined-Shape"></path>
                    </g>
                </g>
            </svg>
        </InputBox>

        <button class="submitButton">
            {{ !isLoading ? 'عضویت و ایجاد حساب جدید' : '' }}
            <Loading v-if="isLoading" />
        </button>
    </form>

</template>

<style scoped>
@import '@/assets/css/views/authentication/authentication.css';
</style>