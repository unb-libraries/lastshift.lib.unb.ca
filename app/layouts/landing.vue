<script setup lang="ts">
useHead({ title: 'Home' })
</script>

<template>
  <div class="relative min-h-screen overflow-hidden bg-cover bg-center bg-fixed" style="background-image: url('/images/cover.png')">
    <NuxtRouteAnnouncer />
    <div class="absolute left-[5%] top-[41%] -translate-y-1/2">
      <h1 class="mb-0 text-ink text-4xl normal-case tracking-wide sm:text-5xl">
        Last Shift
      </h1>
      <h2 class="mb-0 mt-4 ml-0 text-ink text-xl font-normal not-italic normal-case sm:ml-20 sm:text-2xl">
        <em>the story of a mill town</em>
      </h2>
    </div>
    <div class="absolute inset-x-0 bottom-[25%] text-center text-2xl">
      <slot />
    </div>
    <SiteFooter class="absolute inset-x-0 bottom-0" />
  </div>
</template>
