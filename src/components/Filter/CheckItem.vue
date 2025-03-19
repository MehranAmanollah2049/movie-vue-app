<script setup>
import Loading from '@/components/Loading.vue';
import { toast } from '@/composables/AlertToast';


let props = defineProps({
    data: Object,
    isActive: {
        type: Boolean,
        default: false
    },
    parent: String,
    isMultipleSelect: {
        type: Boolean,
        default: true
    },
    isRequestBlocked: {
        type: Boolean,
        default: false
    },
    selectedFilter: [Object,Number,String]
})

let emits = defineEmits(['FilterEvent'])

let handleSelect = () => {
    if (!props.isRequestBlocked && !props.data.isLoading) {
        let newContent = newData()
        emits('FilterEvent' , props.data.id,props.parent,newContent)    
    }
    else {
        toast('لطفا منتظر بمانید...', 'warning', 3)
    }
}

let newData = () => {
    let currentData = null

    if (props.isMultipleSelect) {
        currentData = [...props.selectedFilter]
        if (currentData.includes(props.data.val)) {
            currentData = currentData.filter(item => item != props.data.val)
        }
        else {
            currentData.push(props.data.val)
        }
    }
    else {
        currentData = props.selectedFilter
        if (currentData == props.data.val) {
            currentData = -1;
        }
        else {
            currentData = props.data.val
        }
    }

    return currentData
}

</script>

<template>
    <div :class="{
        'CheckBox': true,
        'radio': !isMultipleSelect,
        'active': isActive
    }" @click="handleSelect">
        <div class="selectBox">
            <Loading v-if="data.isLoading" />
            <svg v-if="!data.isLoading && isActive" width="56" height="40" viewBox="0 0 56 40" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M53.5978 8.60487C55.5504 6.65225 55.5504 3.48642 53.5978 1.5338C51.6451 -0.418819 48.4793 -0.418819 46.5267 1.5338L20.4493 27.6112L9.18202 16.3439C7.2294 14.3913 4.06357 14.3913 2.11095 16.3439C0.158329 18.2965 0.158329 21.4624 2.11095 23.415L16.9164 38.2204C18.869 40.173 22.0348 40.173 23.9874 38.2204C24.0332 38.1746 24.0779 38.1282 24.1215 38.0811L53.5978 8.60487Z">
                </path>
            </svg>
        </div>
        <p class="text">{{ data.title }}</p>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Filter/CheckItem.css';
</style>