import HttpRequest from "@/Api/ApiConfig";
import { defineStore } from "pinia";
import { ref } from "vue";
import { useToken } from "./useToken";
import nprogress from "nprogress";
import nProgress from "nprogress";
import { toast } from "@/composables/AlertToast";

export const useUser = defineStore('user', () => {

    let TokenStore = useToken()

    // login
    let user = ref(null);
    let userLoading = ref(false);

    // logout
    let logoutLoading = ref(false);

    let loadData = () => {
        if (TokenStore.token) {
            if (!userLoading.value) {
                userLoading.value = true
                HttpRequest.get('/user')
                    .then(res => {
                        if (res != undefined) {
                            userLoading.value = false
                            user.value = res?.data;
                        }
                        else {
                            logoutLoading.value = false
                            user.value = null;
                            TokenStore.deleteToken()
                            userLoading.value = false
                        }
                    })
                    .catch(err => {
                        logoutLoading.value = false
                        user.value = null;
                        TokenStore.deleteToken()
                        userLoading.value = false
                    })
            }
        }
        else {
            userLoading.value = false
        }

    }


    let logOut = () => {
        if (!logoutLoading.value) {
            nProgress.start()
            logoutLoading.value = true
            HttpRequest.delete('/logout')
                .then(res => {
                    nprogress.done()
                    toast("شما از حساب کاربری خود خارج شدید")
                    logoutLoading.value = false
                    user.value = null;
                    TokenStore.deleteToken()
                })
        }
    }


    return { user, userLoading, logoutLoading, loadData, logOut }

});