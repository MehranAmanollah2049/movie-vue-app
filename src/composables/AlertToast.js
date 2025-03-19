import { useAlert } from "@/stores/useAlert"

export const toast = (title,type = 'success' , timer = 5) => {

    let AlertStore = useAlert();

    AlertStore.create({
        title,
        type,
        timer
    });

}