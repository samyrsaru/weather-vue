<script setup lang="ts">
import Weather from '@/components/Weather.vue'
</script>

<template>
  <Weather :cityName="$route.params.cityName ?? 'Bucharest, RO'" />
</template>
