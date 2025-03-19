import { defineStore } from "pinia";
import { ref } from "vue";

export const RouteSaver = defineStore('RouteSaver' , () => {
    let previous = ref('/')

    return {previous}
})