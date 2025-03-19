import { defineStore } from "pinia";
import { ref } from "vue";

export const useAlert = defineStore('alerts' , () => {

    const alerts = ref([]);

    const create = (data) => {
        alerts.value.push({
            id: alerts.value.length + 1,
            ...data
        })
    }
    
    const remove = (id) => {
        alerts.value = alerts.value.filter(alert => alert.id != id);
    }

    return {alerts,create,remove};

});