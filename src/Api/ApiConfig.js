import { toast } from "@/composables/AlertToast"
import { useToken } from "@/stores/Authentication/useToken"
import axios from "axios"


const BaseUrl = 'http://localhost:8000'

const HttpRequest = axios.create({
    baseURL: BaseUrl + '/api',
    headers: {
        'Accept': 'appilcation/json',
        'Content-Type': 'appilcation/json',
    }
})

HttpRequest.interceptors.request.use(async (config) => {
    let TokenStore = useToken()
    config.headers['Authorization'] = `Bearer ${TokenStore.token}`;
    return config;
})

HttpRequest.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error?.response?.status == 422) {
            toast(error.response.data.error, 'error', 6)
        }
    }
);

export default HttpRequest
export {BaseUrl}