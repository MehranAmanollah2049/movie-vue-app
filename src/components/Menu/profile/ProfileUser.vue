<script setup>
import { useUser } from '@/stores/Authentication/useUser';
import { BaseUrl } from '@/Api/ApiConfig';

defineProps({
    data: Object
})

let userStore = useUser()

</script>

<template>
    <div class="profile">
        <svg class="icon down_icon">
            <use xlink:href="#down_icon">
                <symbol viewBox="0 0 21 21" id="down_icon">
                    <path
                        d="M10.0973 11.4767L13.6331 7.94082C13.9585 7.61543 14.4861 7.61543 14.8114 7.94082C15.1368 8.26621 15.1368 8.79377 14.8114 9.11915L10.8853 13.0453C10.4501 13.4805 9.74446 13.4805 9.30923 13.0453L5.38311 9.11915C5.05772 8.79377 5.05772 8.26621 5.38311 7.94082C5.7085 7.61543 6.23606 7.61543 6.56145 7.94082L10.0973 11.4767Z">
                    </path>
                </symbol>
            </use>
        </svg>
        <p class="username">{{ data.username }}</p>
        <img :src="BaseUrl + userStore.user.profile" alt="">
        <div class="profileDropDown">
            <div class="logOut" @click="userStore.logOut()">
                <svg class="icon logout_icon">
                    <use xlink:href="#logout">
                        <symbol viewBox="0 0 100 100" id="logout">
                            <path
                                d=" M 50.14 14.20 C 62.94 13.28 76.41 19.90 82.48 31.45 C 88.43 42.97 88.27 57.64 81.63 68.84 C 75.25 79.66 62.37 85.40 50.05 84.82 C 48.18 83.70 46.88 81.36 48.19 79.30 C 49.27 77.18 51.86 77.60 53.81 77.40 C 63.19 76.93 72.50 71.58 76.54 62.92 C 81.74 51.70 80.19 36.76 70.72 28.24 C 65.30 23.30 57.90 21.46 50.73 21.18 C 47.01 21.09 46.70 15.10 50.14 14.20 Z">
                            </path>
                            <path
                                d=" M 46.49 39.03 C 46.50 35.87 51.12 34.90 52.93 37.13 C 56.19 40.25 59.36 43.46 62.51 46.68 C 64.20 48.14 64.32 51.04 62.59 52.51 C 59.24 55.90 55.90 59.31 52.46 62.61 C 50.34 64.76 46.33 62.86 46.44 59.91 C 46.58 56.92 49.62 55.34 51.36 53.25 C 40.57 53.22 29.77 53.31 18.97 53.21 C 15.03 53.04 15.04 46.50 18.90 46.08 C 29.72 45.88 40.55 46.07 51.37 45.99 C 49.64 43.82 46.18 42.21 46.49 39.03 Z">
                            </path>
                        </symbol>
                    </use>
                </svg>
                خروج از حساب کاربری
            </div>
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Menu/profile/profile.css';
</style>