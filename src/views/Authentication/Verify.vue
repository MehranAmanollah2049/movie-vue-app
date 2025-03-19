<script setup>

import InputBox from '@/components/Forms/InputBox.vue'
import Loading from '@/components/Loading.vue';
import { toast } from '@/composables/AlertToast';
import { useAuth } from '@/stores/Authentication/useAuth';
import { computed, onMounted, ref } from 'vue';
import HttpRequest from '../../Api/ApiConfig';
import { useUser } from '@/stores/Authentication/useUser';
import { useToken } from '@/stores/Authentication/useToken';
import { useRouter } from 'vue-router';
import { RouteSaver } from '@/stores/RouteSaver';

let authStore = useAuth()
let userStore = useUser()
let tokenStore = useToken()
let routeStore = RouteSaver() 

let router = useRouter()

let isLoading = ref(false)
let isResendLoading = ref(false)

let code = ref('')

let timer = ref(0);

onMounted(() => {
    setTimer()
})

let setTimer = (seconds = 60) => {

    timer.value = seconds;

    let set = setInterval(() => {

        if(timer.value <= 0) {
            clearInterval(set)
            timer.value = 0
        }
        else {
            timer.value--
        }

    }, 1000);

}

let handleForm = () => {

    if(code.value == '' || code.value.length != 6) {
        toast('لطفا کد 6 رقمی رو به درستی وارد کنید','error')
        return
    }

    if(!isLoading.value)
    {
        isLoading.value = true

        HttpRequest.post('/auth/verify' , {
            'code': code.value,
            'phone': authStore.data.phone,
            'data': authStore.data,
            'data_type': authStore.data_type,
        })
        .then(res => {

            isLoading.value = false
            if(res != undefined)
            {
                code.value = ''
                if(authStore.data_type == 1)
                {
                    authStore.clearData()

                    userStore.user = res.data.user;
                    tokenStore.setToken(res.data.token)

                    toast(`${res.data.user.username} عزیز خوش آمدید`);
                    router.push(routeStore.previous);
                }
                else {
                    authStore.canAccessToChangePass = true
                    authStore.canAccessToVerify = false;

                    toast('شماره موبایل شما با موفقیت تایید شد');
                    router.push('/auth/change-password');
                }
            }
        })
        .catch(err => isLoading.value = false)
    }
}

let resend = () => {
    if(!isResendLoading.value)
    {
        isResendLoading.value = true;
        HttpRequest.post('/auth/resend' , {
            phone: authStore.data.phone,
        })
        .then(res => {
            isResendLoading.value = false
            if(res != undefined)
            {
                setTimer()
                code.value = ''
                toast(`کد تایید مجددا برای شماره ${authStore.data.phone} ارسال گردید`)
            }
        })
        .catch(err => isResendLoading.value = false)
    }
}

let timeLeft = computed(() => {
    let mins = Math.floor(timer.value / 60)
    let secs = Math.floor(timer.value % 60)

    return `${mins < 10 ? '0' + mins : mins}:${secs < 10 ? '0' + secs : secs}`
}) 

</script>

<template>
    <div class="title">تایید شماره موبایل</div>

    <form class="form" @submit.prevent="handleForm">
        <InputBox title="کد 6 رقمی" v-model="code" :center="true" customClass="verify-int"></InputBox>
       
        <div class="timer" v-if="timer > 0">ارسال مجدد کد تا <span>{{ timeLeft }}</span> دیگر</div>
        <div class="timer resend" v-if="timer <= 0" @click="resend">
            <span v-if="!isResendLoading">ارسال مجدد کد تایید</span>
            <span v-if="isResendLoading">در حال ارسال ...</span>
        </div>

        <button class="submitButton">
            {{ !isLoading ? 'تایید و ادامه' : '' }}
            <Loading v-if="isLoading" />
        </button>
    </form>

</template>

<style scoped>
@import '@/assets/css/views/authentication/authentication.css';
</style>