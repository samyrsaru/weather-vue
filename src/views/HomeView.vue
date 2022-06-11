<script setup lang="ts">
import TheWelcome from '@/components/TheWelcome.vue'
import Weather from '@/components/Weather.vue'
</script>

<template>
  <Weather :cityName="$route.params.cityName ?? 'Bucharest, RO'" />
</template>
