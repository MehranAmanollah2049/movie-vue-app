import { defineStore } from "pinia";
import { ref } from "vue";

export const useToken = defineStore('token' , () => {

    let token = ref(localStorage.getItem("token"));

    let setToken = (value) => {
        token.value = value;
        localStorage.setItem("token",value)
    }

    let deleteToken = () => {
        token.value = null;
        localStorage.removeItem("token")
    }

    return {token,setToken,deleteToken}

});