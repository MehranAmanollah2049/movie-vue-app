<script setup>
import Alert from '@/components/Notification/Alert.vue'
import { useAlert } from '@/stores/useAlert';


let AlertStore = useAlert();

</script>

<template>
    <div class="NotificationContainer">
        <Alert v-for="alert in AlertStore.alerts" :key="alert.id" :data="alert" />
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Notification/NotificationContainer.css';
</style>