<script setup>

let props = defineProps({
    title: String,
    center: {
        type: Boolean,
        default: false
    },
    number: {
        type: Boolean,
        default: false
    },
    customClass: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: 'text'
    }
})

let keydownEvent = (e) => {
    if (props.number && (isNaN(event.key) && event.key !== 'Backspace')) {
        e.preventDefault();
    }
}

let model = defineModel('modelValue' , {
    default: ''
});

let emits = defineEmits(['update:modelValue'])

</script>

<template>
    <div class="inputBox">
        <div class="icon" v-if="$slots.default">
            <slot />
        </div>
        <div :class="{
            'content': true,
            'w-100': !$slots.default,
            'center': center
        }">
            <input :type="type" :class="customClass" :placeholder="title" @keydown="keydownEvent" :value="model" @input="emits('update:modelValue',$event.target.value)">
        </div>
    </div>
</template>

<style scoped>
@import '@/assets/css/components/Forms/Input.css';
</style>