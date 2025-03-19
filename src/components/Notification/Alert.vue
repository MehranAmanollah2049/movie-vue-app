<script setup>
import { useAlert } from '@/stores/useAlert';
import { computed, onMounted, ref } from 'vue';

let AlertStore = useAlert()

let props = defineProps({
    data: Object
})

let AlertClass = ref('show')

let MarginTop = ref(0);
let AlertItem = ref(null)

let calculateMargin = computed(() => {
    MarginTop.value = (AlertItem.value.clientHeight + 10) * -1
})

onMounted(() => {
    calculateMargin.value
})

let removeAlert = () => {
    AlertClass.value = 'remove';

    setTimeout(() => {
        AlertStore.remove(props.data.id)
    }, 500);
}

</script>

<template>
    <div :class="`Alert ${AlertClass} ${data.type}`" ref="AlertItem" :style="{ '--top': MarginTop + 'px' }">
        <div class="progressBar" :style="{ '--timer': data.timer + 's' }" @animationend="removeAlert"></div>
        <svg v-if="data.type == 'success'" class="icon" xmlns="http://www.w3.org/2000/svg" version="1.1"
            xmlns:xlink="http://www.w3.org/1999/xlink" width="512" height="512" x="0" y="0" viewBox="0 0 24 24"
            style="enable-background:new 0 0 512 512" xml:space="preserve">
            <g>
                <path
                    d="M12 0C5.383 0 0 5.383 0 12s5.383 12 12 12 12-5.383 12-12S18.617 0 12 0Zm6.2 10.512-4.426 4.345a3.984 3.984 0 0 1-2.8 1.151 3.984 3.984 0 0 1-2.776-1.129l-1.899-1.867a1 1 0 1 1 1.402-1.426l1.893 1.861c.776.75 2.001.746 2.781-.018L16.8 9.085a.999.999 0 1 1 1.4 1.427Z"
                    opacity="1" data-original="#000000"></path>
            </g>
        </svg>

        <svg v-if="data.type == 'error'" class="icon" width="24px" height="24px" viewBox="0 0 24 24" version="1.1"
            xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g id="Iconly/Bold/Danger" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g id="Danger" transform="translate(2.000000, 3.000000)" fill-rule="nonzero">
                    <path
                        d="M8.6279014,0.353093862 C9.98767226,-0.400979673 11.7173808,0.0944694301 12.4772527,1.44209099 L12.4772527,1.44209099 L19.7460279,14.057216 C19.9060009,14.4337574 19.9759891,14.7399449 19.9959857,15.0580232 C20.035979,15.8011969 19.7760228,16.5235617 19.2661087,17.0794556 C18.7561947,17.6333677 18.0663109,17.9603641 17.3164373,18 L17.3164373,18 L2.67890388,18 C2.36895611,17.9811729 2.05900834,17.9108192 1.7690572,17.8018204 C0.319301497,17.2171904 -0.380580564,15.5722994 0.20932003,14.1463969 L0.20932003,14.1463969 L7.52808673,1.43317291 C7.77804461,0.986277815 8.15798058,0.600818413 8.6279014,0.353093862 Z M9.99767057,12.2726084 C9.51775145,12.2726084 9.11781884,12.6689677 9.11781884,13.1455897 C9.11781884,13.6202299 9.51775145,14.0175801 9.99767057,14.0175801 C10.4775897,14.0175801 10.867524,13.6202299 10.867524,13.1346898 C10.867524,12.6600496 10.4775897,12.2726084 9.99767057,12.2726084 Z M9.99767057,6.09039447 C9.51775145,6.09039447 9.11781884,6.47585387 9.11781884,6.95247591 L9.11781884,6.95247591 L9.11781884,9.75572693 C9.11781884,10.2313581 9.51775145,10.6287083 9.99767057,10.6287083 C10.4775897,10.6287083 10.867524,10.2313581 10.867524,9.75572693 L10.867524,9.75572693 L10.867524,6.95247591 C10.867524,6.47585387 10.4775897,6.09039447 9.99767057,6.09039447 Z">
                    </path>
                </g>
            </g>
        </svg>

        <svg v-if="data.type == 'warning'" class="icon" xmlns="http://www.w3.org/2000/svg" version="1.1"
            xmlns:xlink="http://www.w3.org/1999/xlink" width="512" height="512" x="0" y="0" viewBox="0 0 512 512"
            style="enable-background:new 0 0 512 512" xml:space="preserve">
            <g>
                <path
                    d="M256 512c141.385 0 256-114.615 256-256S397.385 0 256 0 0 114.615 0 256c.153 141.322 114.678 255.847 256 256zm-21.333-384c0-11.782 9.551-21.333 21.333-21.333 11.782 0 21.333 9.551 21.333 21.333v170.667c0 11.782-9.551 21.333-21.333 21.333-11.782 0-21.333-9.551-21.333-21.333V128zM256 384c11.782 0 21.333 9.551 21.333 21.333s-9.551 21.333-21.333 21.333c-11.782 0-21.333-9.551-21.333-21.333S244.218 384 256 384z"
                    opacity="1" data-original="#000000"></path>
            </g>
        </svg>

        <p class="title">{{ data.title }}</p>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Notification/Alert.css';
</style>