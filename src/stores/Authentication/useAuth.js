import { defineStore } from "pinia";
import { ref } from "vue";

export const useAuth = defineStore('auth', () => {

    let data = ref({});
    let data_type = ref('');

    let canAccessToVerify = ref(false)
    let canAccessToChangePass = ref(false)

    let clearData = () => {
        data.value = {}
        data_type.value = ''
        canAccessToChangePass.value = false
        canAccessToVerify.value = false;
    }

    return { data, data_type, canAccessToVerify, canAccessToChangePass , clearData }

})