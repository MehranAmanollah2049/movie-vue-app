<script setup>
import { RouterView, useRoute  } from 'vue-router'
import NotificationContainer from '@/components/Notification/NotificationContainer.vue';
import Menu from '@/components/Menu/Menu.vue';
import { useUser } from '@/stores/Authentication/useUser';
import Footer from '@/components/Footer/Footer.vue';

let userStore = useUser();
userStore.loadData()

let router = useRoute()

</script>

<template>
  <NotificationContainer />
  <Menu v-if="(!router?.name?.includes('auth'))" />
  <RouterView />
  <Footer v-if="(!router?.name?.includes('auth'))" />
</template>
