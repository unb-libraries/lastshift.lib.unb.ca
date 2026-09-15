<script setup lang="ts">
defineProps<{ error: { statusCode: number, statusMessage?: string } }>()
</script>

<template>
  <NuxtLayout name="default" title="404">
    <main>
      <h2>
        Sorry, the page you're looking for doesn't exist.
      </h2>
      <p>
        You may have mistyped the address or the page may have been moved.
      </p>
    </main>
  </NuxtLayout>
</template>
