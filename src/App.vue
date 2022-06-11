<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { ref } from 'vue'

const cityName = ref("Bucharest, RO");

</script>

<template>
  <header class="flex items-center justify-between gap-2 p-5">
    <span class="text-4xl">&#127774;</span>
    <span class="text-4xl hidden md:block">VueWeather</span>
    <span class="flex-grow"></span>
    <div class="flex items-center justify-center gap-2">
      <input id="cityName"
        type="text"
        class="text-black p-2"
        v-model="cityName"
        @change="$router.push('/cities/' + cityName)"
      >
      <button class="text-4xl"
        @click="$router.push('/cities/' + cityName)"
      >
          &#8635;
      </button>
    </div>
    <!--
    <span class="text-9xl">&#9728;</span>
    <span class="text-9xl">&#9729;</span>
    <span class="text-9xl">&#9788;</span>
    <img alt="Vue logo" class="p-3" src="@/assets/logo.svg" width="125" height="125" />
    <nav class="flex gap-2">
      <RouterLink to="/">Home</RouterLink>
      <RouterLink to="/about">About</RouterLink>
    </nav>
    -->
  </header>

  <RouterView />
</template>

<style>
@import '@/assets/base.css';

#app {
}

</style>
